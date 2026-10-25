/* SPDX-License-Identifier: GPL-2.0-only */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <dlfcn.h>
#include <sched.h>
#include <cpuid.h>
#include <linux/perf_event.h>
#include <sys/syscall.h>
#include <unistd.h>
#define PAGES 128
#define SIZE 4096
#define OPS 8192
static unsigned char input[PAGES][SIZE], packed[PAGES][4352], expected_packed[PAGES][4352], output[SIZE];
static int sizes[PAGES];
static uint64_t seed=100;
static int cycles_fd=-1;
static uint64_t cycles(void) {uint64_t v=0;if(cycles_fd>=0 && read(cycles_fd,&v,sizeof(v))!=sizeof(v)){perror("cycles read");exit(11);}return v;}
static uint32_t random32(void) {seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;return seed;}
static uint64_t now(void) {struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
typedef int (*compress_fn)(const void*,void*,int,int,void*);
typedef int (*decompress_fn)(const void*,void*,int,int);
struct codec {const char *name; void *handle; compress_fn compress; decompress_fn decompress; void *work;};
static void fill(int kind) {
 if(kind>=6){
  for(unsigned p=0;p<PAGES;p++){
   unsigned page=(p*1543U)%196608U;uint32_t r=page+100;
   for(int i=0;i<1024;i++){
    uint32_t value;
    if(i<512){r^=r<<13;r^=r>>17;r^=r<<5;value=r;}
    else value=(i%(kind==6?16:127))*37+page;
    memcpy(input[p]+i*4,&value,4);
   }
  }
  return;
 }
 if(kind==4){FILE *f=fopen("/usr/bin/bash","rb");if(!f||fread(input,1,sizeof(input),f)!=sizeof(input)){fprintf(stderr,"ELF corpus read failed\n");exit(12);}fclose(f);return;}
 for(int p=0;p<PAGES;p++) for(int i=0;i<SIZE;i++) {
  if(kind==0) input[p][i]=random32();
  else if(kind==1) input[p][i]=(i%64<56)?0:random32();
  else if(kind==2) input[p][i]=(unsigned char)((i%127)*37+p);
  else if(kind==5)input[p][i]=i<2048?random32():0;
  else input[p][i]=(i%256<128)?(unsigned char)(i%31):random32();
 }
}
int main(int argc,char **argv) {
 if(argc<2 || argc>3 || (argc==3 && strcmp(argv[2],"--validate-only"))){fprintf(stderr,"usage: native BUILD_DIRECTORY [--validate-only]\n");return 2;}
 int validate_only=argc==3;
 unsigned a,b,c,d; __cpuid_count(1,0,a,b,c,d);
 if(!(c&bit_OSXSAVE)||!(c&bit_AVX))return 3;
 unsigned lo,hi; __asm__ volatile("xgetbv":"=a"(lo),"=d"(hi):"c"(0));
 __cpuid_count(7,0,a,b,c,d); if(!(b&bit_AVX2)||(lo&6)!=6)return 3;
 cpu_set_t allowed,chosen;sched_getaffinity(0,sizeof(allowed),&allowed);CPU_ZERO(&chosen);
 int cpu=0;for(;cpu<CPU_SETSIZE;cpu++)if(CPU_ISSET(cpu,&allowed))break;
 CPU_SET(cpu,&chosen);if(sched_setaffinity(0,sizeof(chosen),&chosen))return 4;
 fprintf(stderr,"CPUID AVX2 verified, XCR0=%x:%x, pinned CPU %d\n",hi,lo,cpu);
 struct perf_event_attr attr={.type=PERF_TYPE_HARDWARE,.size=sizeof(attr),.config=PERF_COUNT_HW_CPU_CYCLES,.exclude_kernel=1,.exclude_hv=1};
 cycles_fd=syscall(SYS_perf_event_open,&attr,0,-1,-1,0);
 if(cycles_fd<0)perror("User-only core cycle counter unavailable");
 const char *ordinary_names[]={"scalar","sse","avx2","avx2-count","avx2-guard","sse-guard","avx2-copy","avx2-guard16","avx2-guard32","scalar-unroll","scalar-gracemont","avx2-guard-gracemont","avx2-guard16-gracemont","sse-guard-gracemont","avx2-guard-overlap","avx2-copy-overlap"};
 const char *reuse_names[]={"scalar","avx2-guard","reset4k-scalar","reset4k-avx2","reuse-scalar","reuse-avx2","reuse32-scalar","reuse32-avx2"};
 const char *table_names[]={"scalar","avx2-guard","table13-scalar","table13-avx2","table12-scalar","table12-avx2","table11-scalar","table11-avx2"};
 int table=getenv("N100_SMALL_TABLE_EXPERIMENT")!=NULL;
 if(table && getenv("N100_TABLE_MATCHED")){table_names[0]="table14-scalar";table_names[1]="table14-avx2";}
 int reuse=table || getenv("N100_REUSE_EXPERIMENT")!=NULL;
 const char **names=table?table_names:reuse?reuse_names:ordinary_names;
 int N=reuse?8:sizeof(ordinary_names)/sizeof(ordinary_names[0]);struct codec codecs[N];
 int variant_sizes[N][PAGES];long variant_total[N];
 void *shared_work=calloc(1,32768);if(!shared_work)return 7;
 for(int i=0;i<N;i++){char path[4096];snprintf(path,sizeof(path),"%s/%s.so",argv[1],names[i]);
  codecs[i]=(struct codec){.name=names[i],.handle=dlopen(path,RTLD_NOW|RTLD_LOCAL)};
  if(!codecs[i].handle){fprintf(stderr,"%s\n",dlerror());return 5;}
  codecs[i].compress=(compress_fn)dlsym(codecs[i].handle,"n100_reuse_compress");
  int initialized_api=codecs[i].compress!=NULL;
  if(!initialized_api)codecs[i].compress=(compress_fn)dlsym(codecs[i].handle,"LZ4_compress_default");
  codecs[i].decompress=(decompress_fn)dlsym(codecs[i].handle,"LZ4_decompress_safe");
  if(initialized_api)codecs[i].decompress=(decompress_fn)dlsym(codecs[i].handle,"n100_reuse_decompress");
  if(!codecs[i].compress||!codecs[i].decompress)return 6;
  unsigned long bytes=32768;
  if(initialized_api){unsigned long (*size_fn)(void)=dlsym(codecs[i].handle,"n100_reuse_worksize");if(!size_fn)return 6;if(size_fn()>bytes)bytes=size_fn();}
  if(bytes>1048576)return 6;
  codecs[i].work=reuse?calloc(1,bytes):shared_work;if(!codecs[i].work)return 7;
  if(initialized_api){void (*init_fn)(void*)=dlsym(codecs[i].handle,"n100_reuse_init");if(!init_fn)return 6;init_fn(codecs[i].work);}
 }
 puts("corpus,round,variant,operation,ns_per_page,compressed_bytes_per_page,user_core_cycles_per_page");
 const char *kinds[]={"random","sparse","period127","mixed","bash-elf","halfzero","word-tail64","word-tail508"};
 for(int kind=0;kind<(reuse?8:5);kind++){
  fill(kind);long total=0;
  for(int p=0;p<PAGES;p++){sizes[p]=codecs[0].compress(input[p],packed[p],SIZE,4352,codecs[0].work);if(sizes[p]<=0)return 8;total+=sizes[p];if(reuse)memcpy(expected_packed[p],packed[p],sizes[p]);}
  for(int j=0;j<N;j++)for(int p=0;p<PAGES;p++){
   unsigned char check[4352];
   int got=codecs[j].compress(input[p],check,SIZE,4352,codecs[j].work);
   if(got<=0 || (!table && (got!=sizes[p] || memcmp(check,packed[p],got))))return 13;
   variant_sizes[j][p]=got;
   int decoded=codecs[0].decompress(check,output,got,SIZE);
   if(decoded!=SIZE || memcmp(output,input[p],SIZE))return 17;
   got=codecs[j].decompress(check,output,got,SIZE);
   if(got!=SIZE || memcmp(output,input[p],SIZE))return 14;
  }
  for(int j=0;j<N;j++){variant_total[j]=0;for(int p=0;p<PAGES;p++)variant_total[j]+=variant_sizes[j][p];}
  fprintf(stderr,"Corpus round trips passed: %s, %d variants, %d pages\n",kinds[kind],N,PAGES);
  for(int round=-2;round<21;round++){
   int order[N];for(int j=0;j<N;j++)order[j]=j;for(int j=N-1;j>0;j--){int k=random32()%(j+1),tmp=order[j];order[j]=order[k];order[k]=tmp;}
   if(validate_only)continue;
   for(int j=0;j<N;j++){
    struct codec *codec=&codecs[order[j]];
    if(table)for(int p=0;p<PAGES;p++) {
     sizes[p]=variant_sizes[order[j]][p];
     int got=codec->compress(input[p],expected_packed[p],SIZE,4352,codec->work);
     if(got!=sizes[p])return 18;
    }
    if(table)total=variant_total[order[j]];
    uint64_t cstart=cycles(),start=now();
    for(int n=0;n<OPS;n++){int p=n%PAGES;int got=codec->compress(input[p],packed[p],SIZE,4352,codec->work);if(got!=sizes[p])return 9;}
    uint64_t comp=now()-start,cc=cycles()-cstart;
    if(reuse)for(int p=0;p<PAGES;p++)if(memcmp(packed[p],expected_packed[p],sizes[p]))return 15;
    cstart=cycles();start=now();
    for(int n=0;n<OPS;n++){int p=n%PAGES;int got=codec->decompress(packed[p],output,sizes[p],SIZE);if(got!=SIZE)return 10;}
    uint64_t dec=now()-start,dc=cycles()-cstart;
    if(reuse && memcmp(output,input[PAGES-1],SIZE))return 16;
    if(round>=0){printf("%s,%d,%s,compress,%.3f,%.3f,%.3f\n",kinds[kind],round,codec->name,(double)comp/OPS,(double)total/PAGES,cycles_fd<0?-1.0:(double)cc/OPS);
     printf("%s,%d,%s,decompress,%.3f,%.3f,%.3f\n",kinds[kind],round,codec->name,(double)dec/OPS,(double)total/PAGES,cycles_fd<0?-1.0:(double)dc/OPS);}
   }
   fflush(stdout);
  }
 }
 for(int i=0;i<N;i++)if(reuse)free(codecs[i].work);
 free(shared_work);return 0;
}
