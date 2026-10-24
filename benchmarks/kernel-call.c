/* SPDX-License-Identifier: GPL-2.0-only */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sched.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>
#include "bench.h"
#define BLOCK 4096
#define OPS 4096
static uint64_t seed=100;
static uint32_t random32(void){seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;return seed;}
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
static void fill(unsigned char *input,int kind)
{
 if(kind==4){FILE*f=fopen("/usr/bin/bash","rb");if(!f||fread(input,1,N100_BENCH_PAGES*BLOCK,f)!=N100_BENCH_PAGES*BLOCK){perror("corpus");exit(3);}fclose(f);return;}
 for(int p=0;p<N100_BENCH_PAGES;p++)for(int i=0;i<BLOCK;i++){
  uint32_t value;
  if(kind==0)value=random32();
  else if(kind==1)value=(i%64<56)?0:random32();
  else if(kind==2)value=(i%127)*37+p;
  else if(kind==5)value=i<2048?random32():0;
  else value=(i%256<128)?(uint32_t)(i%31):random32();
  input[p*BLOCK+i]=(unsigned char)value;
 }
}
int main(int argc,char **argv)
{
 if(argc!=2){fprintf(stderr,"usage: kernel-call DEVICE\n");return 2;}
 if(!__builtin_cpu_supports("avx2")){fprintf(stderr,"AVX2 with OS support required\n");return 3;}
 cpu_set_t set;CPU_ZERO(&set);CPU_SET(0,&set);if(sched_setaffinity(0,sizeof(set),&set))return 4;
 int fd=open(argv[1],O_RDWR);if(fd<0){perror("open");return 5;}
 size_t bytes=N100_BENCH_PAGES*BLOCK;
 unsigned char *input=malloc(bytes),*mirror=malloc(bytes);if(!input||!mirror)return 6;
 struct perf_event_attr attr={.type=PERF_TYPE_HARDWARE,.size=sizeof(attr),.config=PERF_COUNT_HW_CPU_CYCLES,.exclude_hv=1};
 int counter=syscall(SYS_perf_event_open,&attr,0,-1,-1,0);if(counter<0)perror("cycles counter");
 const char *names[]={"random","sparse","period127","mixed","bash-elf","halfzero"};
 const char *states[]={"clean","sse-dirty","ymm-dirty"};
 unsigned long commands[]={N100_BENCH_COMP_SCALAR,N100_BENCH_COMP_SIMD,N100_BENCH_DEC_SCALAR,N100_BENCH_DEC_SIMD};
 puts("corpus,round,state,operation,ns_per_page,core_cycles_per_page");
 for(int kind=0;kind<6;kind++){
  fill(input,kind);
  if(write(fd,input,bytes)!=(ssize_t)bytes || ioctl(fd,N100_BENCH_VALIDATE)<0){perror("prepare/validate");return 7;}
  for(int round=-1;round<9;round++){
   int state_order[]={0,1,2};
   for(int i=2;i>0;i--){int j=random32()%(i+1),t=state_order[i];state_order[i]=state_order[j];state_order[j]=t;}
   for(int state_index=0;state_index<3;state_index++){
   int state=state_order[state_index];
   int order[]={0,1,2,3};for(int i=3;i>0;i--){int j=random32()%(i+1),t=order[i];order[i]=order[j];order[j]=t;}
   for(int j=0;j<4;j++){
    int operation=order[j];uint64_t cb=0,ce=0;
    if(check_state(fd,commands[operation])){fprintf(stderr,"YMM state preservation failed\n");return 11;}
    clear_vectors();
    if(counter>=0 && read(counter,&cb,sizeof(cb))!=sizeof(cb))return 8;
    uint64_t start=now();
    for(int n=0;n<OPS;n++)if(invoke(fd,commands[operation],state)<=0){fprintf(stderr,"codec operation failed\n");return 9;}
    uint64_t elapsed=now()-start;
    if(counter>=0 && read(counter,&ce,sizeof(ce))!=sizeof(ce))return 8;
    if(round>=0)printf("%s,%d,%s,%d,%.3f,%.3f\n",names[kind],round,states[state],operation,(double)elapsed/OPS,counter<0?-1.0:(double)(ce-cb)/OPS);
   }
   if(ioctl(fd,N100_BENCH_VALIDATE)<0 || read(fd,mirror,bytes)!=(ssize_t)bytes || memcmp(input,mirror,bytes)){fprintf(stderr,"post-batch integrity failure\n");return 10;}
   fflush(stdout);
  }
  }
 }
 if(counter>=0)close(counter);
 close(fd);free(input);free(mirror);return 0;
}
