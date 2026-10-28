/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_GHY_SCALAR_PORT_H
#define N100_GHY_SCALAR_PORT_H
#ifdef __KERNEL__
#include <linux/types.h>
#else
#include <stddef.h>
#endif
/* Nonoverlapping buffers. Input <=4096; log=5..12. Encode returns bytes or 0;
 * decode returns bytes or -1 and may modify a bounded prefix on failure.
 * Each concurrent encode requires its own aligned workspace; its contents are
 * reset by LZ4 when used. No cross-page dictionary or mutable shared state. */
size_t n100_ghy_workspace_size(void);
size_t n100_ghy_workspace_alignment(void);
int n100_ghy_encode(const void *,size_t,void *,size_t,unsigned,void *,size_t);
int n100_ghy_decode(const void *,size_t,void *,size_t);
#endif
