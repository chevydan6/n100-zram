/* SPDX-License-Identifier: GPL-2.0-only */
#if defined(GZRAM_HYBRID_CTZFULL_DECODE) || defined(GZRAM_HYBRID_CTZ_DECODE) || defined(GZRAM_HYBRID_FUSED_HINT) || defined(GZRAM_HYBRID_GUARD) || defined(GZRAM_HYBRID_MERGE_REPEAT) || defined(GZRAM_HYBRID_MERGE_REPEAT_FAST) || defined(GZRAM_HYBRID_MIXED_DECODE) || defined(GZRAM_HYBRID_OUTLINE_WORD) || defined(GZRAM_HYBRID_RECURRENCE) || defined(GZRAM_HYBRID_REPEAT_DECODE) || defined(GZRAM_HYBRID_SAMPLE) || defined(GZRAM_HYBRID_SPLIT_TAIL) || defined(GZRAM_HYBRID_WORD_SCALAR)
#error Unexpected scalar hybrid policy override
#endif
#define GZRAM_HYBRID_GUARD 8
#define GZRAM_HYBRID_WORD_SCALAR 1
/* SPDX-License-Identifier: GPL-2.0-only */
/* Experimental versioned GZRAM/LZ4 container. Original codecs stay separate. */
#include "ghy_scalar.h"
#include "private-lz4.h"
#ifdef __KERNEL__
#include <linux/types.h>
#include <linux/string.h>
#define UINT64_C(value) value##ULL
#else
#include <stdint.h>
#include <string.h>
#endif
#define PAGE 4096
#define HEADER 8
#define MAX_FRAME (LZ4_COMPRESSBOUND(PAGE)+HEADER)
int n100_encoder_encode_scalar(const void *,size_t,void *,size_t,unsigned);
int gzram_base_encode_avx2(const void *,size_t,void *,size_t,unsigned);
int n100_decoder_decode_scalar(const void *,size_t,void *,size_t);
int gzram_base_decode_avx2(const void *,size_t,void *,size_t);
#if defined(GZRAM_HYBRID_FUSED_HINT)
int gzram_fused_encode_hint_avx2(const void *,size_t,void *,size_t,unsigned,unsigned *);
#endif
#if defined(GZRAM_HYBRID_REPEAT_DECODE)
int gzram_repeat_decode_scalar(const void *,size_t,void *,size_t);
int gzram_repeat_decode(const void *,size_t,void *,size_t);
#elif defined(GZRAM_HYBRID_CTZFULL_DECODE)
int gzram_ctzfull_decode_scalar(const void *,size_t,void *,size_t);
int gzram_ctzfull_decode(const void *,size_t,void *,size_t);
#elif defined(GZRAM_HYBRID_CTZ_DECODE)
int gzram_ctz_decode_scalar(const void *,size_t,void *,size_t);
int gzram_ctz_decode(const void *,size_t,void *,size_t);
#elif defined(GZRAM_HYBRID_MIXED_DECODE)
int gzram_mixed_decode(const void *,size_t,void *,size_t);
#endif
typedef int (*encode_fn)(const void *,size_t,void *,size_t,unsigned);
typedef int (*decode_fn)(const void *,size_t,void *,size_t);
#if defined(GZRAM_HYBRID_MERGE_REPEAT)
#if defined(GZRAM_HYBRID_MERGE_REPEAT_FAST)
static uint64_t merge_load64(const uint8_t *p){uint64_t value;memcpy(&value,p,8);return value;}
static int merge_pattern_equal(const uint8_t *a,const uint8_t *b,unsigned period)
{
 if(period==4){uint32_t x,y;memcpy(&x,a,4);memcpy(&y,b,4);return x==y;}
 uint64_t difference=merge_load64(a)^merge_load64(b);
 if(period>=16)difference|=merge_load64(a+8)^merge_load64(b+8);
 if(period==32)difference|=(merge_load64(a+16)^merge_load64(b+16))|(merge_load64(a+24)^merge_load64(b+24));
 return difference==0;
}
#endif
/* Consume only a successful frame produced by our preserved GZR1 encoder.
 * Reuse its per-block repetition proofs; do not rescan the full input page.
 * Keeping this outside the base object preserves that control's codegen. */
