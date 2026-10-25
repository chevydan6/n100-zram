/* SPDX-License-Identifier: GPL-2.0-only */
/* Independently implemented research codec; no upstream codec code copied. */
#include "gzram.h"
#include <stdint.h>
#include <string.h>
#include <immintrin.h>
#include "tables.h"
#define MAX_PAGE 4096
#define HEADER 8
#define AVX __attribute__((target("avx2")))
enum { RAW, ZERO, REPEAT4, REPEAT8, MASK32, REPEAT16, REPEAT32 };
struct scan { uint8_t masks[MAX_PAGE/32]; unsigned nonzero, repeated; };
typedef void (*scan_fn)(const uint8_t *,size_t,struct scan *);
typedef void (*pack_fn)(const uint8_t *,uint8_t *,unsigned);
typedef void (*repeat_fn)(uint8_t *,const uint8_t *,size_t,unsigned);
static uint32_t load32(const void *p) { uint32_t v;memcpy(&v,p,4);return v; }
static uint64_t load64(const void *p) { uint64_t v;memcpy(&v,p,8);return v; }
static void scan_scalar(const uint8_t *src,size_t n,struct scan *s)
{
 s->nonzero=0;s->repeated=15;
 for(size_t group=0;group<n/32;group++) {
  unsigned mask=0;
  for(unsigned lane=0;lane<8;lane++) {
   size_t at=group*32+lane*4;uint32_t v=load32(src+at);
   if(v)mask|=1U<<lane;
   if(v!=load32(src))s->repeated&=~1U;
   if(v!=load32(src+at%8))s->repeated&=~2U;
   if(v!=load32(src+at%16))s->repeated&=~4U;
   if(v!=load32(src+at%32))s->repeated&=~8U;
  }
  s->masks[group]=(uint8_t)mask;s->nonzero+=gz_count[mask];
 }
}
AVX static void scan_avx2(const uint8_t *src,size_t n,struct scan *s)
{
 __m256i zero=_mm256_setzero_si256();
 __m256i p4=_mm256_set1_epi32((int)load32(src));
 __m256i p8=_mm256_set1_epi64x((long long)load64(src));
 __m256i p16=_mm256_broadcastsi128_si256(_mm_loadu_si128((const __m128i *)src));
 __m256i p32=_mm256_loadu_si256((const __m256i *)src);
 __m256i d4=zero,d8=zero,d16=zero,d32=zero;s->nonzero=0;
 for(size_t group=0;group<n/32;group++) {
  __m256i v=_mm256_loadu_si256((const __m256i *)(src+group*32));
  unsigned mask=(unsigned)_mm256_movemask_ps(_mm256_castsi256_ps(_mm256_cmpeq_epi32(v,zero)))^255U;
  s->masks[group]=(uint8_t)mask;s->nonzero+=gz_count[mask];
  d4=_mm256_or_si256(d4,_mm256_xor_si256(v,p4));
  d8=_mm256_or_si256(d8,_mm256_xor_si256(v,p8));
  d16=_mm256_or_si256(d16,_mm256_xor_si256(v,p16));
  d32=_mm256_or_si256(d32,_mm256_xor_si256(v,p32));
 }
 s->repeated=(unsigned)_mm256_testz_si256(d4,d4)|((unsigned)_mm256_testz_si256(d8,d8)<<1)|((unsigned)_mm256_testz_si256(d16,d16)<<2)|((unsigned)_mm256_testz_si256(d32,d32)<<3);
}
static void pack_scalar(const uint8_t *src,uint8_t *dst,unsigned mask)
{
 for(unsigned lane=0;lane<8;lane++)if(mask&(1U<<lane)){memcpy(dst,src+lane*4,4);dst+=4;}
}
static void unpack_scalar(const uint8_t *src,uint8_t *dst,unsigned mask)
{
 for(unsigned lane=0;lane<8;lane++) {
  if(mask&(1U<<lane)){memcpy(dst+lane*4,src,4);src+=4;}
  else memset(dst+lane*4,0,4);
 }
}
AVX static void pack_avx2(const uint8_t *src,uint8_t *dst,unsigned mask)
{
 if(!mask)return;
 __m256i v=_mm256_loadu_si256((const __m256i *)src);
 if(mask==255){_mm256_storeu_si256((__m256i *)dst,v);return;}
 __m256i indices=_mm256_loadu_si256((const __m256i *)gz_encode_indices[mask]);
 uint32_t tmp[8];_mm256_storeu_si256((__m256i *)tmp,_mm256_permutevar8x32_epi32(v,indices));
 memcpy(dst,tmp,gz_count[mask]*4U);
}
AVX static void unpack_avx2(const uint8_t *src,uint8_t *dst,unsigned mask)
{
 uint32_t tmp[8]={0};memcpy(tmp,src,gz_count[mask]*4U);
 __m256i v=_mm256_loadu_si256((const __m256i *)tmp);
 __m256i indices=_mm256_loadu_si256((const __m256i *)gz_decode_indices[mask]);
 __m256i bits=_mm256_setr_epi32(1,2,4,8,16,32,64,128);
 __m256i absent=_mm256_cmpeq_epi32(_mm256_and_si256(bits,_mm256_set1_epi32((int)mask)),_mm256_setzero_si256());
 _mm256_storeu_si256((__m256i *)dst,_mm256_andnot_si256(absent,_mm256_permutevar8x32_epi32(v,indices)));
}
static void repeat_scalar(uint8_t *dst,const uint8_t *pattern,size_t n,unsigned period)
{
 for(size_t at=0;at<n;at+=period)memcpy(dst+at,pattern,period);
}
AVX static void repeat_avx2(uint8_t *dst,const uint8_t *pattern,size_t n,unsigned period)
{
 __m256i v;
 if(period==4)v=_mm256_set1_epi32((int)load32(pattern));
 else if(period==8)v=_mm256_set1_epi64x((long long)load64(pattern));
 else if(period==16)v=_mm256_broadcastsi128_si256(_mm_loadu_si128((const __m128i *)pattern));
 else v=_mm256_loadu_si256((const __m256i *)pattern);
 size_t at=0;
 for(;n-at>=32;at+=32)_mm256_storeu_si256((__m256i *)(dst+at),v);
 for(;at<n;at+=period)memcpy(dst+at,pattern,period);
}
int gzram_avx2_available(void) { return !!__builtin_cpu_supports("avx2"); }
static void header(uint8_t *dst,size_t n,unsigned log,unsigned raw)
{
 memcpy(dst,"GZR1",4);dst[4]=(uint8_t)n;dst[5]=(uint8_t)(n>>8);dst[6]=(uint8_t)log;dst[7]=(uint8_t)raw;
}
static int raw_page(const uint8_t *src,size_t n,uint8_t *dst,size_t cap,unsigned log)
{
 if(cap<n+HEADER)return 0;
 if(n)memcpy(dst+HEADER,src,n);
 header(dst,n,log,1);return (int)(n+HEADER);
}
static int encode(const void *input,size_t n,void *output,size_t cap,unsigned log,scan_fn scan,pack_fn pack)
{
 if(n>MAX_PAGE||log<5||log>12||!output||(!input&&n)||cap<HEADER)return 0;
 const uint8_t *src=input;uint8_t *dst=output;size_t block=(size_t)1<<log,chunks=(n+block-1)/block,pos=HEADER+chunks;
 if(pos>cap)return raw_page(src,n,dst,cap,log);
 header(dst,n,log,0);
 for(size_t chunk=0,offset=0;chunk<chunks;chunk++,offset+=block) {
  size_t len=n-offset;if(len>block)len=block;
  struct scan s;unsigned mode=RAW,period=0;size_t needed=len;
  if(len%32==0) {
   scan(src+offset,len,&s);
   if(!s.nonzero){mode=ZERO;needed=0;}
   else {
    const unsigned periods[]={4,8,16,32},modes[]={REPEAT4,REPEAT8,REPEAT16,REPEAT32};
    for(unsigned k=0;k<4;k++)if((s.repeated&(1U<<k))&&periods[k]<len){mode=modes[k];period=periods[k];needed=period;break;}
    if(mode==RAW&&len/32+s.nonzero*4U<len){mode=MASK32;needed=len/32+s.nonzero*4U;}
   }
  }
  if(needed>cap-pos)return raw_page(src,n,dst,cap,log);
  dst[HEADER+chunk]=(uint8_t)mode;
  if(mode==RAW){memcpy(dst+pos,src+offset,len);pos+=len;}
  else if(mode==MASK32) {
   size_t groups=len/32;memcpy(dst+pos,s.masks,groups);pos+=groups;
   for(size_t group=0;group<groups;group++){unsigned mask=s.masks[group];pack(src+offset+group*32,dst+pos,mask);pos+=gz_count[mask]*4U;}
  } else if(mode!=ZERO){memcpy(dst+pos,src+offset,period);pos+=period;}
 }
 if(pos>=n+HEADER)return raw_page(src,n,dst,cap,log);
 return (int)pos;
}
static int decode(const void *input,size_t size,void *output,size_t cap,pack_fn unpack,repeat_fn repeat)
{
 if(!input||size<HEADER||size>MAX_PAGE+HEADER)return -1;
 const uint8_t *src=input;uint8_t *dst=output;
 if(memcmp(src,"GZR1",4)||src[6]<5||src[6]>12||src[7]>1)return -1;
 size_t n=(size_t)src[4]+((size_t)src[5]<<8);if(n>MAX_PAGE||n>cap||(!output&&n))return -1;
 if(src[7]){if(size!=n+HEADER)return -1;if(n)memcpy(dst,src+HEADER,n);return (int)n;}
 size_t block=(size_t)1<<src[6],chunks=(n+block-1)/block,pos=HEADER+chunks;
 if(pos>size)return -1;
 for(size_t chunk=0,offset=0;chunk<chunks;chunk++,offset+=block) {
  size_t len=n-offset;if(len>block)len=block;
  unsigned mode=src[HEADER+chunk],period=0;
  if(mode==RAW){if(len>size-pos)return -1;memcpy(dst+offset,src+pos,len);pos+=len;}
  else if(mode==ZERO)memset(dst+offset,0,len);
  else if(mode==MASK32) {
   if(len%32)return -1;
   size_t groups=len/32;if(groups>size-pos)return -1;const uint8_t *masks=src+pos;pos+=groups;size_t needed=0;
   for(size_t group=0;group<groups;group++)needed+=gz_count[masks[group]]*4U;
   if(needed>size-pos)return -1;
   for(size_t group=0;group<groups;group++){unsigned mask=masks[group];unpack(src+pos,dst+offset+group*32,mask);pos+=gz_count[mask]*4U;}
  } else {
   if(mode==REPEAT4)period=4;else if(mode==REPEAT8)period=8;else if(mode==REPEAT16)period=16;else if(mode==REPEAT32)period=32;else return -1;
   if(len%period||period>len||period>size-pos)return -1;
   repeat(dst+offset,src+pos,len,period);pos+=period;
  }
 }
 return pos==size?(int)n:-1;
}
int gzram_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log){return encode(s,n,d,cap,log,scan_scalar,pack_scalar);}
int gzram_encode_avx2(const void *s,size_t n,void *d,size_t cap,unsigned log){return gzram_avx2_available()?encode(s,n,d,cap,log,scan_avx2,pack_avx2):gzram_encode_scalar(s,n,d,cap,log);}
int gzram_decode_scalar(const void *s,size_t n,void *d,size_t cap){return decode(s,n,d,cap,unpack_scalar,repeat_scalar);}
int gzram_decode_avx2(const void *s,size_t n,void *d,size_t cap){return gzram_avx2_available()?decode(s,n,d,cap,unpack_avx2,repeat_avx2):gzram_decode_scalar(s,n,d,cap);}
