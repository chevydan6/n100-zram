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
struct scan { uint8_t masks[MAX_PAGE/32]; unsigned nonzero, repeated;
#if defined(GZRAM_EMBED_PREFIX)
 const uint8_t *page;uint64_t key;size_t offset;unsigned anchor,limit,hint;
#endif
};
typedef void (*scan_fn)(const uint8_t *,size_t,struct scan *);
typedef void (*pack_fn)(const uint8_t *,uint8_t *,unsigned);
typedef void (*repeat_fn)(uint8_t *,const uint8_t *,size_t,unsigned);
static uint32_t load32(const void *p) { uint32_t v;memcpy(&v,p,4);return v; }
static uint64_t load64(const void *p) { uint64_t v;memcpy(&v,p,8);return v; }
#if defined(GZRAM_SCALAR_FAST)
/* One prefix-derived repeat candidate is sufficient: a shorter repeated prefix
 * also defines every longer candidate in the recognized power-of-two family. */
static void scan_scalar(const uint8_t *src,size_t n,struct scan *s)
{
 uint64_t prefix[4];for(unsigned i=0;i<4;i++)prefix[i]=load64(src+i*8);
 unsigned period=32;
 if(prefix[0]==prefix[1]&&prefix[0]==prefix[2]&&prefix[0]==prefix[3])period=8;
 else if(prefix[0]==prefix[2]&&prefix[1]==prefix[3])period=16;
 int repeated=period<n;
 for(size_t at=32;repeated&&at<n;at+=8)if(load64(src+at)!=prefix[(at&(period-1))/8])repeated=0;
 if(repeated){s->nonzero=prefix[0]||prefix[1]||prefix[2]||prefix[3]?1:0;s->repeated=period==8?((uint32_t)prefix[0]==(uint32_t)(prefix[0]>>32)?1:2):period==16?4:8;return;}
 s->nonzero=0;s->repeated=0;
 for(size_t group=0;group<n/32;group++){
  unsigned mask=0;for(unsigned lane=0;lane<8;lane++)mask|=(unsigned)(load32(src+group*32+lane*4)!=0)<<lane;
  s->masks[group]=(uint8_t)mask;s->nonzero+=gz_count[mask];
 }
}
#else
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
#endif
AVX static void scan_avx2(const uint8_t *src,size_t n,struct scan *s)
{
 __m256i zero=_mm256_setzero_si256();
 __m256i p4=_mm256_set1_epi32((int)load32(src));
 __m256i p8=_mm256_set1_epi64x((long long)load64(src));
 __m256i p16=_mm256_broadcastsi128_si256(_mm_loadu_si128((const __m128i *)src));
 __m256i p32=_mm256_loadu_si256((const __m256i *)src);
 __m256i d4=zero,d8=zero,d16=zero,d32=zero;s->nonzero=0;
#if defined(GZRAM_EMBED_PREFIX)
 __m256i anchor_value=_mm256_set1_epi8((char)(s->key>>(s->anchor*8)));
#endif
 for(size_t group=0;group<n/32;group++) {
  __m256i v=_mm256_loadu_si256((const __m256i *)(src+group*32));
  unsigned mask=(unsigned)_mm256_movemask_ps(_mm256_castsi256_ps(_mm256_cmpeq_epi32(v,zero)))^255U;
  s->masks[group]=(uint8_t)mask;s->nonzero+=gz_count[mask];
#if defined(GZRAM_EMBED_PREFIX)
  if(s->key&&!s->hint&&s->offset+group*32<=s->limit+s->anchor){
   unsigned matches=(unsigned)_mm256_movemask_epi8(_mm256_cmpeq_epi8(v,anchor_value));
   while(matches){unsigned at=(unsigned)(s->offset+group*32)+(unsigned)__builtin_ctz(matches);matches&=matches-1;
    if(at>s->anchor){unsigned candidate=at-s->anchor;if(candidate<=s->limit&&load64(s->page+candidate)==s->key){s->hint=1;break;}}
   }
  }
#endif
  d4=_mm256_or_si256(d4,_mm256_xor_si256(v,p4));
  d8=_mm256_or_si256(d8,_mm256_xor_si256(v,p8));
  d16=_mm256_or_si256(d16,_mm256_xor_si256(v,p16));
  d32=_mm256_or_si256(d32,_mm256_xor_si256(v,p32));
 }
 s->repeated=(unsigned)_mm256_testz_si256(d4,d4)|((unsigned)_mm256_testz_si256(d8,d8)<<1)|((unsigned)_mm256_testz_si256(d16,d16)<<2)|((unsigned)_mm256_testz_si256(d32,d32)<<3);
}
static void pack_scalar(const uint8_t *src,uint8_t *dst,unsigned mask)
{
#if defined(GZRAM_CTZ_PACK)
 /* A full mask is already contiguous. Otherwise visit only present words;
  * the caller has validated the exact popcount-derived output capacity. */
 if(mask==255){memcpy(dst,src,32);return;}
 while(mask){unsigned lane=(unsigned)__builtin_ctz(mask);mask&=mask-1;memcpy(dst,src+lane*4,4);dst+=4;}
#else
 for(unsigned lane=0;lane<8;lane++)if(mask&(1U<<lane)){memcpy(dst,src+lane*4,4);dst+=4;}
#endif
}
static void unpack_scalar(const uint8_t *src,uint8_t *dst,unsigned mask)
{
#if defined(GZRAM_CTZ_UNPACK)
 /* Integer-only alternative: clear the group, then visit present words.
  * Avoid eight data-dependent branches for sparse groups. Dense masks pay
  * extra stores/bit scans; measure that cost instead of guessing a cutoff. */
#if defined(GZRAM_CTZ_UNPACK_FULL)
 /* A full mask overwrites every byte. Measure this extra branch on sparse
  * masks as well as its benefit on clustered full/zero groups. */
 if(mask==255){memcpy(dst,src,32);return;}
#endif
 memset(dst,0,32);
 while(mask){
  unsigned lane=(unsigned)__builtin_ctz(mask);mask&=mask-1;
  memcpy(dst+lane*4,src,4);src+=4;
 }
#else
 for(unsigned lane=0;lane<8;lane++) {
  if(mask&(1U<<lane)){memcpy(dst+lane*4,src,4);src+=4;}
  else memset(dst+lane*4,0,4);
 }
#endif
}
#if !defined(GZRAM_MIXED_ENCODE) || defined(GZRAM_EMBED_PREFIX) || defined(GZRAM_SELECT_PACK)
AVX static void pack_avx2(const uint8_t *src,uint8_t *dst,unsigned mask)
{
 if(!mask)return;
 __m256i v=_mm256_loadu_si256((const __m256i *)src);
 if(mask==255){_mm256_storeu_si256((__m256i *)dst,v);return;}
 __m256i indices=_mm256_loadu_si256((const __m256i *)gz_encode_indices[mask]);
 uint32_t tmp[8];_mm256_storeu_si256((__m256i *)tmp,_mm256_permutevar8x32_epi32(v,indices));
 memcpy(dst,tmp,gz_count[mask]*4U);
}
#endif
#if defined(GZRAM_BLOCK_PACK_DIRECT)
/* One direct helper call per block. AVX2 work stays inside its target-specific
 * helper so the scalar entry never requires vector instructions. Keep these
 * loops separate from the preserved indirect-call block selection controls. */
