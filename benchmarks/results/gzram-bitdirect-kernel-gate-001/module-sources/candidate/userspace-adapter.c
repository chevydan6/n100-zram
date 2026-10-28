/* SPDX-License-Identifier: GPL-2.0-only */
/* Test compatibility adapter only; never include in a kernel build. */
#ifdef __KERNEL__
#error Userspace test adapter is not a kernel API
#endif
#include "ghy_scalar.h"
#include "private-lz4.h"
static _Thread_local n100_private_lz4_stream_t work;
int gzram_avx2_available(void) { return 0; }
int gzram_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log)
{ return n100_ghy_encode(s,n,d,cap,log,&work,sizeof(work)); }
int gzram_encode_avx2(const void *s,size_t n,void *d,size_t cap,unsigned log)
{ return gzram_encode_scalar(s,n,d,cap,log); }
int gzram_decode_scalar(const void *s,size_t n,void *d,size_t cap)
{ return n100_ghy_decode(s,n,d,cap); }
int gzram_decode_avx2(const void *s,size_t n,void *d,size_t cap)
{ return n100_ghy_decode(s,n,d,cap); }
