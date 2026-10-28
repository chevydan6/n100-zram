// SPDX-License-Identifier: GPL-2.0-only
/* Experimental scalar codec measurement interface, never a ZRAM backend. */
#include <linux/module.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include <linux/uaccess.h>
#include <linux/mutex.h>
#include <asm/fpu/api.h>
#include "hybrid-probe.h"
#include "control/private-lz4.h"

#define BLOCK GHY_PROBE_PAGE_BYTES
#define PAGES GHY_PROBE_PAGES
#define CODECS GHY_PROBE_CODECS
#define ROOM 4352
#define DECLARE_CODEC(prefix) \
 int prefix##_encode_scalar(const void *, size_t, void *, size_t, unsigned, void *, size_t); \
 size_t prefix##_workspace_size(void); \
 size_t prefix##_workspace_alignment(void); \
 int prefix##_decode_scalar(const void *, size_t, void *, size_t)
DECLARE_CODEC(control);
DECLARE_CODEC(candidate);

struct probe_context {
 struct mutex lock;
 u8 *input, *packed[CODECS], *output, *check;
 n100_private_lz4_stream_t *work;
 u32 sizes[CODECS][PAGES];
 unsigned cursor[CODECS][2];
 bool ready;
};

static int encode(struct probe_context *ctx, unsigned codec, unsigned page, u8 *out)
{
 const u8 *src = ctx->input + page * BLOCK;
 if (codec == 0)
  return n100_private_lz4_compress_default((const char *)src, (char *)out, BLOCK, ROOM, ctx->work);
 if (codec == 1)
  return control_encode_scalar(src, BLOCK, out, ROOM, 10, ctx->work, sizeof(*ctx->work));
 return candidate_encode_scalar(src, BLOCK, out, ROOM, 10, ctx->work, sizeof(*ctx->work));
}

static int decode(struct probe_context *ctx, unsigned codec, const u8 *src, unsigned size)
{
 if (codec == 0) return n100_private_lz4_decompress_safe((const char *)src, (char *)ctx->output, size, BLOCK);
 if (codec == 1) return control_decode_scalar(src, size, ctx->output, BLOCK);
 return candidate_decode_scalar(src, size, ctx->output, BLOCK);
}

static void free_context(struct probe_context *ctx)
{
 unsigned codec;
 if (!ctx) return;
 kvfree(ctx->input);
 for (codec = 0; codec < CODECS; codec++) kvfree(ctx->packed[codec]);
 kfree(ctx->output); kfree(ctx->check); kfree(ctx->work); kfree(ctx);
}

static int probe_open(struct inode *inode, struct file *file)
{
 struct probe_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 unsigned codec;
 if (!ctx) return -ENOMEM;
 ctx->input = kvzalloc(PAGES * BLOCK, GFP_KERNEL);
 ctx->output = kmalloc(BLOCK, GFP_KERNEL);
 ctx->check = kmalloc(ROOM, GFP_KERNEL);
 ctx->work = kmalloc(sizeof(*ctx->work), GFP_KERNEL);
 if (!ctx->input || !ctx->output || !ctx->check || !ctx->work) goto fail;
 for (codec = 0; codec < CODECS; codec++) {
  ctx->packed[codec] = kvzalloc(PAGES * ROOM, GFP_KERNEL);
  if (!ctx->packed[codec]) goto fail;
 }
 mutex_init(&ctx->lock);
 file->private_data = ctx;
 return nonseekable_open(inode, file);
fail:
 free_context(ctx); return -ENOMEM;
}

static int probe_release(struct inode *inode, struct file *file)
{
 free_context(file->private_data); return 0;
}

static ssize_t probe_write(struct file *file, const char __user *data, size_t count, loff_t *offset)
{
 struct probe_context *ctx = file->private_data;
 ssize_t result = -EFAULT;
 unsigned codec, page;
 if (count != PAGES * BLOCK) return -EINVAL;
 if (mutex_lock_interruptible(&ctx->lock)) return -ERESTARTSYS;
 ctx->ready = false;
 if (copy_from_user(ctx->input, data, count)) goto out;
 for (codec = 0; codec < CODECS; codec++) for (page = 0; page < PAGES; page++) {
  int size = encode(ctx, codec, page, ctx->packed[codec] + page * ROOM);
  if (size <= 0 || size > ROOM) { result = -EIO; goto out; }
  ctx->sizes[codec][page] = size;
 }
 memset(ctx->cursor, 0, sizeof(ctx->cursor));
 ctx->ready = true; result = count;
out:
 mutex_unlock(&ctx->lock); return result;
}

