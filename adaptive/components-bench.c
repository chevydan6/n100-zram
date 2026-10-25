/* SPDX-License-Identifier: GPL-2.0-only */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>
#include <sched.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>
#include "api.h"
#define OPS 2048
static uint64_t now(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
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
 for(int i=0;i<512;i++)expected[i]=(unsigned char)(i*37+(i/32)*17);
 __asm__ volatile(ALL_YMM(LOAD_YMM) "syscall\n\t" ALL_YMM(SAVE_YMM)
 : "=a"(result)
 : "0"((long)SYS_ioctl),"D"((long)fd),"S"(command),"d"(0L),[expected]"r"(expected),[actual]"r"(actual)
 : "rcx","r11","memory","ymm0","ymm1","ymm2","ymm3","ymm4","ymm5","ymm6","ymm7","ymm8","ymm9","ymm10","ymm11","ymm12","ymm13","ymm14","ymm15");
 return result>0 && !memcmp(expected,actual,sizeof(expected))?0:-1;
}

static int counter_fds[4]={-1,-1,-1,-1};
static uint64_t energy_range;
static int read_energy_file(const char *path,uint64_t *v){FILE*f=fopen(path,"r");if(!f)return 0;int ok=fscanf(f,"%lu",v)==1;fclose(f);return ok;}
static int energy(uint64_t *v){return energy_range&&read_energy_file("/sys/class/powercap/intel-rapl:0/energy_uj",v);}
static void setup_counters(void){
 const uint64_t configs[]={PERF_COUNT_HW_CPU_CYCLES,PERF_COUNT_HW_INSTRUCTIONS,PERF_COUNT_HW_BRANCH_MISSES,PERF_COUNT_HW_CACHE_MISSES};
 for(int i=0;i<4;i++){
  struct perf_event_attr attr={.type=PERF_TYPE_HARDWARE,.size=sizeof(attr),.config=configs[i],.exclude_kernel=0,.exclude_hv=1,.read_format=PERF_FORMAT_GROUP|PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING};
  counter_fds[i]=syscall(SYS_perf_event_open,&attr,0,-1,i?counter_fds[0]:-1,0);
  if(counter_fds[i]<0){perror("Kernel-inclusive PMU group unavailable");for(int j=0;j<i;j++)close(counter_fds[j]);counter_fds[0]=-1;return;}
 }
}
static void counters(uint64_t *v){memset(v,0,7*sizeof(*v));if(counter_fds[0]>=0&&(read(counter_fds[0],v,7*sizeof(*v))!=7*sizeof(*v)||v[0]!=4)){perror("PMU group read");exit(9);}}
int main(int argc,char **argv)
{
 if(argc!=2&&argc!=3)return 2;
 int validate=argc==3&&!strcmp(argv[2],"--validate-only");if(argc==3&&!validate)return 2;
 if(!__builtin_cpu_supports("avx2")){fprintf(stderr,"AVX2 required for caller register-state fixture\n");return 77;}
 cpu_set_t allowed,chosen;if(sched_getaffinity(0,sizeof(allowed),&allowed))return 3;CPU_ZERO(&chosen);int cpu=0;for(;cpu<CPU_SETSIZE;cpu++)if(CPU_ISSET(cpu,&allowed))break;if(cpu==CPU_SETSIZE)return 3;CPU_SET(cpu,&chosen);if(sched_setaffinity(0,sizeof(chosen),&chosen))return 3;
 int fd=open(argv[1],O_RDWR);if(fd<0){perror("open component probe");return 4;}
 const char *batch_test=getenv("N100_COMPONENT_BATCH");
 if(batch_test){
  struct n100_component_config bad[]={{4096,0,0,0},{4096,0,0,17},{65536,0,0,2},{15,0,0,1},{4096,3,0,1},{4096,0,4,1}};
  for(unsigned i=0;i<sizeof(bad)/sizeof(bad[0]);i++){errno=0;if(ioctl(fd,N100_COMPONENT_CONFIG_BATCH,&bad[i])!=-1||errno!=EINVAL){fprintf(stderr,"Invalid batch configuration accepted\n");return 5;}}
 }
 setup_counters();if(!read_energy_file("/sys/class/powercap/intel-rapl:0/max_energy_range_uj",&energy_range))energy_range=0;uint64_t initial_energy;if(!energy(&initial_energy))energy_range=0;
 unsigned batch=1;const char *batch_env=getenv("N100_COMPONENT_BATCH");
 if(batch_env){char *end;unsigned long parsed=strtoul(batch_env,&end,10);if(!*batch_env||*end||parsed<1||parsed>16)return 2;batch=(unsigned)parsed;}
 int page_only=getenv("N100_COMPONENT_PAGE_ONLY")!=NULL;
 const unsigned sizes[]={16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536};
 const char *operations[]={"match-count","literal-copy","repeat8-copy"},*patterns[]={"equal","early","middle","late"},*variants[]={"scalar","fpu-scalar","sse","avx2"},*states[]={"clean","sse-dirty","ymm-dirty"};
 puts("bytes,operation,pattern,round,state,variant,ns_per_call,kernel_and_user_cycles_per_call,kernel_and_user_instructions,branch_misses,cache_misses,pmu_running_fraction,package_uj_per_call,batch");
 unsigned checked=0;uint32_t random=100;
 for(unsigned len=0;len<13;len++)for(unsigned op=0;op<3;op++)for(unsigned pattern=0;pattern<(op==0?4U:1U);pattern++){
  if(sizes[len]>65536/batch||(page_only&&sizes[len]!=4096))continue;
  struct n100_component_config config={.length=sizes[len],.operation=op,.pattern=pattern,.reserved=batch_env?batch:0};
  if(ioctl(fd,batch_env?N100_COMPONENT_CONFIG_BATCH:N100_COMPONENT_CONFIG,&config)||ioctl(fd,N100_COMPONENT_VERIFY)){perror("configure/verify");return 5;}
  long expected=(op!=0||pattern==0)?sizes[len]:pattern==1?0:pattern==2?sizes[len]/2:sizes[len]-1;expected=expected*batch+1;
  for(unsigned variant=0;variant<4;variant++){unsigned long command=N100_COMPONENT_RUN_SCALAR+variant;if(check_state(fd,command)||invoke(fd,command,0)!=expected){fprintf(stderr,"YMM sentinel or result failure\n");return 6;}}
  checked++;
  if(validate)continue;
  for(int round=-1;round<5;round++)for(int state=0;state<3;state++){
   int order[]={0,1,2,3};for(int i=3;i>0;i--){random^=random<<13;random^=random>>17;random^=random<<5;int j=random%(i+1),temp=order[i];order[i]=order[j];order[j]=temp;}
   for(int i=0;i<4;i++){
    unsigned variant=(unsigned)order[i];unsigned long command=N100_COMPONENT_RUN_SCALAR+variant;
    if(check_state(fd,command))return 6;
    uint64_t before[7],after[7],eb=0,ea=0;int rapl=energy(&eb);counters(before);clear_vectors();uint64_t start=now();
    for(int n=0;n<OPS;n++)if(invoke(fd,command,state)!=expected){fprintf(stderr,"Unexpected timed result\n");return 7;}
    uint64_t elapsed=now()-start;counters(after);rapl=rapl&&energy(&ea);
    double values[4],fraction=-1;for(int m=0;m<4;m++)values[m]=counter_fds[0]<0?-1.0:(double)(after[3+m]-before[3+m])/OPS;
    if(counter_fds[0]>=0&&after[1]>before[1])fraction=(double)(after[2]-before[2])/(after[1]-before[1]);
    double uj=rapl?(double)((ea+energy_range-eb)%energy_range)/OPS:-1;
    if(ioctl(fd,N100_COMPONENT_VERIFY))return 8;
    if(round>=0)printf("%u,%s,%s,%d,%s,%s,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f,%.6f,%u\n",sizes[len],operations[op],patterns[pattern],round,states[state],variants[variant],(double)elapsed/OPS,values[0],values[1],values[2],values[3],fraction,uj,batch);
   }
   fflush(stdout);
  }
 }
 close(fd);fprintf(stderr,"COMPONENT_VALIDATION_PASS configurations=%u; all sixteen YMM sentinels checked\n",checked);return 0;
}
