/* SPDX-License-Identifier: GPL-2.0-only */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <errno.h>
#include <linux/perf_event.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>
#define PAGES 128
#define SIZE 4096
#define BOUND 4352
#ifndef OPS
#define OPS 32768
#endif
_Static_assert(OPS>0&&OPS%PAGES==0,"Batch calls must be positive and a multiple of the corpus page count");
static unsigned char input[PAGES][SIZE],packed[PAGES][BOUND],expected[PAGES][BOUND],output[SIZE];
static const char *corpora[]={"random","sparse-words","zero","repeat8","period127","halfzero","word-tail64","repeat32","bash-elf","period127-zero-tail","period509-zero-tail","zerohead-random","words25","words50","words75","mixed-pages","repeat16","clusters25","clusters50","clusters75","sample16-sparse-miss","sample16-dense-hit","sample64-sparse-miss","sample64-dense-hit","git-elf","libc-elf","bash-exec","git-exec","libc-exec","zeroguard-repeat","zeroguard-random","zeroguard-late-prefix","zeroguard-distance1025","zeroguard-distance1024","zerotwoguard-repeat","zerotwoguard-random"};
static const char *policies[]={"trial","sample","recurrence","guard16","guard32","fused","guard32mixed","wordguard","wordmixed","splittail","outlinetail","ctzunpack","wordrepeat","ctzrepeat","bitpack","mixpack","repeatmerge","ctzfull","bitctz","bitfull","select2","select3","select4","repeatmergefast","blockpick2","blockpick3","blockpick4","bitmerge","bitdirect","blockdirect2","blockdirect3","blockdirect4","bitdirectsample16","bitdirectsample64","bitdirectpipe1","bitdirectpipe2","bitdirectpipe4","bitdirectavxbits2","bitdirectavxbits4","bitdirectblock2","bitdirectblock2pipe4","bitdirectblock2avxbits4","bitdirectblock3","bitdirectblock3pipe4","bitdirectblock3avxbits4","bitdirectbounded","bitdirectblock2avxbits4bounded","bitdirectblock3avxbits4bounded","bitdirectblock2avxbits4zeroguardbounded","bitdirectblock2avxbits4zerotwoguardbounded"};
/* 57 base entries plus two ISAs at eight block sizes per hybrid policy.
 * Keep the shuffled indices and codec registry at the same capacity. */
