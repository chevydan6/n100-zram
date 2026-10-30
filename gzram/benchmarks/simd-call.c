/* SPDX-License-Identifier: GPL-2.0-only */
/* Resident-page kernel-inclusive scalar measurement client. Default: validate.
 * Timing requires --measure on the physical N100. No module loading or settings.
 * Vector-state helpers derive from this project's preserved kernel-call.c. */
#define _GNU_SOURCE
#include <cpuid.h>
#include <errno.h>
#include <fcntl.h>
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
#include "../kernel/hybrid-probe.h"
#define PAGES GHY_PROBE_PAGES
#define SIZE GHY_PROBE_PAGE_BYTES
static unsigned ops=8192,checks;
static uint64_t order_seed=100,energy_range;
static int fds[4]={-1,-1,-1,-1},energy_fd=-1;
#define CHECK(x) do { checks++; if(!(x)) { fprintf(stderr,"hybrid-call line %d: %s (errno=%d)\n",__LINE__,#x,errno); exit(1); } } while(0)
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
  struct perf_event_attr a={.type=PERF_TYPE_HARDWARE,.size=sizeof(a),.config=configs[i],.exclude_kernel=0,.exclude_hv=1,.disabled=i==0,.read_format=PERF_FORMAT_GROUP|PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING};
  fds[i]=syscall(SYS_perf_event_open,&a,0,-1,i?fds[0]:-1,0);
  if(fds[i]<0){fprintf(stderr,"PMU group unavailable: %s\n",strerror(errno));for(int j=0;j<i;j++){close(fds[j]);fds[j]=-1;}fds[0]=-1;return;}
 }
}
static void begin(void){if(fds[0]>=0&&(ioctl(fds[0],PERF_EVENT_IOC_RESET,PERF_IOC_FLAG_GROUP)||ioctl(fds[0],PERF_EVENT_IOC_ENABLE,PERF_IOC_FLAG_GROUP))){perror("PMU begin");exit(12);}}
static void end(double *counts,double *fraction){
 for(int i=0;i<4;i++)counts[i]=-1;
 *fraction=-1;if(fds[0]<0)return;
 uint64_t v[7];if(ioctl(fds[0],PERF_EVENT_IOC_DISABLE,PERF_IOC_FLAG_GROUP)||read(fds[0],v,sizeof(v))!=sizeof(v)||v[0]!=4||!v[1]||!v[2]){fprintf(stderr,"Invalid PMU group read\n");exit(13);}
 *fraction=(double)v[2]/v[1];for(int i=0;i<4;i++)counts[i]=(double)v[3+i]/ops;
}
__attribute__((target("avx2"),noinline))
static long invoke(int fd,unsigned long command,int dirty)
{
 long result;
 if(dirty==2){
  __asm__ volatile("vpcmpeqb %%ymm0,%%ymm0,%%ymm0\n\tsyscall":"=a"(result):"0"((long)SYS_ioctl),"D"((long)fd),"S"(command),"d"(0L):"rcx","r11","memory","ymm0");
 }else if(dirty==1){
  __asm__ volatile("pcmpeqb %%xmm0,%%xmm0\n\tsyscall":"=a"(result):"0"((long)SYS_ioctl),"D"((long)fd),"S"(command),"d"(0L):"rcx","r11","memory","xmm0");
 }else{
  __asm__ volatile("syscall":"=a"(result):"0"((long)SYS_ioctl),"D"((long)fd),"S"(command),"d"(0L):"rcx","r11","memory");
 }
 return result;
}
__attribute__((target("avx2"),noinline))
static void clear_vectors(void){__asm__ volatile("vzeroall":::"ymm0","ymm1","ymm2","ymm3","ymm4","ymm5","ymm6","ymm7","ymm8","ymm9","ymm10","ymm11","ymm12","ymm13","ymm14","ymm15");}
#define LOAD_YMM(n) "vmovdqu " #n "*32(%[expected]), %%ymm" #n "\n\t"
#define SAVE_YMM(n) "vmovdqu %%ymm" #n ", " #n "*32(%[actual])\n\t"
#define ALL_YMM(M) M(0) M(1) M(2) M(3) M(4) M(5) M(6) M(7) M(8) M(9) M(10) M(11) M(12) M(13) M(14) M(15)
__attribute__((target("avx2"),noinline))
static int check_state(int fd,unsigned long command)
{
 unsigned char expected[512],actual[512];long result;
 uint32_t old_mxcsr,test_mxcsr,actual_mxcsr;
 uint16_t old_cw,test_cw,actual_cw;
 for(int i=0;i<512;i++)expected[i]=(unsigned char)(i*37+(i/32)*17);
 __asm__ volatile("stmxcsr %0\n\tfnstcw %1":"=m"(old_mxcsr),"=m"(old_cw));
 test_mxcsr=(old_mxcsr&~0x6000U)|0x2000U;
 test_cw=(old_cw&~0x0c00U)|0x0400U;
 __asm__ volatile("ldmxcsr %0\n\tfldcw %1"::"m"(test_mxcsr),"m"(test_cw):"memory");
 __asm__ volatile(ALL_YMM(LOAD_YMM) "syscall\n\t" ALL_YMM(SAVE_YMM)
 : "=a"(result)
 : "0"((long)SYS_ioctl),"D"((long)fd),"S"(command),"d"(0L),[expected]"r"(expected),[actual]"r"(actual)
 : "rcx","r11","memory","ymm0","ymm1","ymm2","ymm3","ymm4","ymm5","ymm6","ymm7","ymm8","ymm9","ymm10","ymm11","ymm12","ymm13","ymm14","ymm15");
 __asm__ volatile("stmxcsr %0\n\tfnstcw %1\n\tldmxcsr %2\n\tfldcw %3"
 :"=m"(actual_mxcsr),"=m"(actual_cw):"m"(old_mxcsr),"m"(old_cw):"memory");
 return result>=0 && actual_mxcsr==test_mxcsr && actual_cw==test_cw && !memcmp(expected,actual,sizeof(expected))?0:-1;
}
static unsigned number(const char *text,unsigned limit)
{
 char *tail;errno=0;unsigned long n=strtoul(text,&tail,10);
 CHECK(*text && !*tail && !errno && n>0 && n<=limit);return (unsigned)n;
}
static int physical_n100(void)
{
 unsigned a,b,c,d;char brand[49]={0};
 if(!__get_cpuid(1,&a,&b,&c,&d)||(c&(1U<<31)))return 0;
 if(__get_cpuid_max(0x80000000,NULL)<0x80000004)return 0;
 for(unsigned i=0;i<3;i++){
  __get_cpuid(0x80000002+i,&a,&b,&c,&d);
  memcpy(brand+i*16,&a,4);memcpy(brand+i*16+4,&b,4);
  memcpy(brand+i*16+8,&c,4);memcpy(brand+i*16+12,&d,4);
 }
 return strstr(brand,"N100")!=NULL;
}
static void integrity(int fd,const uint32_t sizes[3][PAGES])
{
 uint32_t after[3][PAGES];
 CHECK(ioctl(fd,GHY_PROBE_VALIDATE,0UL)==0);
 CHECK(read(fd,after,sizeof(after))==sizeof(after));
 CHECK(!memcmp(sizes,after,sizeof(after)));
}
static void shuffle(unsigned *order,unsigned count)
{
 for(unsigned i=count-1;i>0;i--){unsigned j=order_random()%(i+1),t=order[i];order[i]=order[j];order[j]=t;}
}
struct operation { unsigned long command;const char *variant,*name;int codec,compress; };
#define PAIR(c,label,comp,dec) {comp(c),label,"compress",c,1},{dec(c),label,"decompress",c,0}
static const struct operation operations[]={
 PAIR(0,"lz4-private-scalar",GHY_PROBE_COMP,GHY_PROBE_DEC),
 PAIR(1,"ghy-bitdirect-scalar",GHY_PROBE_COMP,GHY_PROBE_DEC),
 PAIR(2,"ghy-combined-simd",GHY_PROBE_COMP,GHY_PROBE_DEC),
 {GHY_PROBE_NOP,"interface","noop",-1,0},
 {GHY_PROBE_FPU_NOP,"interface-fpu","noop",-1,0},
 PAIR(0,"lz4-private-scalar-fpu",GHY_PROBE_COMP_FPU,GHY_PROBE_DEC_FPU),
 PAIR(1,"ghy-bitdirect-scalar-fpu",GHY_PROBE_COMP_FPU,GHY_PROBE_DEC_FPU),
};
#undef PAIR
static long expected_result(const struct operation *op,const uint32_t sizes[3][PAGES],unsigned page)
{ return op->codec<0?0:op->compress?sizes[op->codec][page]:SIZE; }
int main(int argc,char **argv)
{
 int measure=0,fpu_control=0,first=1;
 while(first<argc && argv[first][0]=='-'){
  if(!strcmp(argv[first],"--measure"))measure=1;
  else if(!strcmp(argv[first],"--fpu-control"))fpu_control=1;
  else if(!strncmp(argv[first],"--ops=",6))ops=number(argv[first]+6,1048576);
  else if(!strncmp(argv[first],"--seed=",7))order_seed=number(argv[first]+7,2147483647);
  else {fprintf(stderr,"usage: hybrid-call [--measure] [--fpu-control] [--ops=N] [--seed=N] CORPUS.bin ...\n");return 2;}
  first++;
 }
 CHECK(first<argc && ops%PAGES==0);
 int vectors=!!__builtin_cpu_supports("avx2");
 if(measure){
  if(!physical_n100()||!vectors){fprintf(stderr,"Timing requires physical N100 with OS AVX2 support; no VM measurements\n");return 3;}
  cpu_set_t set;CPU_ZERO(&set);CPU_SET(0,&set);CHECK(!sched_setaffinity(0,sizeof(set),&set));
 }
 int fd=open("/dev/n100-ghy-probe",O_RDWR|O_CLOEXEC);CHECK(fd>=0);
 unsigned char *input=malloc(PAGES*SIZE);CHECK(input);
 unsigned operation_count=fpu_control?sizeof(operations)/sizeof(operations[0]):7;
 const char *states[]={"vectors-cleared-before-loop","sse-dirty","ymm-dirty"};
 if(measure){
  const char *inherited=getenv("GZRAM_ENERGY_FD");
  if(inherited){energy_fd=(int)number(inherited,2147483647);CHECK(energy_fd>=3);CHECK((fcntl(energy_fd,F_GETFL)&O_ACCMODE)==O_RDONLY);}
  setup_perf();if(!read_counter("/sys/class/powercap/intel-rapl:0/max_energy_range_uj",&energy_range))energy_range=0;
  uint64_t initial;if(!energy(&initial))energy_range=0;
  fprintf(stderr,"CPU0; calls/batch=%u; seed=%lu; RAPL=%s range_uj=%lu; PMU includes user+kernel, excludes hypervisor; one resident page/syscall; scalar and SIMD codecs; FPU entry control=%d\n",ops,order_seed,energy_range?"available":"unavailable",energy_range,fpu_control);
  puts("corpus,round,state,variant,operation,calls,ns_per_call,cpu_ns_per_call,cpu_utilization_percent,compressed_bytes,cycles,instructions,branch_misses,cache_misses,pmu_running_fraction,package_uj_per_call");
 }
 for(int fixture=first;fixture<argc;fixture++){
  const char *base=strrchr(argv[fixture],'/');base=base?base+1:argv[fixture];
  char name[128];size_t length=strlen(base);CHECK(length>4 && length<sizeof(name) && !strcmp(base+length-4,".bin"));
  memcpy(name,base,length-4);name[length-4]=0;
  CHECK(strspn(name,"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-")==strlen(name));
  FILE *source=fopen(argv[fixture],"rb");CHECK(source);
  CHECK(fread(input,1,PAGES*SIZE,source)==PAGES*SIZE);CHECK(fgetc(source)==EOF);CHECK(!fclose(source));
  CHECK(write(fd,input,PAGES*SIZE)==PAGES*SIZE);
  errno=0;CHECK(ioctl(fd,GHY_PROBE_COMP_FPU(2),0)==-1 && errno==EOPNOTSUPP);
  errno=0;CHECK(ioctl(fd,GHY_PROBE_DEC_FPU(2),0)==-1 && errno==EOPNOTSUPP);
  uint32_t sizes[3][PAGES];CHECK(read(fd,sizes,sizeof(sizes))==sizeof(sizes));
  for(unsigned codec=0;codec<3;codec++)for(unsigned page=0;page<PAGES;page++)CHECK(sizes[codec][page]>0 && sizes[codec][page]<=4352);
  integrity(fd,sizes);
  for(unsigned index=0;index<operation_count;index++){
   const struct operation *op=&operations[index];
   if(vectors){CHECK(!check_state(fd,op->command));integrity(fd,sizes);}
   for(unsigned i=0;i<PAGES;i++){
    CHECK(ioctl(fd,op->command,0UL)==expected_result(op,sizes,i));
   }
  }
  integrity(fd,sizes);
  if(!measure)continue;
  for(int round=-2;round<9;round++){
   unsigned order[3*sizeof(operations)/sizeof(operations[0])];
   for(unsigned i=0;i<operation_count*3;i++)order[i]=i;
   shuffle(order,operation_count*3);
   for(unsigned index=0;index<operation_count*3;index++){
    const struct operation *op=&operations[order[index]%operation_count];
    unsigned state=order[index]/operation_count;
    CHECK(!check_state(fd,op->command));integrity(fd,sizes);
    uint64_t before=0,after=0;int rapl=energy(&before);
    begin();clear_vectors();uint64_t cpu_start=cpu_now(),start=now();
    for(unsigned i=0;i<ops;i++){
     if(invoke(fd,op->command,state)!=expected_result(op,sizes,i%PAGES)){fprintf(stderr,"Timed ioctl failed corpus=%s variant=%s operation=%s call=%u\n",name,op->variant,op->name,i);return 4;}
    }
    uint64_t elapsed=now()-start,cpu_elapsed=cpu_now()-cpu_start;
    double counts[4],fraction;end(counts,&fraction);rapl=rapl&&energy(&after);
    double uj=rapl?(double)((after+energy_range-before)%energy_range)/ops:-1,bytes=0;
    if(op->codec>=0)for(unsigned page=0;page<PAGES;page++)bytes+=(double)sizes[op->codec][page]/PAGES;
    integrity(fd,sizes);
    if(round>=0)printf("%s,%d,%s,%s,%s,%u,%.3f,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n",name,round,states[state],op->variant,op->name,ops,(double)elapsed/ops,(double)cpu_elapsed/ops,100.0*cpu_elapsed/elapsed,bytes,counts[0],counts[1],counts[2],counts[3],fraction,uj);
   }
   fflush(stdout);
  }
 }
 if(fds[0]>=0)for(unsigned i=0;i<4;i++)close(fds[i]);
 CHECK(!close(fd));free(input);
 if(!measure)printf("GHY_PROBE_CLIENT_PASS corpora=%d checks=%u vector_state_checked=%d fpu_control=%d\n",argc-first,checks,vectors,fpu_control);
 return 0;
}
