// SPDX-License-Identifier: GPL-2.0-only
#define _GNU_SOURCE
#include <cpuid.h>
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
#define OPS 8192
static unsigned char data[PAGES][4096],packed[PAGES][4352],check[4352],decoded[4096];
static int sizes[PAGES];
static uint64_t rng=100;
static uint32_t rnd(void){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return rng;}
static uint64_t now(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
typedef int (*comp_fn)(const void*,void*,int,int,void*);
typedef int (*dec_fn)(const void*,void*,int,int);
struct codec{const char *name;comp_fn comp;dec_fn dec;void *work;};
static int events[4]={-1,-1,-1,-1};
static int setup_perf(void){
 const uint64_t config[]={PERF_COUNT_HW_CPU_CYCLES,PERF_COUNT_HW_INSTRUCTIONS,PERF_COUNT_HW_BRANCH_MISSES,PERF_COUNT_HW_CACHE_MISSES};
 for(int i=0;i<4;i++){
  struct perf_event_attr a={.type=PERF_TYPE_HARDWARE,.size=sizeof(a),.config=config[i],.exclude_kernel=1,.exclude_hv=1,.disabled=i==0,.read_format=PERF_FORMAT_GROUP|PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING};
  events[i]=syscall(SYS_perf_event_open,&a,0,-1,i?events[0]:-1,0);
  if(events[i]<0){fprintf(stderr,"PMU group unavailable: %s\n",strerror(errno));for(int j=0;j<i;j++)close(events[j]);events[0]=-1;return 0;}
 }
 return 1;
}
static void begin(void){if(events[0]>=0){if(ioctl(events[0],PERF_EVENT_IOC_RESET,PERF_IOC_FLAG_GROUP)||ioctl(events[0],PERF_EVENT_IOC_ENABLE,PERF_IOC_FLAG_GROUP)){perror("perf enable");exit(11);}}}
static void end(double *counts,double *running){
 for(int i=0;i<4;i++)counts[i]=-1;
 *running=-1;
 if(events[0]<0)return;
 uint64_t values[7];
 if(ioctl(events[0],PERF_EVENT_IOC_DISABLE,PERF_IOC_FLAG_GROUP)||read(events[0],values,sizeof(values))!=sizeof(values)||values[0]!=4){perror("perf read");exit(12);}
 if(!values[1]||!values[2]){fprintf(stderr,"PMU group never scheduled\n");exit(13);}
 *running=(double)values[2]/values[1];
 for(int i=0;i<4;i++)counts[i]=(double)values[3+i]/OPS;
}
int main(int argc,char **argv){
 if(argc!=2 && argc!=3)return 2;
 int validate=argc==3 && !strcmp(argv[2],"--validate-only");if(argc==3&&!validate)return 2;
 unsigned a,b,c,d;__cpuid_count(1,0,a,b,c,d);if(!(c&bit_OSXSAVE)||!(c&bit_AVX))return 3;
 unsigned lo,hi;__asm__ volatile("xgetbv":"=a"(lo),"=d"(hi):"c"(0));__cpuid_count(7,0,a,b,c,d);if(!(b&bit_AVX2)||(lo&6)!=6)return 3;
 cpu_set_t available,chosen;if(sched_getaffinity(0,sizeof(available),&available))return 4;CPU_ZERO(&chosen);int cpu=0;for(;cpu<CPU_SETSIZE;cpu++)if(CPU_ISSET(cpu,&available))break;if(cpu==CPU_SETSIZE)return 4;CPU_SET(cpu,&chosen);if(sched_setaffinity(0,sizeof(chosen),&chosen))return 4;
 fprintf(stderr,"CPU %d; CPUID AVX2 and OS YMM verified; XCR0=%x:%x; user-space only\n",cpu,hi,lo);setup_perf();
 struct codec codecs[3]={{.name="scalar"},{.name="sse"},{.name="avx2"}};
 for(int i=0;i<3;i++){char path[4096];snprintf(path,sizeof(path),"%s/%s.so",argv[1],codecs[i].name);void *lib=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!lib){fprintf(stderr,"%s\n",dlerror());return 5;}codecs[i].comp=(comp_fn)dlsym(lib,"LZ4_compress_default");codecs[i].dec=(dec_fn)dlsym(lib,"LZ4_decompress_safe");codecs[i].work=calloc(1,32768);if(!codecs[i].comp||!codecs[i].dec||!codecs[i].work)return 6;}
 puts("bytes,corpus,round,variant,operation,ns_per_op,compressed_bytes,cycles,instructions,branch_misses,cache_misses,pmu_running_fraction");
 int lengths[64]={16,32,64,128,256,512,1024,2048,4096},nlengths=9;
 const char *requested=getenv("N100_CROSSOVER_SIZES");
 if(requested){char *copy=strdup(requested),*save=NULL;if(!copy)return 6;nlengths=0;for(char *token=strtok_r(copy,",",&save);token;token=strtok_r(NULL,",",&save)){char *end;long size=strtol(token,&end,10);if(*end||size<16||size>4096||nlengths==64)return 2;for(int j=0;j<nlengths;j++)if(lengths[j]==size)return 2;lengths[nlengths++]=(int)size;}free(copy);if(!nlengths)return 2;}
 const char *corpora[]={"random","moderate","periodic"};
 for(int l=0;l<nlengths;l++)for(int kind=0;kind<3;kind++){
  int len=lengths[l];long total=0;
  for(int p=0;p<PAGES;p++){
   for(int j=0;j<len;j++)data[p][j]=kind==0?rnd():kind==1?(j%64<32?rnd():(unsigned)(j%7)):(unsigned)(j%7+p);
   sizes[p]=codecs[0].comp(data[p],packed[p],len,4352,codecs[0].work);if(sizes[p]<=0)return 7;total+=sizes[p];
   for(int v=0;v<3;v++){int n=codecs[v].comp(data[p],check,len,4352,codecs[v].work);if(n!=sizes[p]||memcmp(check,packed[p],n))return 8;for(int w=0;w<3;w++)if(codecs[w].dec(check,decoded,n,len)!=len||memcmp(decoded,data[p],len))return 9;}
  }
  for(int round=-2;round<9;round++){
   int order[]={0,1,2};for(int i=2;i>0;i--){int j=rnd()%(i+1),t=order[i];order[i]=order[j];order[j]=t;}
   if(validate)continue;
   for(int k=0;k<3;k++)for(int operation=0;operation<2;operation++){
    struct codec *codec=&codecs[order[k]];double counts[4],fraction;
    begin();uint64_t start=now();
    for(int n=0;n<OPS;n++){int p=n%PAGES;int got=operation?codec->dec(packed[p],decoded,sizes[p],len):codec->comp(data[p],check,len,4352,codec->work);if(got!=(operation?len:sizes[p]))return 10;}
    uint64_t elapsed=now()-start;end(counts,&fraction);
    if(operation){if(memcmp(decoded,data[(OPS-1)%PAGES],len))return 14;}
    else if(memcmp(check,packed[(OPS-1)%PAGES],sizes[(OPS-1)%PAGES]))return 15;
    if(round>=0)printf("%d,%s,%d,%s,%s,%.3f,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f\n",len,corpora[kind],round,codec->name,operation?"decompress":"compress",(double)elapsed/OPS,(double)total/PAGES,counts[0],counts[1],counts[2],counts[3],fraction);
   }
   fflush(stdout);
  }
 }
 fprintf(stderr,"Cross-variant byte identity and round trips passed: %d size/corpus combinations, 128 blocks each\n",nlengths*3);
 for(int i=0;i<3;i++)free(codecs[i].work);
 return 0;
}
