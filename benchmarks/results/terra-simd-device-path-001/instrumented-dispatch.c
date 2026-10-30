/* SPDX-License-Identifier: GPL-2.0-only */
#include "simd.h"
#include "scalar/private-lz4.h"
#ifdef __KERNEL__
#include <linux/types.h>
#include <linux/printk.h>
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
int n100_simd_encode(const void *src,size_t n,void *dst,size_t cap,unsigned log,
                     void *work,size_t work_bytes)
{
 if(!work||work_bytes<n100_ghy_workspace_size()||
    (uintptr_t)work%n100_ghy_workspace_alignment())return 0;
 if(n>4096||log<5||log>12||!dst||(!src&&n)||cap<8)return 0;
 if(!n||!usable()){pr_info_once("N100_DEVICE_SCALAR_ENCODE\n");return n100_ghy_encode(src,n,dst,cap,log,work,work_bytes);}
 begin_vector();
 int got=n100_vector_trial(src,n,dst,cap,log);
 end_vector();
 pr_info_once("N100_DEVICE_VECTOR_ENCODE\n");
 return got?got:n100_lz4_fallback(src,n,dst,cap,work);
}
int n100_simd_decode(const void *input,size_t size,void *dst,size_t cap)
{
 if(!input||size<8||size>LZ4_COMPRESSBOUND(4096)+8)return -1;
 const uint8_t *src=input;
 if(memcmp(src,"GHY1",4)||src[6]>2||src[7])return -1;
 size_t n=(size_t)src[4]+((size_t)src[5]<<8);
 if(n>4096||n>cap||(!dst&&n))return -1;
 if(src[6]!=1||!usable()){if(src[6]==1)pr_info_once("N100_DEVICE_SCALAR_DECODE\n");return n100_ghy_decode(src,size,dst,cap);}
 if(!n)return -1;
 begin_vector();
 int got=n100_vector_decoder_decode_mixed(src+8,size-8,dst,n);
 end_vector();
 pr_info_once("N100_DEVICE_VECTOR_DECODE\n");
 return got==(int)n?got:-1;
}
