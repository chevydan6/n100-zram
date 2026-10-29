// SPDX-License-Identifier: GPL-2.0-only
/* Experimental scalar GHY1 ZRAM adapter. No SIMD or cross-page dictionary. */
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include "backend_ghy_bitdirect.h"
#include "ghy/ghy_scalar.h"

static int ghy_setup_params(struct zcomp_params *params)
{
 /* The independently recoverable format has no dictionary/level interface. */
 if (params->dict || params->dict_sz || params->level != ZCOMP_PARAM_NOT_SET)
  return -EINVAL;
 return 0;
}
static void ghy_release_params(struct zcomp_params *params)
{
 /* No shared allocation or mutable state belongs to these parameters. */
 (void)params;
}
static int ghy_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
{
 (void)params;
 BUILD_BUG_ON(PAGE_SIZE != 4096);
 ctx->context = kvzalloc(n100_ghy_workspace_size(), GFP_KERNEL);
 if (!ctx->context) return -ENOMEM;
 if (!IS_ALIGNED((unsigned long)ctx->context, n100_ghy_workspace_alignment())) {
  kvfree(ctx->context); ctx->context = NULL; return -EINVAL;
 }
 return 0;
}
static void ghy_destroy(struct zcomp_ctx *ctx)
{
 kvfree(ctx->context); ctx->context = NULL;
}
static int ghy_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
                        struct zcomp_req *req)
{
 int count;
 (void)params;
 if (req->src_len != PAGE_SIZE || !ctx->context) return -EINVAL;
 count = n100_ghy_encode(req->src, req->src_len, req->dst, req->dst_len,
                         10, ctx->context, n100_ghy_workspace_size());
 if (count <= 0) return -EINVAL;
 req->dst_len = count;
 return 0;
}
static int ghy_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
                          struct zcomp_req *req)
{
 int count;
 (void)params; (void)ctx;
 if (req->dst_len != PAGE_SIZE) return -EINVAL;
 count = n100_ghy_decode(req->src, req->src_len, req->dst, req->dst_len);
 return count == PAGE_SIZE ? 0 : -EINVAL;
}
const struct zcomp_ops backend_ghy_bitdirect = {
 .compress = ghy_compress,
 .decompress = ghy_decompress,
 .create_ctx = ghy_create,
 .destroy_ctx = ghy_destroy,
 .setup_params = ghy_setup_params,
 .release_params = ghy_release_params,
 .name = "ghy-bitdirect",
};