enum { CODEC_CAPACITY=57+16*(sizeof(policies)/sizeof(policies[0])) };
static int sizes[PAGES],fds[4]={-1,-1,-1,-1},energy_fd=-1;static uint64_t seed=100,order_seed=100,energy_range;
static uint32_t rnd(void){seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;return (uint32_t)seed;}
static uint32_t order_random(void){order_seed^=order_seed<<13;order_seed^=order_seed>>7;order_seed^=order_seed<<17;return (uint32_t)order_seed;}
static uint64_t now(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
static uint64_t cpu_now(void){struct timespec t;if(clock_gettime(CLOCK_THREAD_CPUTIME_ID,&t)){perror("thread CPU clock");exit(15);}return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
static int read_counter(const char *path,uint64_t *value){FILE *f=fopen(path,"r");if(!f)return 0;int ok=fscanf(f,"%lu",value)==1;fclose(f);return ok;}
static int energy(uint64_t *value){
 if(!energy_range)return 0;
 if(energy_fd<0)return read_counter("/sys/class/powercap/intel-rapl:0/energy_uj",value);
 char buffer[64];ssize_t size=pread(energy_fd,buffer,sizeof(buffer)-1,0);
 if(size<=0)return 0;
 buffer[size]=0;return sscanf(buffer,"%lu",value)==1;
}
static void setup_perf(void){
 const uint64_t configs[]={PERF_COUNT_HW_CPU_CYCLES,PERF_COUNT_HW_INSTRUCTIONS,PERF_COUNT_HW_BRANCH_MISSES,PERF_COUNT_HW_CACHE_MISSES};
 for(int i=0;i<4;i++){
  struct perf_event_attr a={.type=PERF_TYPE_HARDWARE,.size=sizeof(a),.config=configs[i],.exclude_kernel=1,.exclude_hv=1,.disabled=i==0,.read_format=PERF_FORMAT_GROUP|PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING};
  fds[i]=syscall(SYS_perf_event_open,&a,0,-1,i?fds[0]:-1,0);
  if(fds[i]<0){fprintf(stderr,"PMU group unavailable: %s\n",strerror(errno));for(int j=0;j<i;j++)close(fds[j]);fds[0]=-1;return;}
 }
}
static void begin(void){if(fds[0]>=0&&(ioctl(fds[0],PERF_EVENT_IOC_RESET,PERF_IOC_FLAG_GROUP)||ioctl(fds[0],PERF_EVENT_IOC_ENABLE,PERF_IOC_FLAG_GROUP))){perror("PMU begin");exit(12);}}
static void end(double *counts,double *fraction){
 for(int i=0;i<4;i++)counts[i]=-1;
 *fraction=-1;if(fds[0]<0)return;
 uint64_t v[7];if(ioctl(fds[0],PERF_EVENT_IOC_DISABLE,PERF_IOC_FLAG_GROUP)||read(fds[0],v,sizeof(v))!=sizeof(v)||v[0]!=4||!v[1]||!v[2]){fprintf(stderr,"Invalid PMU group read\n");exit(13);}
 *fraction=(double)v[2]/v[1];for(int i=0;i<4;i++)counts[i]=(double)v[3+i]/OPS;
}
typedef int (*gz_enc)(const void*,size_t,void*,size_t,unsigned);
typedef int (*gz_dec)(const void*,size_t,void*,size_t);
typedef int (*lz_enc)(const void*,void*,int,int,void*);
typedef int (*lz_dec)(const void*,void*,int,int);
struct codec{char name[64];unsigned log;int lz4;gz_enc comp;gz_dec dec;};
static lz_enc baseline_enc;static lz_dec baseline_dec;static _Alignas(8) unsigned char workspace[32768];
static int encode(struct codec *v,unsigned p,void *dst){return v->lz4?baseline_enc(input[p],dst,SIZE,BOUND,workspace):v->comp(input[p],SIZE,dst,BOUND,v->log);}
static int decode(struct codec *v,unsigned p){return v->lz4?baseline_dec(packed[p],output,sizes[p],SIZE):v->dec(packed[p],(size_t)sizes[p],output,SIZE);}
/* Existing 26 fixtures remain the default and retain their generation seeds.
 * Extra file-page fixtures are explicit, immutable inputs with their own manifest. */
static int corpus_visible(unsigned kind){
 if(kind<26)return 1;
 const char *path=getenv(kind<29?"GZRAM_EXEC_CORPUS_DIR":"GZRAM_ZERO_GUARD_FIXTURES");
 return path&&*path;
}
static void fill(int kind){
 seed=100+(unsigned)kind;
 if(kind>=29){
  /* Construct both favorable and adversarial selection cases. This fixture is
   * explicitly opt-in; earlier corpus seeds and bytes remain unchanged. */
  for(unsigned p=0;p<PAGES;p++){
   uint32_t values[8];for(unsigned j=0;j<8;j++)values[j]=rnd()|1U;
   for(unsigned word=0;word<SIZE/4;word++){
    uint32_t value=rnd()%4?0:((kind==30||kind==35)?(rnd()|1U):values[rnd()%8]);
    memcpy(input[p]+word*4,&value,4);
   }
   memset(input[p],0,kind==31?72:8);
   unsigned anchor=kind==31?72:8;
   unsigned next=kind==32?anchor+1025:kind==33?anchor+1024:anchor+248;
   memcpy(input[p]+anchor,"ABCDWXYZ",8);memcpy(input[p]+next,"ABCDWXYZ",8);
   if(kind>=34)memcpy(input[p]+anchor+504,"ABCDWXYZ",8);
  }
  return;
 }
 if(kind>=26){
  const char *directory=getenv("GZRAM_EXEC_CORPUS_DIR");char path[4096];
  int length=directory?snprintf(path,sizeof(path),"%s/%s.bin",directory,corpora[kind]):-1;
  if(length<0||(size_t)length>=sizeof(path)){fprintf(stderr,"Missing/invalid extra corpus directory\n");exit(4);}
  FILE *file=fopen(path,"rb");
  if(!file||fread(input,1,sizeof(input),file)!=sizeof(input)||fgetc(file)!=EOF||ferror(file)){
   fprintf(stderr,"Extra corpus must contain exactly 128 pages: %s\n",path);exit(4);
  }
  fclose(file);return;
 }

 if(kind>=20&&kind<=23){
  /* Deliberate sampling false negatives/positives. Preserve these regressions:
   * sparse pages with every sampled word nonzero, and dense pages with only
   * sampled words zero. No sample may be treated as a full-page proof. */
  unsigned samples=kind<22?16:64,stride=(SIZE/4)/samples;int dense=kind&1;
  for(unsigned p=0;p<PAGES;p++)for(unsigned word=0;word<SIZE/4;word++){
   uint32_t value=dense?(rnd()|1U):0;
   if(word%stride==0)value=dense?0:(rnd()|1U);
   memcpy(input[p]+word*4,&value,4);
  }
  return;
 }
 if(kind==24||kind==25){
  const char *path=kind==24?"/usr/bin/git":"/usr/lib64/libc.so.6";
  FILE *f=fopen(path,"rb");
  if(!f||fread(input,1,sizeof(input),f)!=sizeof(input)){fprintf(stderr,"ELF fixture unavailable: %s\n",path);exit(4);}
  fclose(f);return;
 }
 if(kind>=17&&kind<=19){
  unsigned present=(unsigned)kind-16;
  for(unsigned p=0;p<PAGES;p++)for(unsigned at=0;at<SIZE;at+=32){
   int full=rnd()%4<present;
   for(unsigned lane=0;lane<8;lane++){uint32_t word=full?(rnd()|1U):0;memcpy(input[p]+at+lane*4,&word,4);}
  }
  return;
 }
 if(kind==16){for(unsigned p=0;p<PAGES;p++)for(unsigned i=0;i<SIZE;i++)input[p][i]=(unsigned char)(i%16+p*37);return;}
 if(kind>=12&&kind<=14){
  unsigned present=(unsigned)kind-11;
  for(unsigned p=0;p<PAGES;p++)for(unsigned i=0;i<SIZE;i+=4){
   uint32_t word=rnd()%4<present?(rnd()|1U):0;memcpy(input[p]+i,&word,4);
  }
  return;
 }
 if(kind==15){
  /* Interleave executable, sparse, incompressible and mixed periodic pages.
   * Preserve every original corpus and its independent generation seed. */
  FILE*f=fopen("/usr/bin/bash","rb");if(!f||fread(input,1,sizeof(input),f)!=sizeof(input)){fprintf(stderr,"Bash fixture unavailable\n");exit(4);}fclose(f);
  for(unsigned p=0;p<PAGES;p++){
   if(p%4==1)for(unsigned i=0;i<SIZE;i+=4){uint32_t word=rnd()%8?0:rnd();memcpy(input[p]+i,&word,4);}
   else if(p%4==2)for(unsigned i=0;i<SIZE;i++)input[p][i]=(unsigned char)rnd();
   else if(p%4==3)for(unsigned i=0;i<SIZE;i++)input[p][i]=i<2048?(unsigned char)((i%127)*37+p):0;
  }
  return;
 }
 if(kind==11){for(unsigned p=0;p<PAGES;p++)for(unsigned i=0;i<SIZE;i++)input[p][i]=i<64?0:(unsigned char)rnd();return;}
 if(kind==10){
  for(unsigned p=0;p<PAGES;p++){
   unsigned char pattern[509];uint32_t r=100+p;
   for(unsigned j=0;j<509;j++){r^=r<<13;r^=r>>17;r^=r<<5;pattern[j]=(unsigned char)r;}
   for(unsigned i=0;i<SIZE;i++)input[p][i]=i<2048?pattern[i%509]:0;
  }
  return;
 }
 if(kind==9){for(unsigned p=0;p<PAGES;p++)for(unsigned i=0;i<SIZE;i++)input[p][i]=i<2048?(unsigned char)((i%127)*37+p):0;return;}

 if(kind==8){FILE*f=fopen("/usr/bin/bash","rb");if(!f||fread(input,1,sizeof(input),f)!=sizeof(input)){fprintf(stderr,"Bash fixture unavailable\n");exit(4);}fclose(f);return;}
 for(unsigned p=0;p<PAGES;p++)for(unsigned i=0;i<SIZE;i++){
  if(kind==0)input[p][i]=(unsigned char)rnd();
  else if(kind==1){if(i%4==0){uint32_t word=rnd()%8?0:rnd();memcpy(input[p]+i,&word,4);}}
  else if(kind==2)input[p][i]=0;
  else if(kind==3)input[p][i]=(unsigned char)(i%8+p*37);
  else if(kind==4)input[p][i]=(unsigned char)((i%127)*37+p);
  else if(kind==5)input[p][i]=i<2048?(unsigned char)rnd():0;
  else if(kind==6){if(i%4==0){uint32_t word=i<2048?rnd():(i/4%16)*37+p;memcpy(input[p]+i,&word,4);}}
  else input[p][i]=(unsigned char)(i%32+p);
 }
}
static int selected_name(const char *list,const char *name)
{
 size_t length=strlen(name);
 while(*list){const char *end=strchr(list,',');if(!end)end=list+strlen(list);
  if((size_t)(end-list)==length&&!memcmp(list,name,length))return 1;
  if(!*end)break;
  list=end+1;
 }
 return 0;
}
int main(int argc,char **argv){
 if(argc!=2&&argc!=3)return 2;
 int validate=argc==3&&!strcmp(argv[2],"--validate-only");int list_variants=argc==3&&!strcmp(argv[2],"--list-variants"),list_corpora=argc==3&&!strcmp(argv[2],"--list-corpora"),list_calls=argc==3&&!strcmp(argv[2],"--calls-per-batch");int dump=argc==3&&!strncmp(argv[2],"--dump-corpus=",14);if(argc==3&&!validate&&!list_variants&&!list_corpora&&!list_calls&&!dump)return 2;
 const char *shuffle=getenv("GZRAM_ORDER_SEED");if(shuffle){char *end;errno=0;order_seed=strtoull(shuffle,&end,10);if(!*shuffle||*end||errno||!order_seed)return 2;}
 cpu_set_t allowed,chosen;if(sched_getaffinity(0,sizeof(allowed),&allowed))return 3;CPU_ZERO(&chosen);int cpu=0;for(;cpu<CPU_SETSIZE;cpu++)if(CPU_ISSET(cpu,&allowed))break;if(cpu==CPU_SETSIZE)return 3;CPU_SET(cpu,&chosen);if(sched_setaffinity(0,sizeof(chosen),&chosen))return 3;
 char path[4096];snprintf(path,sizeof(path),"%s/libgzram.so",argv[1]);void *gz=dlopen(path,RTLD_NOW|RTLD_LOCAL);snprintf(path,sizeof(path),"%s/lz4-small.so",argv[1]);void *lz=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!gz||!lz){fprintf(stderr,"%s\n",dlerror());return 4;}
 baseline_enc=(lz_enc)dlsym(lz,"LZ4_compress_default");baseline_dec=(lz_dec)dlsym(lz,"LZ4_decompress_safe");int (*available)(void)=dlsym(gz,"gzram_avx2_available");if(!baseline_enc||!baseline_dec||!available||!available()){fprintf(stderr,"Native AVX2 support required for comparisons\n");return 5;}
 struct codec variants[CODEC_CAPACITY]={0};strcpy(variants[0].name,"lz4-small-scalar");variants[0].lz4=1;
 int n=1;for(int isa=0;isa<2;isa++)for(unsigned log=5;log<=12;log++){
  struct codec *v=&variants[n++];v->log=log;snprintf(v->name,sizeof(v->name),"gz-%s-%u",isa?"avx2":"scalar",1U<<log);v->comp=(gz_enc)dlsym(gz,isa?"gzram_encode_avx2":"gzram_encode_scalar");v->dec=(gz_dec)dlsym(gz,isa?"gzram_decode_avx2":"gzram_decode_scalar");if(!v->comp||!v->dec)return 5;
 }
 snprintf(path,sizeof(path),"%s/libgzram-fast.so",argv[1]);void *fast=NULL;
 if(access(path,R_OK)==0){fast=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!fast){fprintf(stderr,"%s\n",dlerror());return 5;}}
 snprintf(path,sizeof(path),"%s/libgzram-block.so",argv[1]);void *blocklib=NULL;
 if(access(path,R_OK)==0){blocklib=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!blocklib){fprintf(stderr,"%s\n",dlerror());return 5;}}
 if(blocklib)for(unsigned log=5;log<=12;log++){
  struct codec *v=&variants[n++];v->log=log;snprintf(v->name,sizeof(v->name),"gz-block-avx2-%u",1U<<log);v->comp=(gz_enc)dlsym(blocklib,"gzram_encode_avx2");v->dec=(gz_dec)dlsym(blocklib,"gzram_decode_avx2");if(!v->comp||!v->dec)return 5;
 }
 snprintf(path,sizeof(path),"%s/libgzram-period.so",argv[1]);void *periodlib=NULL;
 if(access(path,R_OK)==0){periodlib=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!periodlib){fprintf(stderr,"%s\n",dlerror());return 5;}}
 if(periodlib)for(unsigned log=5;log<=12;log++){
  struct codec *v=&variants[n++];v->log=log;snprintf(v->name,sizeof(v->name),"gz-period-avx2-%u",1U<<log);v->comp=(gz_enc)dlsym(periodlib,"gzram_encode_avx2");v->dec=(gz_dec)dlsym(periodlib,"gzram_decode_avx2");if(!v->comp||!v->dec)return 5;
 }
 snprintf(path,sizeof(path),"%s/libgzram-filter.so",argv[1]);void *filterlib=NULL;
 if(access(path,R_OK)==0){filterlib=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!filterlib){fprintf(stderr,"%s\n",dlerror());return 5;}}
 if(filterlib)for(unsigned isa=0;isa<2;isa++)for(unsigned log=5;log<=12;log++){
  struct codec *v=&variants[n++];v->log=log;snprintf(v->name,sizeof(v->name),"gz-filter-%s-%u",isa?"avx2":"scalar",1U<<log);v->comp=(gz_enc)dlsym(filterlib,isa?"gzram_encode_avx2":"gzram_encode_scalar");v->dec=(gz_dec)dlsym(filterlib,isa?"gzram_decode_avx2":"gzram_decode_scalar");if(!v->comp||!v->dec)return 5;
 }
 if(fast)for(unsigned log=5;log<=12;log++){
  struct codec *v=&variants[n++];v->log=log;snprintf(v->name,sizeof(v->name),"gz-fast-scalar-%u",1U<<log);v->comp=(gz_enc)dlsym(fast,"gzram_encode_scalar");v->dec=(gz_dec)dlsym(fast,"gzram_decode_scalar");if(!v->comp||!v->dec)return 5;
 }
 for(unsigned policy=0;policy<sizeof(policies)/sizeof(policies[0]);policy++){
  snprintf(path,sizeof(path),"%s/libgzram-hybrid-%s.so",argv[1],policies[policy]);
  if(access(path,R_OK))continue;
  void *h=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!h){fprintf(stderr,"%s\n",dlerror());return 5;}
  for(unsigned isa=0;isa<2;isa++)for(unsigned log=5;log<=12;log++){
   struct codec *v=&variants[n++];v->log=log;snprintf(v->name,sizeof(v->name),"ghy-%s-%s-%u",policies[policy],isa?"avx2":"scalar",1U<<log);
   v->comp=(gz_enc)dlsym(h,isa?"gzram_encode_avx2":"gzram_encode_scalar");v->dec=(gz_dec)dlsym(h,isa?"gzram_decode_avx2":"gzram_decode_scalar");if(!v->comp||!v->dec)return 5;
  }
 }
 if(getenv("GZRAM_HYBRID_SCREEN")){
  int kept=0;
  for(int i=0;i<n;i++){
   const char *name=variants[i].name;
   int keep=(!strncmp(name,"ghy-",4)&&(variants[i].log==10||variants[i].log==12))||!strcmp(name,"lz4-small-scalar")||!strcmp(name,"gz-avx2-1024")||!strcmp(name,"gz-avx2-4096")||!strcmp(name,"gz-fast-scalar-1024")||!strcmp(name,"gz-fast-scalar-4096")||!strcmp(name,"gz-filter-avx2-1024")||!strcmp(name,"gz-filter-avx2-4096")||!strcmp(name,"gz-period-avx2-4096");
   if(keep)variants[kept++]=variants[i];
  }
  n=kept;
 }
 const char *selection=getenv("GZRAM_VARIANT_LIST");
 if(selection){int kept=0;for(int i=0;i<n;i++)if(selected_name(selection,variants[i].name))variants[kept++]=variants[i];n=kept;}
 if(dump){
  for(unsigned kind=0;kind<sizeof(corpora)/sizeof(corpora[0]);kind++)if(corpus_visible(kind)&&!strcmp(argv[2]+14,corpora[kind])){fill((int)kind);return fwrite(input,1,sizeof(input),stdout)==sizeof(input)?0:14;}
  fprintf(stderr,"Unknown corpus\n");return 2;
 }
 if(list_variants){for(int i=0;i<n;i++)puts(variants[i].name);return 0;}
 const char *corpus_selection=getenv("GZRAM_CORPUS_LIST");
 unsigned selected_corpora=0;
 for(unsigned i=0;i<sizeof(corpora)/sizeof(corpora[0]);i++)if(corpus_visible(i)&&(!corpus_selection||selected_name(corpus_selection,corpora[i])))selected_corpora++;
 if(!selected_corpora){fprintf(stderr,"No selected corpora\n");return 2;}
 if(list_corpora){for(unsigned i=0;i<sizeof(corpora)/sizeof(corpora[0]);i++)if(corpus_visible(i)&&(!corpus_selection||selected_name(corpus_selection,corpora[i])))puts(corpora[i]);return 0;}
 if(list_calls){printf("%d\n",OPS);return 0;}
 const char *inherited_energy=getenv("GZRAM_ENERGY_FD");
 if(inherited_energy){char *end;errno=0;long fd=strtol(inherited_energy,&end,10);if(errno||!inherited_energy[0]||*end||fd<3||fd>2147483647){fprintf(stderr,"Invalid inherited energy descriptor\n");return 16;}energy_fd=(int)fd;}
 setup_perf();if(!read_counter("/sys/class/powercap/intel-rapl:0/max_energy_range_uj",&energy_range))energy_range=0;
 uint64_t initial_energy;if(!energy(&initial_energy))energy_range=0;
 fprintf(stderr,"CPU %d; AVX2 verified; RAPL %s; userspace codec screening, kernel SIMD overhead excluded\n",cpu,energy_range?"available":"unavailable");
 puts("corpus,round,variant,operation,ns_per_page,compressed_bytes,cycles,instructions,branch_misses,cache_misses,pmu_running_fraction,package_uj_per_page,hybrid_raw_pages,hybrid_gzram_pages,hybrid_lz4_pages,cpu_ns_per_page,cpu_utilization_percent");
 for(unsigned kind=0;kind<sizeof(corpora)/sizeof(corpora[0]);kind++){
  if(!corpus_visible(kind)||(corpus_selection&&!selected_name(corpus_selection,corpora[kind])))continue;
  fill(kind);
  for(int round=-2;round<9;round++){
   int order[CODEC_CAPACITY];for(int i=0;i<n;i++)order[i]=i;for(int i=n-1;i>0;i--){int j=order_random()%(i+1),t=order[i];order[i]=order[j];order[j]=t;}
   if(validate&&round!=-2)continue;
   for(int k=0;k<n;k++){
    struct codec *v=&variants[order[k]];long total=0;int hybrid=!strncmp(v->name,"ghy-",4),mode_counts[3]={0};
    for(unsigned p=0;p<PAGES;p++){
     sizes[p]=encode(v,p,packed[p]);if(sizes[p]<=0||sizes[p]>BOUND)return 6;total+=sizes[p];if(hybrid){if(packed[p][6]>2)return 13;mode_counts[packed[p][6]]++;}memcpy(expected[p],packed[p],(size_t)sizes[p]);
     if(decode(v,p)!=SIZE||memcmp(input[p],output,SIZE))return 7;
    }
    if(validate)continue;
    for(int operation=0;operation<2;operation++){
     uint64_t eb=0,ea=0;int rapl=energy(&eb);begin();uint64_t cpu_start=cpu_now(),start=now();
     for(int i=0;i<OPS;i++){unsigned p=(unsigned)i%PAGES;int got=operation?decode(v,p):encode(v,p,packed[p]);if(got!=(operation?SIZE:sizes[p]))return 8;}
     uint64_t elapsed=now()-start,cpu_elapsed=cpu_now()-cpu_start;double counts[4],fraction;end(counts,&fraction);rapl=rapl&&energy(&ea);
     if(operation){if(memcmp(output,input[(OPS-1)%PAGES],SIZE))return 9;}
     else for(unsigned p=0;p<PAGES;p++)if(memcmp(packed[p],expected[p],(size_t)sizes[p]))return 10;
     double uj=rapl?(double)((ea+energy_range-eb)%energy_range)/OPS:-1;
     if(round>=0)printf("%s,%d,%s,%s,%.3f,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f,%.6f,%d,%d,%d,%.3f,%.3f\n",corpora[kind],round,v->name,operation?"decompress":"compress",(double)elapsed/OPS,(double)total/PAGES,counts[0],counts[1],counts[2],counts[3],fraction,uj,hybrid?mode_counts[0]:-1,hybrid?mode_counts[1]:-1,hybrid?mode_counts[2]:-1,(double)cpu_elapsed/OPS,100.0*(double)cpu_elapsed/(double)elapsed);
    }
    fflush(stdout);
   }
  }
  fprintf(stderr,"Validated %s: 128 pages, %d variants\n",corpora[kind],n);
 }
 return 0;
}