__attribute__((noinline)) static int merge_repeats(const uint8_t *src,size_t n,uint8_t *frame,int packed,unsigned log)
{
#if defined(GZRAM_HYBRID_MERGE_REPEAT_FAST)
 /* Reject ordinary frames before setting up the repeat walk. Compare only
  * the bounded pattern bytes, with integer loads instead of dynamic memcmp. */
 if(frame[7])return packed;
 unsigned first=frame[HEADER];
 unsigned period=first==2?4:first==3?8:first==5?16:first==6?32:0;
 if(!period)return packed;
 size_t block=(size_t)1<<log;
 if(n<=block)return packed;
 for(size_t offset=block,chunk=1;offset<n;offset+=block,chunk++)
  if(frame[HEADER+chunk]!=first||!merge_pattern_equal(src+offset,src,period))return packed;
 frame[6]=12;
 if(period==4)memcpy(frame+HEADER+1,src,4);
 else for(unsigned at=0;at<period;at+=8)memcpy(frame+HEADER+1+at,src+at,8);
 return HEADER+1+(int)period;
#else
 size_t block=(size_t)1<<log,chunks=(n+block-1)/block;
 if(chunks<2||frame[7])return packed;
 unsigned first=frame[HEADER];
 unsigned period=first==2?4:first==3?8:first==5?16:first==6?32:0;
 if(!period)return packed;
 for(size_t chunk=1;chunk<chunks;chunk++)
  if(frame[HEADER+chunk]!=first||memcmp(src+chunk*block,src,period))return packed;
 /* Every block was independently proved to repeat the same bounded pattern.
  * The replacement is smaller than the successful frame, so it fits too. */
 frame[6]=12;memcpy(frame+HEADER+1,src,period);
 return HEADER+1+(int)period;
#endif
}
#endif
static void header(uint8_t *dst,size_t n,unsigned mode)
{
 memcpy(dst,"GHY1",4);dst[4]=(uint8_t)n;dst[5]=(uint8_t)(n>>8);dst[6]=(uint8_t)mode;dst[7]=0;
}
/* Caller-owned private LZ4 state: never placed on the kernel stack. */
__attribute__((noinline)) static int lz4_encode(const void *src,void *dst,int n,int cap,void *work)
{
 return n100_private_lz4_compress_default(src,dst,n,cap,work);
}
#if defined(GZRAM_HYBRID_GUARD)
static uint64_t hybrid_load64(const uint8_t *p){uint64_t v;memcpy(&v,p,8);return v;}
#if defined(GZRAM_HYBRID_OUTLINE_WORD)
/* Splitting the vector tail leaves this with one caller, allowing GCC to
 * inline/specialize it. Keep a separately compiled scalar scanner as a causal
 * experiment; its call cost is included in whole-codec measurements. */
__attribute__((noipa))
#endif
static int prefix_scalar(const uint8_t *src,unsigned at,unsigned limit,uint64_t key,unsigned anchor)
{
 uint8_t target=(uint8_t)(key>>(anchor*8));
#if GZRAM_HYBRID_GUARD == 8 || defined(GZRAM_HYBRID_WORD_SCALAR)
 const uint64_t ones=UINT64_C(0x0101010101010101),high=UINT64_C(0x8080808080808080),repeated=ones*target;
 for(;at<=limit&&limit-at+1>=8;at+=8){
  uint64_t difference=hybrid_load64(src+at+anchor)^repeated;
  uint64_t matches=(difference-ones)&~difference&high;
  while(matches){unsigned candidate=at+(unsigned)__builtin_ctzll(matches)/8;matches&=matches-1;
   /* Borrow propagation may add candidate bits; the complete key decides. */
   if(hybrid_load64(src+candidate)==key)return 1;
  }
 }
#endif
 for(;at<=limit;at++)if(src[at+anchor]==target&&hybrid_load64(src+at)==key)return 1;
 return 0;
}
#if defined(GZRAM_HYBRID_SPLIT_TAIL)
/* Keep the vector classifier's short tail independent of the integer scanner.
 * At a complete vector boundary this exits without setting up a word scan. */
