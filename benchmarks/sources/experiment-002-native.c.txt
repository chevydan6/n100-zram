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
static unsigned char input[PAGES][SIZE], packed[PAGES][4352], output[SIZE];
static int sizes[PAGES];
static uint64_t seed=100;
static int cycles_fd=-1;
static uint64_t cycles(void) {uint64_t v=0;if(cycles_fd>=0 && read(cycles_fd,&v,sizeof(v))!=sizeof(v)){perror("cycles read");exit(11);}return v;}
static uint32_t random32(void) {seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;return seed;}
static uint64_t now(void) {struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
typedef int (*compress_fn)(const void*,void*,int,int,void*);
typedef int (*decompress_fn)(const void*,void*,int,int);
struct codec {const char *name; void *handle; compress_fn compress; decompress_fn decompress;};
static void fill(int kind) {
 if(kind==4){FILE *f=fopen("/usr/bin/bash","rb");if(!f||fread(input,1,sizeof(input),f)!=sizeof(input)){fprintf(stderr,"ELF corpus read failed\n");exit(12);}fclose(f);return;}
 for(int p=0;p<PAGES;p++) for(int i=0;i<SIZE;i++) {
  if(kind==0) input[p][i]=random32();
  else if(kind==1) input[p][i]=(i%64<56)?0:random32();
  else if(kind==2) input[p][i]=(unsigned char)((i%127)*37+p);
  else input[p][i]=(i%256<128)?(unsigned char)(i%31):random32();
 }
}
int main(int argc,char **argv) {
 if(argc!=2){fprintf(stderr,"usage: native BUILD_DIRECTORY\n");return 2;}
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
 const char *names[]={"scalar","sse","avx2","avx2-count","avx2-guard","sse-guard","avx2-copy"};
 enum {N=sizeof(names)/sizeof(names[0])};struct codec codecs[N];
 for(int i=0;i<N;i++){char path[4096];snprintf(path,sizeof(path),"%s/%s.so",argv[1],names[i]);
  codecs[i]=(struct codec){.name=names[i],.handle=dlopen(path,RTLD_NOW|RTLD_LOCAL)};
  if(!codecs[i].handle){fprintf(stderr,"%s\n",dlerror());return 5;}
  codecs[i].compress=(compress_fn)dlsym(codecs[i].handle,"LZ4_compress_default");
  codecs[i].decompress=(decompress_fn)dlsym(codecs[i].handle,"LZ4_decompress_safe");
  if(!codecs[i].compress||!codecs[i].decompress)return 6;
 }
 void *work=calloc(1,32768);if(!work)return 7;
 puts("corpus,round,variant,operation,ns_per_page,compressed_bytes_per_page,user_core_cycles_per_page");
 const char *kinds[]={"random","sparse","period127","mixed","bash-elf"};
 for(int kind=0;kind<5;kind++){
  fill(kind);long total=0;
  for(int p=0;p<PAGES;p++){sizes[p]=codecs[0].compress(input[p],packed[p],SIZE,4352,work);if(sizes[p]<=0)return 8;total+=sizes[p];}
  for(int round=-2;round<21;round++){
   int order[N];for(int j=0;j<N;j++)order[j]=j;for(int j=N-1;j>0;j--){int k=random32()%(j+1),tmp=order[j];order[j]=order[k];order[k]=tmp;}
   for(int j=0;j<N;j++){
    struct codec *codec=&codecs[order[j]];
    uint64_t cstart=cycles(),start=now();
    for(int n=0;n<OPS;n++){int p=n%PAGES;int got=codec->compress(input[p],packed[p],SIZE,4352,work);if(got!=sizes[p])return 9;}
    uint64_t comp=now()-start,cc=cycles()-cstart; cstart=cycles();start=now();
    for(int n=0;n<OPS;n++){int p=n%PAGES;int got=codec->decompress(packed[p],output,sizes[p],SIZE);if(got!=SIZE)return 10;}
    uint64_t dec=now()-start,dc=cycles()-cstart;
    if(round>=0){printf("%s,%d,%s,compress,%.3f,%.3f,%.3f\n",kinds[kind],round,codec->name,(double)comp/OPS,(double)total/PAGES,cycles_fd<0?-1.0:(double)cc/OPS);
     printf("%s,%d,%s,decompress,%.3f,%.3f,%.3f\n",kinds[kind],round,codec->name,(double)dec/OPS,(double)total/PAGES,cycles_fd<0?-1.0:(double)dc/OPS);}
   }
   fflush(stdout);
  }
 }
 free(work);return 0;
}