static ssize_t probe_read(struct file *file, char __user *data, size_t count, loff_t *offset)
{
 struct probe_context *ctx = file->private_data;
 ssize_t result = -EINVAL;
 if (count != sizeof(ctx->sizes)) return -EINVAL;
 if (mutex_lock_interruptible(&ctx->lock)) return -ERESTARTSYS;
 if (ctx->ready) result = copy_to_user(data, ctx->sizes, count) ? -EFAULT : count;
 mutex_unlock(&ctx->lock); return result;
}

/* Outside timing: check every retained encoded page, scalar byte identity and
 * both directions of GHY1 compatibility; reset all measurement cursors. */
static int validate(struct probe_context *ctx)
{
 unsigned codec, page, other;
 for (codec = 0; codec < CODECS; codec++) for (page = 0; page < PAGES; page++) {
  const u8 *stored = ctx->packed[codec] + page * ROOM;
  int size = encode(ctx, codec, page, ctx->check);
  if (size <= 0 || size != ctx->sizes[codec][page] || memcmp(ctx->check, stored, size)) return -EIO;
  for (other = codec ? 1 : 0; other < (codec ? CODECS : 1); other++) {
   if (decode(ctx, other, stored, size) != BLOCK ||
       memcmp(ctx->output, ctx->input + page * BLOCK, BLOCK)) return -EIO;
  }
  if (codec == 2 && (size != ctx->sizes[1][page] ||
      memcmp(stored, ctx->packed[1] + page * ROOM, size))) return -EIO;
 }
 memset(ctx->cursor, 0, sizeof(ctx->cursor)); return 0;
}

static long probe_ioctl(struct file *file, unsigned int command, unsigned long argument)
{
 struct probe_context *ctx = file->private_data;
 long result = -EINVAL;
 unsigned codec, operation, page;
 if (argument) return -EINVAL;
 if (command != GHY_PROBE_NOP && command != GHY_PROBE_FPU_NOP && command != GHY_PROBE_VALIDATE &&
     (command < GHY_PROBE_COMP(0) || command > GHY_PROBE_DEC(CODECS - 1))) return -ENOTTY;
 if (mutex_lock_interruptible(&ctx->lock)) return -ERESTARTSYS;
 if (command == GHY_PROBE_NOP) { result = 0; goto out; }
 if (command == GHY_PROBE_FPU_NOP) {
  if (!irq_fpu_usable()) { result = -EOPNOTSUPP; goto out; }
  /* Empty matched state-management control, with no codec or vector work. */
  kernel_fpu_begin();
  kernel_fpu_end();
  result = 0; goto out;
 }
 if (!ctx->ready) goto out;
 if (command == GHY_PROBE_VALIDATE) { result = validate(ctx); goto out; }
 codec = (command - GHY_PROBE_COMP(0)) / 2;
 operation = (command - GHY_PROBE_COMP(0)) & 1;
 page = ctx->cursor[codec][operation];
 ctx->cursor[codec][operation] = (page + 1) % PAGES;
 if (operation) result = decode(ctx, codec, ctx->packed[codec] + page * ROOM, ctx->sizes[codec][page]);
 else result = encode(ctx, codec, page, ctx->packed[codec] + page * ROOM);
 if (result <= 0 || result != (operation ? BLOCK : ctx->sizes[codec][page])) result = -EIO;
out:
 mutex_unlock(&ctx->lock); return result;
}

static const struct file_operations probe_ops = {
 .owner = THIS_MODULE, .open = probe_open, .release = probe_release,
 .write = probe_write, .read = probe_read, .unlocked_ioctl = probe_ioctl,
};
static struct miscdevice probe_device = {
 .minor = MISC_DYNAMIC_MINOR, .name = "n100-ghy-probe", .fops = &probe_ops, .mode = 0600,
};
static int __init probe_init(void)
{
 if (control_workspace_size() != sizeof(n100_private_lz4_stream_t) ||
     candidate_workspace_size() != sizeof(n100_private_lz4_stream_t) ||
     control_workspace_alignment() > ARCH_KMALLOC_MINALIGN ||
     candidate_workspace_alignment() > ARCH_KMALLOC_MINALIGN) return -EINVAL;
 return misc_register(&probe_device);
}
static void __exit probe_exit(void) { misc_deregister(&probe_device); }
module_init(probe_init);
module_exit(probe_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Experimental resident-page scalar GHY1 syscall probe; no ZRAM registration");
