// SPDX-License-Identifier: GPL-2.0-only
// Standalone experiment: zstd-style 64-bit match count, not a complete codec.
#define _GNU_SOURCE
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/mman.h>
#include <unistd.h>
#include <pthread.h>
static uint32_t load32(const unsigned char *p){uint32_t x;memcpy(&x,p,4);return x;}
static uint16_t load16(const unsigned char *p){uint16_t x;memcpy(&x,p,2);return x;}
static uint64_t load64(const unsigned char *p){uint64_t x;memcpy(&x,p,8);return x;}
__attribute__((noinline)) static size_t control(const unsigned char *a,const unsigned char *b,size_t n){size_t i=0;while(n-i>=8){uint64_t d=load64(a+i)^load64(b+i);if(d)return i+__builtin_ctzll(d)/8;i+=8;}if(n-i>=4&&load32(a+i)==load32(b+i))i+=4;if(n-i>=2&&load16(a+i)==load16(b+i))i+=2;if(i<n&&a[i]==b[i])i++;return i;}
__attribute__((noinline)) static size_t grouped(const unsigned char *a,const unsigned char *b,size_t n){size_t i=0;while(n-i>=32){uint64_t d0=load64(a+i)^load64(b+i),d1=load64(a+i+8)^load64(b+i+8),d2=load64(a+i+16)^load64(b+i+16),d3=load64(a+i+24)^load64(b+i+24);if(d0)return i+__builtin_ctzll(d0)/8;if(d1)return i+8+__builtin_ctzll(d1)/8;if(d2)return i+16+__builtin_ctzll(d2)/8;if(d3)return i+24+__builtin_ctzll(d3)/8;i+=32;}while(n-i>=8){uint64_t d=load64(a+i)^load64(b+i);if(d)return i+__builtin_ctzll(d)/8;i+=8;}if(n-i>=4&&load32(a+i)==load32(b+i))i+=4;if(n-i>=2&&load16(a+i)==load16(b+i))i+=2;if(i<n&&a[i]==b[i])i++;return i;}
__attribute__((noinline)) static size_t adaptive(const unsigned char *a,const unsigned char *b,size_t n){size_t i=0;if(n>=8){uint64_t d=load64(a)^load64(b);if(d)return __builtin_ctzll(d)/8;i=8;}while(n-i>=32){uint64_t d0=load64(a+i)^load64(b+i),d1=load64(a+i+8)^load64(b+i+8),d2=load64(a+i+16)^load64(b+i+16),d3=load64(a+i+24)^load64(b+i+24);if(d0)return i+__builtin_ctzll(d0)/8;if(d1)return i+8+__builtin_ctzll(d1)/8;if(d2)return i+16+__builtin_ctzll(d2)/8;if(d3)return i+24+__builtin_ctzll(d3)/8;i+=32;}while(n-i>=8){uint64_t d=load64(a+i)^load64(b+i);if(d)return i+__builtin_ctzll(d)/8;i+=8;}if(n-i>=4&&load32(a+i)==load32(b+i))i+=4;if(n-i>=2&&load16(a+i)==load16(b+i))i+=2;if(i<n&&a[i]==b[i])i++;return i;}
static uint64_t rng(uint64_t *x){*x^=*x<<13;*x^=*x>>7;*x^=*x<<17;return *x;}
static void *validate(void *arg){uint64_t x=(uintptr_t)arg+42;unsigned char a[512],b[512];for(int t=0;t<250000;t++){size_t n=rng(&x)%480,off=rng(&x)%16,hit=rng(&x)%(n+1);for(size_t i=0;i<n+off;i++)a[i]=b[i]=(unsigned char)rng(&x);if(hit<n)b[off+hit]^=1;if(control(a+off,b+off,n)!=hit||grouped(a+off,b+off,n)!=hit||adaptive(a+off,b+off,n)!=hit)abort();}return NULL;}
static uint64_t now(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
int main(int argc,char **argv){pthread_t th[4];for(uintptr_t i=0;i<4;i++)if(pthread_create(&th[i],NULL,validate,(void*)i))return 2;for(int i=0;i<4;i++)pthread_join(th[i],NULL);long ps=sysconf(_SC_PAGESIZE);unsigned char *a=mmap(NULL,ps*2,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0),*b=mmap(NULL,ps*2,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);if(a==MAP_FAILED||b==MAP_FAILED||mprotect(a+ps,ps,PROT_NONE)||mprotect(b+ps,ps,PROT_NONE))return 3;for(size_t n=0;n<=512;n++){memset(a+ps-n,7,n);memset(b+ps-n,7,n);for(size_t i=0;i<=n;i++){if(i<n)b[ps-n+i]^=1;if(control(a+ps-n,b+ps-n,n)!=i||grouped(a+ps-n,b+ps-n,n)!=i||adaptive(a+ps-n,b+ps-n,n)!=i)abort();if(i<n)b[ps-n+i]^=1;}}munmap(a,ps*2);munmap(b,ps*2);fprintf(stderr,"validated 1000000 randomized concurrent cases plus guarded boundaries\n");if(argc>1&&!strcmp(argv[1],"--validate"))return 0;
 int mismatch=argc>1&&!strcmp(argv[1],"--mismatch"); unsigned char aa[1056],bb[1056];memset(aa,1,sizeof aa);memset(bb,1,sizeof bb);size_t lengths[]={0,1,7,8,15,31,32,63,127,255,511};volatile size_t sink=0;puts("round,length,variant,ns_per_call");for(int round=0;round<15;round++){for(size_t l=0;l<sizeof(lengths)/sizeof(*lengths);l++){size_t n=lengths[(l+round)%11];if(mismatch)bb[n]^=1;for(int side=0;side<3;side++){int variant=(side+round+l)%3;uint64_t t=now();for(int k=0;k<200000;k++)sink+=(variant==0?control:variant==1?grouped:adaptive)(aa,bb,mismatch?512:n);uint64_t dt=now()-t;printf("%d,%zu,%s,%.3f\n",round,n,variant==0?"control":variant==1?"grouped":"adaptive",(double)dt/200000);}if(mismatch)bb[n]^=1;}}return sink==0xdeadbeef;}
