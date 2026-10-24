/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_LZ4_USER_COMPAT_H
#define N100_LZ4_USER_COMPAT_H
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>
#include <errno.h>
#include <endian.h>
typedef uint8_t u8; typedef uint16_t u16; typedef uint32_t u32; typedef uint64_t u64;
typedef int8_t s8; typedef int16_t s16; typedef int32_t s32; typedef int64_t s64;
#undef __always_inline
#define __always_inline inline __attribute__((always_inline))
#define likely(x) __builtin_expect(!!(x),1)
#define unlikely(x) __builtin_expect(!!(x),0)
#define BUILD_BUG_ON(x) _Static_assert(!(x),"BUILD_BUG_ON")
#define min(x,y) ((x)<(y)?(x):(y))
#define max(x,y) ((x)>(y)?(x):(y))
#define CONFIG_64BIT 1
#define BITS_PER_LONG 64
#define __ffs(x) __builtin_ctzl(x)
#define __fls(x) (63-__builtin_clzl(x))
#define __init
#define __initdata
#define __maybe_unused __attribute__((unused))
#define EXPORT_SYMBOL(x)
#define EXPORT_SYMBOL_GPL(x)
#define MODULE_LICENSE(x)
#define MODULE_DESCRIPTION(x)
#define MODULE_AUTHOR(x)
#define get_unaligned(p) ({ __typeof__(*(p)) _v; __builtin_memcpy((void *)&_v,(p),sizeof(_v)); _v; })
#define put_unaligned(v,p) do { __typeof__(*(p)) _v=(v); __builtin_memcpy((p),&_v,sizeof(_v)); } while(0)
static inline uint16_t get_unaligned_le16(const void *p) { uint16_t v; memcpy(&v,p,2); return le16toh(v); }
static inline uint32_t get_unaligned_le32(const void *p) { uint32_t v; memcpy(&v,p,4); return le32toh(v); }
static inline void put_unaligned_le16(uint16_t v,void *p) { v=htole16(v); memcpy(p,&v,2); }
#endif
