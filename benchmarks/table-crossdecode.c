/* SPDX-License-Identifier: GPL-2.0-only */
/* Identical-page, full encoder/decoder matrix. Userspace attribution only. */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <dlfcn.h>
#include <unistd.h>
#include <fcntl.h>
#include <linux/perf_event.h>
#include <sys/syscall.h>
#define PAGES 128
#define PAGE 4096
#define CAP 4352
#define OPS 32768
static unsigned char input[PAGES][PAGE],packed[3][PAGES][CAP],output[PAGE];
static int lengths[3][PAGES],fd=-1;
static uint64_t rng=100;
static uint32_t random32(void){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return (uint32_t)rng;}
static uint64_t now(void){struct timespec t;if(clock_gettime(CLOCK_MONOTONIC_RAW,&t))abort();return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
struct pmu {uint64_t value,enabled,running;};
static struct pmu cycles(void){struct pmu n={0};if(fd>=0&&read(fd,&n,sizeof(n))!=sizeof(n))abort();return n;}
static int energy_fd=-1;static uint64_t energy_range;
static uint64_t energy(void){char buf[64];if(energy_fd<0)return 0;ssize_t n=pread(energy_fd,buf,sizeof(buf)-1,0);if(n<=0)abort();buf[n]=0;return strtoull(buf,NULL,10);}

typedef int (*enc_fn)(const void*,void*,int,int,void*);
typedef int (*dec_fn)(const void*,void*,int,int);
struct codec {enc_fn encode;dec_fn decode;void *work;};
static void fill(unsigned kind){
 rng=100;
 if(kind==5){FILE *f=fopen("/usr/bin/bash","rb");if(!f||fread(input,1,sizeof(input),f)!=sizeof(input))abort();fclose(f);return;}
 for(unsigned p=0;p<PAGES;p++)for(unsigned i=0;i<PAGE;i++){
  if(kind==0)input[p][i]=(unsigned char)random32();
  else if(kind<=3)input[p][i]=(i<PAGE*(4-kind)/4)?(unsigned char)random32():0;
  else input[p][i]=(unsigned char)((i%127)*37+p);
 }
}
int main(int argc,char **argv){
 if(argc!=2){fprintf(stderr,"usage: table-crossdecode TABLE_LIBRARY_DIRECTORY\n");return 2;}
 struct codec c[3];
 for(unsigned k=0;k<3;k++){
  char path[4096];snprintf(path,sizeof(path),"%s/table%u-scalar.so",argv[1],12+k);
  void *h=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!h){fprintf(stderr,"%s\n",dlerror());return 3;}
  c[k].encode=(enc_fn)dlsym(h,"n100_reuse_compress");c[k].decode=(dec_fn)dlsym(h,"n100_reuse_decompress");
  unsigned long (*worksize)(void)=dlsym(h,"n100_reuse_worksize");void (*init)(void*)=dlsym(h,"n100_reuse_init");
  if(!c[k].encode||!c[k].decode||!worksize||!init||worksize()!=(1UL<<(12+k))+32)return 4;
  c[k].work=calloc(1,worksize());if(!c[k].work)return 5;init(c[k].work);
 }
 struct perf_event_attr attr={.type=PERF_TYPE_HARDWARE,.size=sizeof(attr),.config=PERF_COUNT_HW_CPU_CYCLES,.exclude_kernel=1,.exclude_hv=1,.read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING};
 fd=syscall(SYS_perf_event_open,&attr,0,-1,-1,0);if(fd<0)perror("user cycles unavailable");
 energy_fd=open("/sys/class/powercap/intel-rapl:0/energy_uj",O_RDONLY);
 if(energy_fd>=0){FILE *f=fopen("/sys/class/powercap/intel-rapl:0/max_energy_range_uj","r");if(!f||fscanf(f,"%lu",&energy_range)!=1||!energy_range)return 10;fclose(f);}
 const char *names[]={"random","25pct-zero","50pct-zero","75pct-zero","period127","bash-elf"};
 puts("corpus,round,encoder_bits,decoder_bits,ns_per_page,user_cycles_per_page,bytes_per_page,stream_hash,pmu_running_fraction,package_uj_per_page");
 for(unsigned kind=0;kind<6;kind++){
  fill(kind);uint64_t hash[3]={0},total[3]={0};
  for(unsigned e=0;e<3;e++)for(unsigned p=0;p<PAGES;p++){
   int n=c[e].encode(input[p],packed[e][p],PAGE,CAP,c[e].work);if(n<=0||n>CAP)return 6;lengths[e][p]=n;total[e]+=n;
   /* Diagnostic identity fingerprint, not a cryptographic integrity digest. */
   for(int i=0;i<n;i++)hash[e]=(hash[e]^packed[e][p][i])*1099511628211ULL;
   hash[e]=(hash[e]^(unsigned)n)*1099511628211ULL;
   for(unsigned d=0;d<3;d++)if(c[d].decode(packed[e][p],output,n,PAGE)!=PAGE||memcmp(input[p],output,PAGE))return 7;
  }
  for(int round=-2;round<9;round++){
   unsigned order[9];for(unsigned i=0;i<9;i++)order[i]=i;
   for(unsigned i=8;i;i--){unsigned j=random32()%(i+1),t=order[i];order[i]=order[j];order[j]=t;}
   for(unsigned at=0;at<9;at++){
    unsigned e=order[at]/3,d=order[at]%3;dec_fn decode=c[d].decode;
    uint64_t eb=energy();struct pmu cb=cycles();uint64_t start=now();
    for(unsigned i=0;i<OPS;i++){unsigned p=i%PAGES;if(decode(packed[e][p],output,lengths[e][p],PAGE)!=PAGE)return 8;}
    uint64_t elapsed=now()-start;struct pmu ce=cycles();uint64_t ee=energy();
    if(memcmp(output,input[PAGES-1],PAGE))return 9;
    if(round>=0)printf("%s,%d,%u,%u,%.3f,%.3f,%.3f,%016llx,%.6f,%.6f\n",names[kind],round,12+e,12+d,(double)elapsed/OPS,fd>=0?(double)(ce.value-cb.value)/OPS:-1.0,(double)total[e]/PAGES,(unsigned long long)hash[e],fd>=0&&ce.enabled>cb.enabled?(double)(ce.running-cb.running)/(ce.enabled-cb.enabled):-1.0,energy_fd>=0?(double)((ee+energy_range-eb)%energy_range)/OPS:-1.0);
   }
  }
 }
 return 0;
}