static int prefix_vector_tail(const uint8_t *src,unsigned at,unsigned limit,uint64_t key,unsigned anchor)
{
 uint8_t target=(uint8_t)(key>>(anchor*8));
 for(;at<=limit;at++)if(src[at+anchor]==target&&hybrid_load64(src+at)==key)return 1;
 return 0;
}
#else
#define prefix_vector_tail prefix_scalar
#endif
#if GZRAM_HYBRID_GUARD == 16
__attribute__((target("sse2")))
static int prefix_vector(const uint8_t *src,unsigned limit,uint64_t key,unsigned anchor)
{
 __m128i target=_mm_set1_epi8((char)(key>>(anchor*8)));unsigned at=1;
 for(;at<=limit&&limit-at+1>=16;at+=16){
  unsigned mask=(unsigned)_mm_movemask_epi8(_mm_cmpeq_epi8(target,_mm_loadu_si128((const __m128i *)(src+at+anchor))));
  while(mask){unsigned candidate=at+(unsigned)__builtin_ctz(mask);mask&=mask-1;if(hybrid_load64(src+candidate)==key)return 1;}
 }
 return prefix_vector_tail(src,at,limit,key,anchor);
}
#elif GZRAM_HYBRID_GUARD == 32
__attribute__((target("avx2")))
static int prefix_vector(const uint8_t *src,unsigned limit,uint64_t key,unsigned anchor)
{
 __m256i target=_mm256_set1_epi8((char)(key>>(anchor*8)));unsigned at=1;
 for(;at<=limit&&limit-at+1>=32;at+=32){
  unsigned mask=(unsigned)_mm256_movemask_epi8(_mm256_cmpeq_epi8(target,_mm256_loadu_si256((const __m256i *)(src+at+anchor))));
  while(mask){unsigned candidate=at+(unsigned)__builtin_ctz(mask);mask&=mask-1;if(hybrid_load64(src+candidate)==key)return 1;}
 }
 return prefix_vector_tail(src,at,limit,key,anchor);
}
#endif
static int prefix_recurrence(const uint8_t *src,size_t n,encode_fn gz)
{
 uint64_t key=hybrid_load64(src);if(!key)return 0;
 unsigned anchor=(unsigned)__builtin_ctzll(key)/8,limit=n-8<1024?(unsigned)(n-8):1024;
#if GZRAM_HYBRID_GUARD != 8
 if(gz==gzram_base_encode_avx2&&gzram_avx2_available())return prefix_vector(src,limit,key,anchor);
#else
 (void)gz;
#endif
 return prefix_scalar(src,1,limit,key,anchor);
}
#endif
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
static int encode(const void *input,size_t n,void *output,size_t cap,unsigned log,encode_fn gz,void *work)
{
 if(n>PAGE||log<5||log>12||!output||(!input&&n)||cap<HEADER)return 0;
 const uint8_t *src=input;uint8_t *dst=output;
 if(!n){header(dst,0,0);return HEADER;}
 if(select_gzram(src,n)){
#if defined(GZRAM_HYBRID_FUSED_HINT)
  unsigned recurrence=0;int fused=gz==gzram_base_encode_avx2&&gzram_avx2_available();
  int packed=fused?gzram_fused_encode_hint_avx2(src,n,dst+HEADER,cap-HEADER,log,&recurrence):gz(src,n,dst+HEADER,cap-HEADER,log);
#else
  int packed=gz(src,n,dst+HEADER,cap-HEADER,log);
#endif
#if defined(GZRAM_HYBRID_MERGE_REPEAT)
  if(packed>0&&log<12)packed=merge_repeats(src,n,dst+HEADER,packed,log);
#endif
  /* Threshold includes nested GZRAM framing. Exact decoding is still mandatory. */
  int accept=packed>0&&(size_t)packed<=n*3/4;
#if defined(GZRAM_HYBRID_GUARD)
  /* Protect the best sparse/zero/repeat path; inspect only middling ratios. */
#if defined(GZRAM_HYBRID_FUSED_HINT)
  if(accept&&n>=16&&(size_t)packed>n/4&&(fused?(recurrence!=0):prefix_recurrence(src,n,gz)))accept=0;
#else
  if(accept&&n>=16&&(size_t)packed>n/4&&prefix_recurrence(src,n,gz))accept=0;
#endif
#endif
  if(accept){header(dst,n,1);return packed+HEADER;}
 }
 size_t room=cap-HEADER;if(room>LZ4_COMPRESSBOUND(PAGE))room=LZ4_COMPRESSBOUND(PAGE);
 int packed=lz4_encode(src,dst+HEADER,(int)n,(int)room,work);
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
 int got=mode==1?gz(src+HEADER,size-HEADER,dst,n):n100_private_lz4_decompress_safe((const char *)src+HEADER,(char *)dst,(int)(size-HEADER),(int)n);
 return got==(int)n?got:-1;
}
size_t n100_ghy_workspace_size(void) { return sizeof(n100_private_lz4_stream_t); }
size_t n100_ghy_workspace_alignment(void) { return _Alignof(n100_private_lz4_stream_t); }
int n100_ghy_encode(const void *src,size_t n,void *dst,size_t cap,unsigned log,
                    void *work,size_t work_bytes)
{
 if(!work||work_bytes<sizeof(n100_private_lz4_stream_t)||
    (uintptr_t)work%_Alignof(n100_private_lz4_stream_t))return 0;
 return encode(src,n,dst,cap,log,n100_encoder_encode_scalar,work);
}
int n100_ghy_decode(const void *src,size_t n,void *dst,size_t cap)
{ return decode(src,n,dst,cap,n100_decoder_decode_scalar); }