static size_t pack_block_scalar(const uint8_t *src,uint8_t *dst,const uint8_t *masks,size_t groups)
{
 size_t bytes=0;
 for(size_t group=0;group<groups;group++){
  unsigned mask=masks[group];pack_scalar(src+group*32,dst+bytes,mask);bytes+=gz_count[mask]*4U;
 }
 return bytes;
}
AVX static size_t pack_block_avx2(const uint8_t *src,uint8_t *dst,const uint8_t *masks,size_t groups)
{
 size_t bytes=0;
 for(size_t group=0;group<groups;group++){
  unsigned mask=masks[group];pack_avx2(src+group*32,dst+bytes,mask);bytes+=gz_count[mask]*4U;
 }
 return bytes;
}
#endif
#if defined(GZRAM_SELECT_PACK)
_Static_assert(GZRAM_SELECT_PACK>=0&&GZRAM_SELECT_PACK<=8,"Invalid packing experiment cutoff");
static void pack_selected(const uint8_t *src,uint8_t *dst,unsigned mask)
{
 /* The entry point has already established AVX2 availability. Compare
  * multiple cutoffs in whole-codec runs; this is not an accepted crossover. */
 if(gz_count[mask]<=GZRAM_SELECT_PACK)pack_scalar(src,dst,mask);
 else pack_avx2(src,dst,mask);
}
#endif
AVX static void unpack_avx2(const uint8_t *src,uint8_t *dst,unsigned mask)
{
 uint32_t tmp[8]={0};memcpy(tmp,src,gz_count[mask]*4U);
 __m256i v=_mm256_loadu_si256((const __m256i *)tmp);
 __m256i indices=_mm256_loadu_si256((const __m256i *)gz_decode_indices[mask]);
 __m256i bits=_mm256_setr_epi32(1,2,4,8,16,32,64,128);
 __m256i absent=_mm256_cmpeq_epi32(_mm256_and_si256(bits,_mm256_set1_epi32((int)mask)),_mm256_setzero_si256());
 _mm256_storeu_si256((__m256i *)dst,_mm256_andnot_si256(absent,_mm256_permutevar8x32_epi32(v,indices)));
}
#if defined(GZRAM_BLOCK_UNPACK)
/* One AVX2 call per validated MASK32 block rather than per 32-byte group.
 * The caller has checked the total payload and output lengths first. */
