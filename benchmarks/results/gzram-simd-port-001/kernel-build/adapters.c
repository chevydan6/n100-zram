/* SPDX-License-Identifier: GPL-2.0-only */
#include "simd.h"
#define WORKSPACE(prefix) \
 size_t prefix##_workspace_size(void) { return n100_ghy_workspace_size(); } \
 size_t prefix##_workspace_alignment(void) { return n100_ghy_workspace_alignment(); }
WORKSPACE(control)
WORKSPACE(candidate)
int control_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log,void *w,size_t ws)
{ return n100_ghy_encode(s,n,d,cap,log,w,ws); }
int candidate_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log,void *w,size_t ws)
{ return n100_simd_encode(s,n,d,cap,log,w,ws); }
int control_decode_scalar(const void *s,size_t n,void *d,size_t cap)
{ return n100_ghy_decode(s,n,d,cap); }
int candidate_decode_scalar(const void *s,size_t n,void *d,size_t cap)
{ return n100_simd_decode(s,n,d,cap); }
