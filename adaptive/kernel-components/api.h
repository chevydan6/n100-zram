/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_COMPONENT_API_H
#define N100_COMPONENT_API_H
#include <linux/types.h>
#include <linux/ioctl.h>
struct n100_component_config { __u32 length,operation,pattern,reserved; };
#define N100_COMPONENT_CONFIG _IOW('Q',80,struct n100_component_config)
#define N100_COMPONENT_VERIFY _IO('Q',81)
#define N100_COMPONENT_RUN_SCALAR _IO('Q',82)
#define N100_COMPONENT_RUN_FPU_SCALAR _IO('Q',83)
#define N100_COMPONENT_RUN_SSE _IO('Q',84)
#define N100_COMPONENT_RUN_AVX2 _IO('Q',85)
#endif
