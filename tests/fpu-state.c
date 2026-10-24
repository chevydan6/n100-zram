/* SPDX-License-Identifier: GPL-2.0-only */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/syscall.h>
/* Raw syscalls ensure the compiler/libc cannot clobber the sentinel registers
 * between loading them and inspecting state returned from kernel ZRAM I/O. */
#define LOAD(n) "vmovdqu " #n "*32(%[expected]), %%ymm" #n "\n\t"
#define SAVE(n) "vmovdqu %%ymm" #n ", " #n "*32(%[actual])\n\t"
#define ALL(M) M(0) M(1) M(2) M(3) M(4) M(5) M(6) M(7) M(8) M(9) M(10) M(11) M(12) M(13) M(14) M(15)
__attribute__((target("avx2"),noinline))
static long operation(int fd,void *page,long offset,int reading,const void *expected,void *actual)
{
 long result;register long off __asm__("r10")=offset;
 __asm__ volatile(ALL(LOAD) "syscall\n\t" ALL(SAVE)
  : "=a"(result)
  : "0"((long)(reading?SYS_pread64:SYS_pwrite64)),"D"((long)fd),"S"(page),"d"(4096L),"r"(off),[expected]"r"(expected),[actual]"r"(actual)
  : "rcx","r11","memory","ymm0","ymm1","ymm2","ymm3","ymm4","ymm5","ymm6","ymm7","ymm8","ymm9","ymm10","ymm11","ymm12","ymm13","ymm14","ymm15");
 return result;
}
int main(int argc,char **argv)
{
 if(argc!=3)return 2;
 if(!__builtin_cpu_supports("avx2")){puts("FPU_STATE_SKIP_NO_AVX2");return 0;}
 int base=atoi(argv[2]);if(base<0||base>3)return 2;
 int fd=open(argv[1],O_RDWR|O_DIRECT);if(fd<0){perror("open");return 3;}
 void *input=NULL,*output=NULL;unsigned char expected[512],actual[512];
 if(posix_memalign(&input,4096,4096)||posix_memalign(&output,4096,4096))return 4;
 for(int i=0;i<512;i++)expected[i]=(unsigned char)(i*37+(i/32)*17+base);
 for(int page=0;page<128;page++){
  int period=1+(page%127);
  for(int j=0;j<4096;j++)((unsigned char *)input)[j]=(j%period)*31+page+base;
  long offset=(page*4L+base)*4096;
  if(operation(fd,input,offset,0,expected,actual)!=4096||memcmp(expected,actual,512)){fprintf(stderr,"FPU state/write failure base=%d page=%d\n",base,page);return 5;}
  if(operation(fd,output,offset,1,expected,actual)!=4096||memcmp(expected,actual,512)||memcmp(input,output,4096)){fprintf(stderr,"FPU state/read failure base=%d page=%d\n",base,page);return 6;}
 }
 free(input);free(output);close(fd);printf("FPU_STATE_PASS base=%d pages=128\n",base);return 0;
}
