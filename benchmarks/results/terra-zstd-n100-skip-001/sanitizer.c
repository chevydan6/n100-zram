// SPDX-License-Identifier: GPL-2.0-only
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zstd.h"
#define N 4096
static unsigned char *pages;static size_t total;
static void *worker(void *arg){uintptr_t id=(uintptr_t)arg;ZSTD_CCtx*c=ZSTD_createCCtx();ZSTD_DCtx*d=ZSTD_createDCtx();if(!c||!d)abort();for(size_t i=id;i<total;i+=4){unsigned char out[4352],decoded[N+64];memset(out,0xa5,sizeof(out));size_t n=ZSTD_compressCCtx(c,out,4288,pages+i*N,N,3);if(ZSTD_isError(n)||n>4288)abort();for(size_t k=4288;k<sizeof(out);k++)if(out[k]!=0xa5)abort();memset(decoded,0xa5,sizeof(decoded));size_t z=ZSTD_decompressDCtx(d,decoded,N,out,n);if(z!=N||memcmp(decoded,pages+i*N,N))abort();for(size_t k=N;k<sizeof(decoded);k++)if(decoded[k]!=0xa5)abort();if(!ZSTD_isError(ZSTD_decompressDCtx(d,decoded,N,out,n-1)))abort();if(!ZSTD_isError(ZSTD_decompressDCtx(d,decoded,N-1,out,n)))abort();for(unsigned m=0;m<3;m++){size_t pos=(i*131+m*997)%n;out[pos]^=(unsigned char)(1U<<(m+1));z=ZSTD_decompressDCtx(d,decoded,N,out,n);if(!ZSTD_isError(z)&&z>N)abort();for(size_t k=N;k<sizeof(decoded);k++)if(decoded[k]!=0xa5)abort();out[pos]^=(unsigned char)(1U<<(m+1));}}ZSTD_freeCCtx(c);ZSTD_freeDCtx(d);return NULL;}
int main(int argc,char**argv){if(argc<2||argc>65)return 2;total=(argc-1)*128;pages=malloc(total*N);if(!pages)return 3;for(int i=1;i<argc;i++){FILE*f=fopen(argv[i],"rb");if(!f||fread(pages+(i-1)*128*N,1,128*N,f)!=128*N||fgetc(f)!=EOF)return 4;fclose(f);}pthread_t p[4];for(uintptr_t i=0;i<4;i++)if(pthread_create(&p[i],NULL,worker,(void*)i))return 5;for(int i=0;i<4;i++)pthread_join(p[i],NULL);free(pages);printf("sanitizer pass pages=%zu threads=4\n",total);return 0;}
