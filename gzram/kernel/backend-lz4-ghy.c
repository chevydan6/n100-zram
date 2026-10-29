// SPDX-License-Identifier: GPL-2.0-only
/* Matched private scalar LZ4 control for the GHY1 backend's fallback codec. */
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include "backend_ghy_bitdirect.h"
#include "ghy/private-lz4.h"

static int private_setup_params(struct zcomp_params *params)
{
 if (params->dict || params->dict_sz || params->level != ZCOMP_PARAM_NOT_SET)
  return -EINVAL;
 return 0;
}
static void private_release_params(struct zcomp_params *params) { (void)params; }
static int private_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
{
 (void)params;
 BUILD_BUG_ON(PAGE_SIZE != 4096);
 ctx->context = kvzalloc(sizeof(n100_private_lz4_stream_t), GFP_KERNEL);
 return ctx->context ? 0 : -ENOMEM;
}
static void private_destroy(struct zcomp_ctx *ctx)
{
 kvfree(ctx->context); ctx->context = NULL;
}
static int private_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
                            struct zcomp_req *req)
{
 int count;
 (void)params;
 if (req->src_len != PAGE_SIZE || !ctx->context) return -EINVAL;
 count = n100_private_lz4_compress_default(req->src, req->dst, req->src_len,
                                          req->dst_len, ctx->context);
 if (count <= 0) return -EINVAL;
 req->dst_len = count;
 return 0;
}
static int private_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
                              struct zcomp_req *req)
{
 int count;
 (void)params; (void)ctx;
 if (req->dst_len != PAGE_SIZE) return -EINVAL;
 count = n100_private_lz4_decompress_safe(req->src, req->dst, req->src_len,
                                         req->dst_len);
 return count == PAGE_SIZE ? 0 : -EINVAL;
}
const struct zcomp_ops backend_lz4_ghy = {
 .compress = private_compress,
 .decompress = private_decompress,
 .create_ctx = private_create,
 .destroy_ctx = private_destroy,
 .setup_params = private_setup_params,
 .release_params = private_release_params,
 .name = "lz4-ghy",
};
