/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_GHY_PROBE_H
#define N100_GHY_PROBE_H
#include <linux/ioctl.h>
#define GHY_PROBE_PAGES 128
#define GHY_PROBE_PAGE_BYTES 4096
#define GHY_PROBE_CODECS 3
/* Codec 0: matched private LZ4; 1: wordmixed; 2: bitpack/CTZ workspace port. */
#define GHY_PROBE_NOP _IO('G', 0)
#define GHY_PROBE_VALIDATE _IO('G', 1)
#define GHY_PROBE_FPU_NOP _IO('G', 2)
#define GHY_PROBE_COMP(codec) _IO('G', 16 + 2 * (codec))
#define GHY_PROBE_DEC(codec) _IO('G', 17 + 2 * (codec))
#define GHY_PROBE_COMP_FPU(codec) _IO('G', 32 + 2 * (codec))
#define GHY_PROBE_DEC_FPU(codec) _IO('G', 33 + 2 * (codec))
/* write exactly 128 pages; read exactly 3*128 native u32 compressed sizes.
 * One timed ioctl processes one resident page, with an independent cursor for
 * each codec/direction. FPU_NOP is a separate empty begin/end control; codec
 * calls remain scalar. No asynchronous queue or ZRAM registration. */
#endif
