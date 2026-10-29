#include <linux/kernel.h>
#include <linux/atomic.h>
/* SPDX-License-Identifier: GPL-2.0-only */
#include "simd.h"
#include "scalar/private-lz4.h"
#ifdef __KERNEL__
#include <linux/types.h>
#include <linux/string.h>
#define UINT64_C(value) value##ULL
#else
#include <stdint.h>
#include <string.h>
#endif
#ifdef __KERNEL__
#include <asm/cpufeature.h>
#include <asm/fpu/api.h>
#include <asm/fpu/types.h>
int n100_simd_available(void)
{ return boot_cpu_has(X86_FEATURE_AVX2) && cpu_has_xfeatures(XFEATURE_MASK_SSE|XFEATURE_MASK_YMM,0); }
static int usable(void) { return n100_simd_available() && irq_fpu_usable(); }
#define begin_vector() kernel_fpu_begin()
#define end_vector() kernel_fpu_end()
#else
int n100_simd_available(void) {
#ifdef N100_TEST_FORCE_SCALAR
 return 0;
#else
 return !!__builtin_cpu_supports("avx2");
#endif
}
static int usable(void) { return n100_simd_available(); }
#define begin_vector() ((void)0)
#define end_vector() ((void)0)
#endif
int n100_vector_trial(const void *,size_t,void *,size_t,unsigned);
int n100_vector_decoder_decode_mixed(const void *,size_t,void *,size_t);
int n100_lz4_fallback(const void *,size_t,void *,size_t,void *);
static atomic64_t vector_encodes = ATOMIC64_INIT(0), vector_decodes = ATOMIC64_INIT(0);
int n100_simd_check_paths(void)
{
 int available=n100_simd_available();
 long long enc=atomic64_read(&vector_encodes),dec=atomic64_read(&vector_decodes);
 pr_info("GZRAM_SIMD_PATHS available=%d encode=%lld decode=%lld\n",available,enc,dec);
 return available?((enc>0&&dec>0)?0:-EINVAL):((enc==0&&dec==0)?0:-EINVAL);
}
int n100_simd_encode(const void *src,size_t n,void *dst,size_t cap,unsigned log,
                     void *work,size_t work_bytes)
{
 if(!work||work_bytes<n100_ghy_workspace_size()||
    (uintptr_t)work%n100_ghy_workspace_alignment())return 0;
 if(n>4096||log<5||log>12||!dst||(!src&&n)||cap<8)return 0;
 if(!n||!usable())return n100_ghy_encode(src,n,dst,cap,log,work,work_bytes);
 begin_vector();
 int got=n100_vector_trial(src,n,dst,cap,log);
 end_vector();
 atomic64_inc(&vector_encodes);
 return got?got:n100_lz4_fallback(src,n,dst,cap,work);
}
int n100_simd_decode(const void *input,size_t size,void *dst,size_t cap)
{
 if(!input||size<8||size>LZ4_COMPRESSBOUND(4096)+8)return -1;
 const uint8_t *src=input;
 if(memcmp(src,"GHY1",4)||src[6]>2||src[7])return -1;
 size_t n=(size_t)src[4]+((size_t)src[5]<<8);
 if(n>4096||n>cap||(!dst&&n))return -1;
 if(src[6]!=1||!usable())return n100_ghy_decode(src,size,dst,cap);
 if(!n)return -1;
 begin_vector();
 int got=n100_vector_decoder_decode_mixed(src+8,size-8,dst,n);
 end_vector();
 atomic64_inc(&vector_decodes);
 return got==(int)n?got:-1;
}
