// SPDX-License-Identifier: GPL-2.0-only
#include <linux/lz4.h>
#include <linux/export.h>
#include <asm/cpufeature.h>
#include <asm/fpu/api.h>
#include <asm/fpu/xstate.h>
#include "dispatch.h"
extern int n100v_LZ4_compress_default(const char *,char *,int,int,void *);
extern int n100v_LZ4_decompress_safe(const char *,char *,int,int);
bool n100_lz4_simd_available(void)
{
 return boot_cpu_has(X86_FEATURE_AVX2) &&
        cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL);
}
int n100_lz4_compress(const char *src,char *dst,int size,int capacity,void *work)
{
 int result;
 if (size != 4096 || !n100_lz4_simd_available() || !irq_fpu_usable())
  return LZ4_compress_default(src,dst,size,capacity,work);
 kernel_fpu_begin();
 result=n100v_LZ4_compress_default(src,dst,size,capacity,work);
 kernel_fpu_end();
 return result;
}
EXPORT_SYMBOL_GPL(n100_lz4_compress);
int n100_lz4_decompress(const char *src,char *dst,int size,int capacity)
{
 int result;
 if (capacity != 4096 || !n100_lz4_simd_available() || !irq_fpu_usable())
  return LZ4_decompress_safe(src,dst,size,capacity);
 kernel_fpu_begin();
 result=n100v_LZ4_decompress_safe(src,dst,size,capacity);
 kernel_fpu_end();
 return result;
}
EXPORT_SYMBOL_GPL(n100_lz4_decompress);
