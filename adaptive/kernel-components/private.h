/* SPDX-License-Identifier: GPL-2.0-only */
#include <linux/types.h>
unsigned n100_component_scalar_count(const u8 *,const u8 *,unsigned);
void n100_component_scalar_copy(u8 *,const u8 *,unsigned);
void n100_component_scalar_repeat(u8 *,const u8 *,unsigned);
unsigned n100_component_sse_count(const u8 *,const u8 *,unsigned);
void n100_component_sse_copy(u8 *,const u8 *,unsigned);
void n100_component_sse_repeat(u8 *,const u8 *,unsigned);
unsigned n100_component_avx2_count(const u8 *,const u8 *,unsigned);
void n100_component_avx2_copy(u8 *,const u8 *,unsigned);
void n100_component_avx2_repeat(u8 *,const u8 *,unsigned);