AVX static void unpack_block_avx2(const uint8_t *src,uint8_t *dst,const uint8_t *masks,size_t groups)
{
 for(size_t group=0;group<groups;group++) {
  unsigned mask=masks[group];
  unpack_avx2(src,dst+group*32,mask);src+=gz_count[mask]*4U;
 }
}
#endif
static void repeat_scalar(uint8_t *dst,const uint8_t *pattern,size_t n,unsigned period)
{
#if defined(GZRAM_WORD_REPEAT)
 /* The decoder has checked period in {4,8,16,32}, n >= period and n%period=0.
  * Expand the bounded pattern once, then use integer stores. Legal short
  * decoder-only blocks (including four-byte tails) must remain bounded. */
 uint64_t words[4];
 if(period==4){uint64_t word=load32(pattern);word|=word<<32;for(unsigned i=0;i<4;i++)words[i]=word;}
 else if(period==8){uint64_t word=load64(pattern);for(unsigned i=0;i<4;i++)words[i]=word;}
 else if(period==16){words[0]=words[2]=load64(pattern);words[1]=words[3]=load64(pattern+8);}
 else for(unsigned i=0;i<4;i++)words[i]=load64(pattern+i*8);
 size_t at=0;
 for(;n-at>=32;at+=32)for(unsigned i=0;i<4;i++)memcpy(dst+at+i*8,&words[i],8);
 for(;n-at>=8;at+=8)memcpy(dst+at,&words[(at&31)/8],8);
 if(at<n)memcpy(dst+at,pattern,4);
#else
 for(size_t at=0;at<n;at+=period)memcpy(dst+at,pattern,period);
#endif
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
#if defined(GZRAM_VARIABLE_PERIOD)
/* Bounded independent block dictionary: prove a complete repeated pattern.
 * Prefix filtering avoids long comparisons for most rejected distances. */
static unsigned variable_period(const uint8_t *src,size_t n,size_t best)
{
 if(n<16||best<=3)return 0;
 unsigned limit=n-8<255?(unsigned)(n-8):255;
 for(unsigned period=1;period<=limit&&period+2<best;period++)
  if(load64(src)==load64(src+period)&&!memcmp(src,src+period,n-period))return period;
 return 0;
}
#if defined(GZRAM_PERIOD_FILTER)
AVX static unsigned variable_period_avx2(const uint8_t *src,size_t n,size_t best)
{
 if(n<16||best<=3)return 0;
 unsigned limit=n-8<255?(unsigned)(n-8):255;
 if(best-3<limit)limit=(unsigned)(best-3);
 __m256i first=_mm256_set1_epi8((char)src[0]);unsigned at=1;
 for(;at<=limit&&limit-at+1>=32;at+=32){
  unsigned mask=(unsigned)_mm256_movemask_epi8(_mm256_cmpeq_epi8(first,_mm256_loadu_si256((const __m256i *)(src+at))));
  while(mask){unsigned period=at+(unsigned)__builtin_ctz(mask);mask&=mask-1;
   if(load64(src)==load64(src+period)&&!memcmp(src,src+period,n-period))return period;
  }
 }
 for(;at<=limit;at++)if(src[at]==src[0]&&load64(src)==load64(src+at)&&!memcmp(src,src+at,n-at))return at;
 return 0;
}
#endif
int gzram_variable_period_available(void){return 1;}
#endif
#if defined(GZRAM_EMBED_PREFIX)
#define PREFIX_ARGUMENT ,unsigned *hint
#define PREFIX_NONE ,NULL
#else
#define PREFIX_ARGUMENT
#define PREFIX_NONE
#endif
static int encode(const void *input,size_t n,void *output,size_t cap,unsigned log,scan_fn scan,pack_fn pack PREFIX_ARGUMENT)
{
 if(n>MAX_PAGE||log<5||log>12||!output||(!input&&n)||cap<HEADER)return 0;
 const uint8_t *src=input;uint8_t *dst=output;size_t block=(size_t)1<<log,chunks=(n+block-1)/block,pos=HEADER+chunks;
#if defined(GZRAM_EMBED_PREFIX)
 uint64_t prefix_key=0;unsigned prefix_anchor=0,prefix_limit=0,prefix_seen=0;
 if(hint){*hint=0;if(n>=16){prefix_key=load64(src);if(prefix_key){prefix_anchor=(unsigned)__builtin_ctzll(prefix_key)/8;prefix_limit=n-8<1024?(unsigned)(n-8):1024;}}}
#endif
 if(pos>cap)return raw_page(src,n,dst,cap,log);
 header(dst,n,log,0);
 for(size_t chunk=0,offset=0;chunk<chunks;chunk++,offset+=block) {
  size_t len=n-offset;if(len>block)len=block;
  struct scan s;unsigned mode=RAW,period=0;size_t needed=len;
#if defined(GZRAM_EMBED_PREFIX)
  s.page=src;s.key=prefix_key;s.offset=offset;s.anchor=prefix_anchor;s.limit=prefix_limit;s.hint=prefix_seen;
#endif
  if(len%32==0) {
   scan(src+offset,len,&s);
   if(!s.nonzero){mode=ZERO;needed=0;}
   else {
    const unsigned periods[]={4,8,16,32},modes[]={REPEAT4,REPEAT8,REPEAT16,REPEAT32};
    for(unsigned k=0;k<4;k++)if((s.repeated&(1U<<k))&&periods[k]<len){mode=modes[k];period=periods[k];needed=period;break;}
    if(mode==RAW&&len/32+s.nonzero*4U<len){mode=MASK32;needed=len/32+s.nonzero*4U;}
   }
  }
#if defined(GZRAM_EMBED_PREFIX)
  /* A final partial block is not visited by the vector scan. */
  if(len%32&&prefix_key&&!s.hint){
   unsigned begin=offset?(unsigned)offset:1,end=(unsigned)(offset+len-1);if(end>prefix_limit)end=prefix_limit;
   uint8_t anchor_byte=(uint8_t)(prefix_key>>(prefix_anchor*8));
   for(unsigned at=begin;at<=end;at++)if(src[at+prefix_anchor]==anchor_byte&&load64(src+at)==prefix_key){s.hint=1;break;}
  }
  prefix_seen=s.hint;if(hint)*hint=prefix_seen;
#endif
#if defined(GZRAM_VARIABLE_PERIOD)
#if defined(GZRAM_PERIOD_FILTER)
  unsigned arbitrary=mode==RAW?(scan==scan_avx2?variable_period_avx2(src+offset,len,needed):variable_period(src+offset,len,needed)):0;
#else
  unsigned arbitrary=variable_period(src+offset,len,needed);
#endif
  if(arbitrary){mode=7;period=arbitrary;needed=period+2;}
#endif
  if(needed>cap-pos)return raw_page(src,n,dst,cap,log);
  dst[HEADER+chunk]=(uint8_t)mode;
  if(mode==RAW){memcpy(dst+pos,src+offset,len);pos+=len;}
#if defined(GZRAM_VARIABLE_PERIOD)
  else if(mode==7){dst[3]='2';dst[pos++]=(uint8_t)period;dst[pos++]=(uint8_t)(period>>8);memcpy(dst+pos,src+offset,period);pos+=period;}
#endif
  else if(mode==MASK32) {
   size_t groups=len/32;memcpy(dst+pos,s.masks,groups);pos+=groups;
#if defined(GZRAM_BLOCK_PACK_LIMIT)
   /* Reuse the completed scan's count. Choose once per independent block,
    * leaving the inner mask loop free of a scalar/vector selection branch. */
   _Static_assert(GZRAM_BLOCK_PACK_LIMIT>=0&&GZRAM_BLOCK_PACK_LIMIT<=8,"Invalid block packing cutoff");
#if defined(GZRAM_BLOCK_PACK_DIRECT)
   if(pack==pack_scalar||s.nonzero<=groups*GZRAM_BLOCK_PACK_LIMIT)
    pos+=pack_block_scalar(src+offset,dst+pos,s.masks,groups);
   else pos+=pack_block_avx2(src+offset,dst+pos,s.masks,groups);
#else
   pack_fn selected=(pack==pack_avx2&&s.nonzero<=groups*GZRAM_BLOCK_PACK_LIMIT)?pack_scalar:pack;
   for(size_t group=0;group<groups;group++){unsigned mask=s.masks[group];selected(src+offset+group*32,dst+pos,mask);pos+=gz_count[mask]*4U;}
#endif
#else
   for(size_t group=0;group<groups;group++){unsigned mask=s.masks[group];pack(src+offset+group*32,dst+pos,mask);pos+=gz_count[mask]*4U;}
#endif
  } else if(mode!=ZERO){memcpy(dst+pos,src+offset,period);pos+=period;}
 }
 if(pos>=n+HEADER)return raw_page(src,n,dst,cap,log);
 return (int)pos;
}
static int decode(const void *input,size_t size,void *output,size_t cap,pack_fn unpack,repeat_fn repeat)
{
 if(!input||size<HEADER||size>MAX_PAGE+HEADER)return -1;
 const uint8_t *src=input;uint8_t *dst=output;
#if defined(GZRAM_VARIABLE_PERIOD)
 if((memcmp(src,"GZR1",4)&&memcmp(src,"GZR2",4))||src[6]<5||src[6]>12||src[7]>1)return -1;
#else
 if(memcmp(src,"GZR1",4)||src[6]<5||src[6]>12||src[7]>1)return -1;
#endif
 size_t n=(size_t)src[4]+((size_t)src[5]<<8);if(n>MAX_PAGE||n>cap||(!output&&n))return -1;
 if(src[7]){if(size!=n+HEADER)return -1;if(n)memcpy(dst,src+HEADER,n);return (int)n;}
 size_t block=(size_t)1<<src[6],chunks=(n+block-1)/block,pos=HEADER+chunks;
 if(pos>size)return -1;
 for(size_t chunk=0,offset=0;chunk<chunks;chunk++,offset+=block) {
  size_t len=n-offset;if(len>block)len=block;
  unsigned mode=src[HEADER+chunk],period=0;
  if(mode==RAW){if(len>size-pos)return -1;memcpy(dst+offset,src+pos,len);pos+=len;}
  else if(mode==ZERO)memset(dst+offset,0,len);
#if defined(GZRAM_VARIABLE_PERIOD)
  else if(mode==7){
   if(src[3]!='2'||size-pos<2)return -1;
   unsigned period=(unsigned)src[pos]|((unsigned)src[pos+1]<<8);pos+=2;
   if(!period||period>255||period>len||period>size-pos)return -1;
   for(size_t at=0;at<len;){size_t count=len-at<period?len-at:period;memcpy(dst+offset+at,src+pos,count);at+=count;}
   pos+=period;
  }
#endif
  else if(mode==MASK32) {
   if(len%32)return -1;
   size_t groups=len/32;if(groups>size-pos)return -1;const uint8_t *masks=src+pos;pos+=groups;size_t needed=0;
   for(size_t group=0;group<groups;group++)needed+=gz_count[masks[group]]*4U;
   if(needed>size-pos)return -1;
#if defined(GZRAM_BLOCK_UNPACK)
   if(unpack==unpack_avx2){unpack_block_avx2(src+pos,dst+offset,masks,groups);pos+=needed;}
   else
#endif
   for(size_t group=0;group<groups;group++){unsigned mask=masks[group];unpack(src+pos,dst+offset+group*32,mask);pos+=gz_count[mask]*4U;}
  } else {
   if(mode==REPEAT4)period=4;else if(mode==REPEAT8)period=8;else if(mode==REPEAT16)period=16;else if(mode==REPEAT32)period=32;else return -1;
   if(len%period||period>len||period>size-pos)return -1;
   repeat(dst+offset,src+pos,len,period);pos+=period;
  }
 }
 return pos==size?(int)n:-1;
}
int gzram_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log){return encode(s,n,d,cap,log,scan_scalar,pack_scalar PREFIX_NONE);}
int gzram_encode_avx2(const void *s,size_t n,void *d,size_t cap,unsigned log){
#if defined(GZRAM_SELECT_PACK)
 return gzram_avx2_available()?encode(s,n,d,cap,log,scan_avx2,pack_selected PREFIX_NONE):gzram_encode_scalar(s,n,d,cap,log);
#elif defined(GZRAM_MIXED_ENCODE)
 return gzram_avx2_available()?encode(s,n,d,cap,log,scan_avx2,pack_scalar PREFIX_NONE):gzram_encode_scalar(s,n,d,cap,log);
#else
 return gzram_avx2_available()?encode(s,n,d,cap,log,scan_avx2,pack_avx2 PREFIX_NONE):gzram_encode_scalar(s,n,d,cap,log);
#endif
}
int gzram_decode_scalar(const void *s,size_t n,void *d,size_t cap){return decode(s,n,d,cap,unpack_scalar,repeat_scalar);}
int gzram_decode_avx2(const void *s,size_t n,void *d,size_t cap){return gzram_avx2_available()?decode(s,n,d,cap,unpack_avx2,repeat_avx2):gzram_decode_scalar(s,n,d,cap);}

#if defined(GZRAM_EMBED_PREFIX)
int gzram_encode_hint_avx2(const void *s,size_t n,void *d,size_t cap,unsigned log,unsigned *hint)
{
 if(!gzram_avx2_available()){if(hint)*hint=0;return 0;}
 return encode(s,n,d,cap,log,scan_avx2,pack_avx2,hint);
}
#endif

#if defined(GZRAM_MIXED_DECODE)
int gzram_decode_mixed(const void *s,size_t n,void *d,size_t cap)
{
 return gzram_avx2_available()?decode(s,n,d,cap,unpack_scalar,repeat_avx2):decode(s,n,d,cap,unpack_scalar,repeat_scalar);
}
#endif
