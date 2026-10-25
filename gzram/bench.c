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
#define OPS 32768
static unsigned char input[PAGES][SIZE],packed[PAGES][BOUND],expected[PAGES][BOUND],output[SIZE];
static int sizes[PAGES],fds[4]={-1,-1,-1,-1};static uint64_t seed=100,energy_range;
static uint32_t rnd(void){seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;return (uint32_t)seed;}
static uint64_t now(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
static int read_counter(const char *path,uint64_t *value){FILE *f=fopen(path,"r");if(!f)return 0;int ok=fscanf(f,"%lu",value)==1;fclose(f);return ok;}
static int energy(uint64_t *value){return energy_range&&read_counter("/sys/class/powercap/intel-rapl:0/energy_uj",value);}
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
static void fill(int kind){
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
int main(int argc,char **argv){
 if(argc!=2&&argc!=3)return 2;
 int validate=argc==3&&!strcmp(argv[2],"--validate-only");if(argc==3&&!validate)return 2;
 cpu_set_t allowed,chosen;if(sched_getaffinity(0,sizeof(allowed),&allowed))return 3;CPU_ZERO(&chosen);int cpu=0;for(;cpu<CPU_SETSIZE;cpu++)if(CPU_ISSET(cpu,&allowed))break;if(cpu==CPU_SETSIZE)return 3;CPU_SET(cpu,&chosen);if(sched_setaffinity(0,sizeof(chosen),&chosen))return 3;
 char path[4096];snprintf(path,sizeof(path),"%s/libgzram.so",argv[1]);void *gz=dlopen(path,RTLD_NOW|RTLD_LOCAL);snprintf(path,sizeof(path),"%s/lz4-small.so",argv[1]);void *lz=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!gz||!lz){fprintf(stderr,"%s\n",dlerror());return 4;}
 baseline_enc=(lz_enc)dlsym(lz,"LZ4_compress_default");baseline_dec=(lz_dec)dlsym(lz,"LZ4_decompress_safe");int (*available)(void)=dlsym(gz,"gzram_avx2_available");if(!baseline_enc||!baseline_dec||!available||!available()){fprintf(stderr,"Native AVX2 support required for comparisons\n");return 5;}
 struct codec variants[33]={0};strcpy(variants[0].name,"lz4-small-scalar");variants[0].lz4=1;
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
 if(fast)for(unsigned log=5;log<=12;log++){
  struct codec *v=&variants[n++];v->log=log;snprintf(v->name,sizeof(v->name),"gz-fast-scalar-%u",1U<<log);v->comp=(gz_enc)dlsym(fast,"gzram_encode_scalar");v->dec=(gz_dec)dlsym(fast,"gzram_decode_scalar");if(!v->comp||!v->dec)return 5;
 }
 setup_perf();if(!read_counter("/sys/class/powercap/intel-rapl:0/max_energy_range_uj",&energy_range))energy_range=0;
 uint64_t initial_energy;if(!energy(&initial_energy))energy_range=0;
 fprintf(stderr,"CPU %d; AVX2 verified; RAPL %s; userspace codec screening, kernel SIMD overhead excluded\n",cpu,energy_range?"available":"unavailable");
 puts("corpus,round,variant,operation,ns_per_page,compressed_bytes,cycles,instructions,branch_misses,cache_misses,pmu_running_fraction,package_uj_per_page");
 const char *corpora[]={"random","sparse-words","zero","repeat8","period127","halfzero","word-tail64","repeat32","bash-elf"};
 for(int kind=0;kind<9;kind++){
  fill(kind);
  for(int round=-2;round<9;round++){
   int order[33];for(int i=0;i<n;i++)order[i]=i;for(int i=n-1;i>0;i--){int j=rnd()%(i+1),t=order[i];order[i]=order[j];order[j]=t;}
   if(validate&&round!=-2)continue;
   for(int k=0;k<n;k++){
    struct codec *v=&variants[order[k]];long total=0;
    for(unsigned p=0;p<PAGES;p++){
     sizes[p]=encode(v,p,packed[p]);if(sizes[p]<=0||sizes[p]>BOUND)return 6;total+=sizes[p];memcpy(expected[p],packed[p],(size_t)sizes[p]);
     if(decode(v,p)!=SIZE||memcmp(input[p],output,SIZE))return 7;
    }
    if(validate)continue;
    for(int operation=0;operation<2;operation++){
     uint64_t eb=0,ea=0;int rapl=energy(&eb);begin();uint64_t start=now();
     for(int i=0;i<OPS;i++){unsigned p=(unsigned)i%PAGES;int got=operation?decode(v,p):encode(v,p,packed[p]);if(got!=(operation?SIZE:sizes[p]))return 8;}
     uint64_t elapsed=now()-start;double counts[4],fraction;end(counts,&fraction);rapl=rapl&&energy(&ea);
     if(operation){if(memcmp(output,input[(OPS-1)%PAGES],SIZE))return 9;}
     else for(unsigned p=0;p<PAGES;p++)if(memcmp(packed[p],expected[p],(size_t)sizes[p]))return 10;
     double uj=rapl?(double)((ea+energy_range-eb)%energy_range)/OPS:-1;
     if(round>=0)printf("%s,%d,%s,%s,%.3f,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f,%.6f\n",corpora[kind],round,v->name,operation?"decompress":"compress",(double)elapsed/OPS,(double)total/PAGES,counts[0],counts[1],counts[2],counts[3],fraction,uj);
    }
    fflush(stdout);
   }
  }
  fprintf(stderr,"Validated %s: 128 pages, %d variants\n",corpora[kind],n);
 }
 return 0;
}
