// SPDX-License-Identifier: GPL-2.0-only
// Instrumented whole-codec compression profile, not a performance benchmark.
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "zstd.h"
int main(int argc,char **argv){if(argc!=3)return 2;FILE *f=fopen(argv[1],"rb");if(!f)return 3;size_t count=128*4096;unsigned char *data=malloc(count),*out=malloc(ZSTD_compressBound(4096));if(!data||!out||fread(data,1,count,f)!=count||fgetc(f)!=EOF)return 4;fclose(f);ZSTD_CCtx *ctx=ZSTD_createCCtx();if(!ctx)return 5;int loops=atoi(argv[2]);if(loops<1||loops>5000)return 6;uint64_t bytes=0;for(int k=0;k<loops;k++)for(int i=0;i<128;i++){size_t n=ZSTD_compressCCtx(ctx,out,ZSTD_compressBound(4096),data+i*4096,4096,3);if(ZSTD_isError(n))return 7;bytes+=n;}ZSTD_freeCCtx(ctx);printf("pages=%d bytes=%llu\n",loops*128,(unsigned long long)bytes);free(data);free(out);return 0;}
