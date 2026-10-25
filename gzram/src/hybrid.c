/* SPDX-License-Identifier: GPL-2.0-only */
/* Experimental versioned GZRAM/LZ4 container. Original codecs stay separate. */
#define _GNU_SOURCE
#include "gzram.h"
#include <linux/lz4.h>
#include <stdint.h>
#include <string.h>
#define PAGE 4096
#define HEADER 8
#define MAX_FRAME (LZ4_COMPRESSBOUND(PAGE)+HEADER)
int gzram_base_encode_scalar(const void *,size_t,void *,size_t,unsigned);
int gzram_base_encode_avx2(const void *,size_t,void *,size_t,unsigned);
int gzram_base_decode_scalar(const void *,size_t,void *,size_t);
int gzram_base_decode_avx2(const void *,size_t,void *,size_t);
typedef int (*encode_fn)(const void *,size_t,void *,size_t,unsigned);
typedef int (*decode_fn)(const void *,size_t,void *,size_t);
static void header(uint8_t *dst,size_t n,unsigned mode)
{
 memcpy(dst,"GHY1",4);dst[4]=(uint8_t)n;dst[5]=(uint8_t)(n>>8);dst[6]=(uint8_t)mode;dst[7]=0;
}
/* Keep the 4 KiB compression workspace off the accepted GZRAM call path.
 * Userspace stack workspace; any kernel port would need per-stream storage. */
__attribute__((noinline)) static int lz4_encode(const void *src,void *dst,int n,int cap)
{
 LZ4_stream_t work;
 return LZ4_compress_default(src,dst,n,cap,&work);
}
static int select_gzram(const uint8_t *src,size_t n)
{
#if defined(GZRAM_HYBRID_SAMPLE)
#if defined(GZRAM_HYBRID_RECURRENCE)
 if(n>=64&&!memcmp(src,src+32,32))return 1;
#endif
 unsigned samples=n/4<64?(unsigned)(n/4):64;
 if(!samples)return 0;
 size_t stride=n/samples;unsigned zero=0;
 for(unsigned i=0;i<samples;i++){uint32_t word;memcpy(&word,src+i*stride,4);zero+=word==0;}
#if defined(GZRAM_HYBRID_RECURRENCE)
 /* Classification only: a repeated nonzero prefix suggests an LZ dictionary.
  * memmem never proves a repeated block; exact codec decoding remains mandatory. */
 if(zero*8>=samples&&n>=16){
  uint64_t first;memcpy(&first,src,8);
  size_t span=n-1<1031?n-1:1031;
  if(first&&memmem(src+1,span,src,8))return 0;
 }
#endif
 return zero*8>=samples;
#else
 (void)src;(void)n;return 1;
#endif
}
static int encode(const void *input,size_t n,void *output,size_t cap,unsigned log,encode_fn gz)
{
 if(n>PAGE||log<5||log>12||!output||(!input&&n)||cap<HEADER)return 0;
 const uint8_t *src=input;uint8_t *dst=output;
 if(!n){header(dst,0,0);return HEADER;}
 if(select_gzram(src,n)){
  int packed=gz(src,n,dst+HEADER,cap-HEADER,log);
  /* Threshold includes nested GZRAM framing. Exact decoding is still mandatory. */
  if(packed>0&&(size_t)packed<=n*3/4){header(dst,n,1);return packed+HEADER;}
 }
 size_t room=cap-HEADER;if(room>LZ4_COMPRESSBOUND(PAGE))room=LZ4_COMPRESSBOUND(PAGE);
 int packed=lz4_encode(src,dst+HEADER,(int)n,(int)room);
 if(packed>0&&(size_t)packed<n){header(dst,n,2);return packed+HEADER;}
 if(n>cap-HEADER)return 0;
 memcpy(dst+HEADER,src,n);header(dst,n,0);return (int)(n+HEADER);
}
static int decode(const void *input,size_t size,void *output,size_t cap,decode_fn gz)
{
 if(!input||size<HEADER||size>MAX_FRAME)return -1;
 const uint8_t *src=input;uint8_t *dst=output;
 if(memcmp(src,"GHY1",4)||src[6]>2||src[7])return -1;
 size_t n=(size_t)src[4]+((size_t)src[5]<<8);
 if(n>PAGE||n>cap||(!output&&n))return -1;
 unsigned mode=src[6];
 if(mode==0){if(size!=n+HEADER)return -1;if(n)memcpy(dst,src+HEADER,n);return (int)n;}
 if(!n)return -1; /* Empty frames use the canonical raw representation. */
 int got=mode==1?gz(src+HEADER,size-HEADER,dst,n):LZ4_decompress_safe((const char *)src+HEADER,(char *)dst,(int)(size-HEADER),(int)n);
 return got==(int)n?got:-1;
}
int gzram_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log){return encode(s,n,d,cap,log,gzram_base_encode_scalar);}
int gzram_encode_avx2(const void *s,size_t n,void *d,size_t cap,unsigned log){return encode(s,n,d,cap,log,gzram_base_encode_avx2);}
int gzram_decode_scalar(const void *s,size_t n,void *d,size_t cap){return decode(s,n,d,cap,gzram_base_decode_scalar);}
int gzram_decode_avx2(const void *s,size_t n,void *d,size_t cap){return decode(s,n,d,cap,gzram_base_decode_avx2);}
