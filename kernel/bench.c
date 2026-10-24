// SPDX-License-Identifier: GPL-2.0-only
/* Benchmark-only misc interface. No registration or replacement of ZRAM. */
#include <linux/module.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include <linux/uaccess.h>
#include <linux/lz4.h>
#include <linux/mutex.h>
#include "dispatch.h"
#include "bench.h"
#define BLOCK 4096
#define BOUND 4352
struct bench_context {
 struct mutex lock;
 char *input, *packed, *output, *check;
 void *work;
 int sizes[N100_BENCH_PAGES];
 unsigned cursor;
 bool ready;
};
static void free_context(struct bench_context *ctx)
{
 if (!ctx) return;
 kvfree(ctx->input);kvfree(ctx->packed);
 kfree(ctx->output);kfree(ctx->check);kfree(ctx->work);kfree(ctx);
}
static int bench_open(struct inode *inode,struct file *file)
{
 struct bench_context *ctx=kzalloc(sizeof(*ctx),GFP_KERNEL);
 if (!ctx) return -ENOMEM;
 ctx->input=kvzalloc(N100_BENCH_PAGES*BLOCK,GFP_KERNEL);
 ctx->packed=kvzalloc(N100_BENCH_PAGES*BOUND,GFP_KERNEL);
 ctx->output=kmalloc(BLOCK,GFP_KERNEL);ctx->check=kmalloc(BOUND,GFP_KERNEL);
 ctx->work=kmalloc(LZ4_MEM_COMPRESS,GFP_KERNEL);
 if (!ctx->input||!ctx->packed||!ctx->output||!ctx->check||!ctx->work) {
  free_context(ctx);return -ENOMEM;
 }
 mutex_init(&ctx->lock);file->private_data=ctx;return nonseekable_open(inode,file);
}
static int bench_release(struct inode *inode,struct file *file)
{
 free_context(file->private_data);return 0;
}
static ssize_t bench_write(struct file *file,const char __user *data,size_t count,loff_t *offset)
{
 struct bench_context *ctx=file->private_data;
 ssize_t result=-EFAULT;
 unsigned page;
 if (count!=N100_BENCH_PAGES*BLOCK) return -EINVAL;
 mutex_lock(&ctx->lock);ctx->ready=false;
 if (copy_from_user(ctx->input,data,count)) goto out;
 for (page=0;page<N100_BENCH_PAGES;page++) {
  int size=LZ4_compress_default(ctx->input+page*BLOCK,ctx->packed+page*BOUND,BLOCK,BOUND,ctx->work);
  if (size<=0) {result=-EIO;goto out;}
  ctx->sizes[page]=size;
 }
 ctx->cursor=0;ctx->ready=true;result=count;
out:
 mutex_unlock(&ctx->lock);return result;
}
static ssize_t bench_read(struct file *file,char __user *data,size_t count,loff_t *offset)
{
 struct bench_context *ctx=file->private_data;
 ssize_t result=-EINVAL;
 if (count!=N100_BENCH_PAGES*BLOCK) return -EINVAL;
 mutex_lock(&ctx->lock);
 if (ctx->ready) result=copy_to_user(data,ctx->input,count)?-EFAULT:count;
 mutex_unlock(&ctx->lock);return result;
}
static long bench_ioctl(struct file *file,unsigned int command,unsigned long argument)
{
 struct bench_context *ctx=file->private_data;
 long result=-EINVAL;
 unsigned page;
 mutex_lock(&ctx->lock);
 if (!ctx->ready) goto out;
 if (command==N100_BENCH_VALIDATE) {
  for (page=0;page<N100_BENCH_PAGES;page++) {
   int size=LZ4_compress_default(ctx->input+page*BLOCK,ctx->check,BLOCK,BOUND,ctx->work);
   if (size!=ctx->sizes[page] || memcmp(ctx->check,ctx->packed+page*BOUND,size)) {result=-EIO;goto out;}
   size=n100_lz4_compress(ctx->input+page*BLOCK,ctx->check,BLOCK,BOUND,ctx->work);
   if (size!=ctx->sizes[page] || memcmp(ctx->check,ctx->packed+page*BOUND,size)) {result=-EIO;goto out;}
   if (LZ4_decompress_safe(ctx->check,ctx->output,size,BLOCK)!=BLOCK || memcmp(ctx->input+page*BLOCK,ctx->output,BLOCK)) {result=-EIO;goto out;}
   if (n100_lz4_decompress(ctx->check,ctx->output,size,BLOCK)!=BLOCK || memcmp(ctx->input+page*BLOCK,ctx->output,BLOCK)) {result=-EIO;goto out;}
  }
  ctx->cursor=0;result=0;goto out;
 }
 page=ctx->cursor;ctx->cursor=(page+1)&(N100_BENCH_PAGES-1);
 switch (command) {
 case N100_BENCH_COMP_SCALAR:
  result=LZ4_compress_default(ctx->input+page*BLOCK,ctx->packed+page*BOUND,BLOCK,BOUND,ctx->work);break;
 case N100_BENCH_COMP_SIMD:
  result=n100_lz4_compress(ctx->input+page*BLOCK,ctx->packed+page*BOUND,BLOCK,BOUND,ctx->work);break;
 case N100_BENCH_DEC_SCALAR:
  result=LZ4_decompress_safe(ctx->packed+page*BOUND,ctx->output,ctx->sizes[page],BLOCK);break;
 case N100_BENCH_DEC_SIMD:
  result=n100_lz4_decompress(ctx->packed+page*BOUND,ctx->output,ctx->sizes[page],BLOCK);break;
 default:goto out;
 }
 if (result<=0 || result!=((command==N100_BENCH_COMP_SCALAR || command==N100_BENCH_COMP_SIMD)?ctx->sizes[page]:BLOCK)) result=-EIO;
out:
 mutex_unlock(&ctx->lock);return result;
}
static const struct file_operations bench_ops={
 .owner=THIS_MODULE,.open=bench_open,.release=bench_release,
 .write=bench_write,.read=bench_read,.unlocked_ioctl=bench_ioctl,
};
static struct miscdevice bench_device={
 .minor=MISC_DYNAMIC_MINOR,.name="n100-lz4-bench",.fops=&bench_ops,.mode=0600,
};
int n100_bench_register(void) {return misc_register(&bench_device);}
void n100_bench_unregister(void) {misc_deregister(&bench_device);}
