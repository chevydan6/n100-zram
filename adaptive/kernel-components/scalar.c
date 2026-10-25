// SPDX-License-Identifier: GPL-2.0-only
#include <linux/string.h>
#include <linux/unaligned.h>
#include "private.h"
unsigned n100_component_scalar_count(const u8 *a,const u8 *b,unsigned n)
{
 unsigned at=0;
 while(n-at>=8){u64 diff=get_unaligned_le64(a+at)^get_unaligned_le64(b+at);if(diff)return at+__builtin_ctzll(diff)/8;at+=8;}
 while(at<n&&a[at]==b[at])at++;
 return at;
}
void n100_component_scalar_copy(u8 *dst,const u8 *src,unsigned n){memcpy(dst,src,n);}
void n100_component_scalar_repeat(u8 *dst,const u8 *src,unsigned n)
{
 u64 value=get_unaligned_le64(src);unsigned long count=n/8;u8 *at=dst;
 asm volatile("rep stosq" : "+D"(at),"+c"(count) : "a"(value) : "memory");
 memcpy(at,src,n%8);
}
