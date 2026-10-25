// SPDX-License-Identifier: GPL-2.0-only
/* Root-only benchmark probe. Does not register a compressor or modify ZRAM. */
#include <linux/module.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>
#include <linux/uaccess.h>
#include <linux/mutex.h>
#include <linux/string.h>
#include <asm/cpufeature.h>
#include <asm/fpu/api.h>
#include <asm/fpu/xstate.h>
#include "api.h"
#include "private.h"
#define LIMIT 65536
struct component_context {struct mutex lock;u8 *a,*b,*dst;struct n100_component_config config;unsigned batch;bool ready;};
static bool has_sse,has_avx2;
static void release_context(struct component_context *c){if(c){kvfree(c->a);kvfree(c->b);kvfree(c->dst);kfree(c);}}
static struct component_context *new_context(void)
{
 struct component_context *c=kzalloc(sizeof(*c),GFP_KERNEL);if(!c)return NULL;
 c->a=kvzalloc(LIMIT+16*32,GFP_KERNEL);c->b=kvzalloc(LIMIT+16*32,GFP_KERNEL);c->dst=kvzalloc(LIMIT+16*32,GFP_KERNEL);
 if(!c->a||!c->b||!c->dst){release_context(c);return NULL;}
 mutex_init(&c->lock);c->batch=1;return c;
}
static void configure(struct component_context *c)
{
 unsigned n=c->config.length;u32 r=100;
 for(unsigned page=0;page<c->batch;page++){
  unsigned offset=page*(n+32);
  for(unsigned i=0;i<n;i++){r^=r<<13;r^=r>>17;r^=r<<5;c->a[offset+i]=(u8)r;}
  memcpy(c->b+offset,c->a+offset,n);
  if(c->config.pattern){unsigned at=c->config.pattern==1?0:c->config.pattern==2?n/2:n-1;c->b[offset+at]^=1;}
 }
 memset(c->dst,0xa5,c->batch*(n+32));
 c->ready=true;
}
static unsigned execute(struct component_context *c,unsigned variant)
{
 unsigned n=c->config.length,result=0;bool fpu=variant&&irq_fpu_usable()&&has_sse&&(variant!=3||has_avx2);
 if(!fpu)variant=0;
 if(fpu)kernel_fpu_begin();
 for(unsigned page=0;page<c->batch;page++){
  unsigned offset=page*(n+32);u8 *a=c->a+offset,*b=c->b+offset,*dst=c->dst+offset;
  if(c->config.operation==0){
   if(variant==2)result+=n100_component_sse_count(a,b,n);
   else if(variant==3)result+=n100_component_avx2_count(a,b,n);
   else result+=n100_component_scalar_count(a,b,n);
  }else if(c->config.operation==1){
   if(variant==2)n100_component_sse_copy(dst,a,n);
   else if(variant==3)n100_component_avx2_copy(dst,a,n);
   else n100_component_scalar_copy(dst,a,n);
   result+=n;
  }else{
   if(variant==2)n100_component_sse_repeat(dst,a,n);
   else if(variant==3)n100_component_avx2_repeat(dst,a,n);
   else n100_component_scalar_repeat(dst,a,n);
   result+=n;
  }
 }
 if(fpu)kernel_fpu_end();
 return result;
}
static int verify(struct component_context *c)
{
 unsigned n=c->config.length,wanted=0;
 for(unsigned page=0;page<c->batch;page++){
  unsigned count=n,offset=page*(n+32);
  if(c->config.operation==0)for(unsigned i=0;i<n;i++)if(c->a[offset+i]!=c->b[offset+i]){count=i;break;}
  wanted+=count;
 }
 for(unsigned v=0;v<4;v++){
  memset(c->dst,0xa5,c->batch*(n+32));if(execute(c,v)!=wanted)return -EIO;
  for(unsigned page=0;page<c->batch;page++){
   unsigned offset=page*(n+32);
   if(c->config.operation)for(unsigned i=0;i<n;i++)if(c->dst[offset+i]!=c->a[offset+(c->config.operation==1?i:i%8)])return -EIO;
   if(memchr_inv(c->dst+offset+n,0xa5,32))return -EIO;
  }
 }
 /* An active kernel FPU section must force the scalar fallback. */
 if(has_sse&&irq_fpu_usable()){
  unsigned result;kernel_fpu_begin();result=execute(c,3);kernel_fpu_end();if(result!=wanted)return -EIO;
 }
 return 0;
}
static int probe_open(struct inode *inode,struct file *f){struct component_context *c=new_context();if(!c)return -ENOMEM;f->private_data=c;return nonseekable_open(inode,f);}
static int probe_release(struct inode *inode,struct file *f){release_context(f->private_data);return 0;}
static long probe_ioctl(struct file *f,unsigned command,unsigned long argument)
{
 struct component_context *c=f->private_data;long result=-EINVAL;struct n100_component_config config;
 if(command==N100_COMPONENT_CONFIG||command==N100_COMPONENT_CONFIG_BATCH){
  unsigned batch;
  if(copy_from_user(&config,(void __user *)argument,sizeof(config)))return -EFAULT;
  batch=command==N100_COMPONENT_CONFIG_BATCH?config.reserved:1;
  if(config.length<16||config.length>LIMIT||config.operation>2||config.pattern>3||!batch||batch>16||config.length>LIMIT/batch||(command==N100_COMPONENT_CONFIG&&config.reserved))return -EINVAL;
  config.reserved=0;
  mutex_lock(&c->lock);c->config=config;c->batch=batch;configure(c);mutex_unlock(&c->lock);return 0;
 }
 mutex_lock(&c->lock);
 if(c->ready){
  if(command==N100_COMPONENT_VERIFY)result=verify(c);
  else if(command>=N100_COMPONENT_RUN_SCALAR&&command<=N100_COMPONENT_RUN_AVX2)result=(long)execute(c,command-N100_COMPONENT_RUN_SCALAR)+1;
 }
 mutex_unlock(&c->lock);return result;
}
static const struct file_operations ops={.owner=THIS_MODULE,.open=probe_open,.release=probe_release,.unlocked_ioctl=probe_ioctl};
static struct miscdevice device={.minor=MISC_DYNAMIC_MINOR,.name="n100-component-bench",.fops=&ops,.mode=0600};
static int __init start(void)
{
 struct component_context *c;int result;
 has_sse=boot_cpu_has(X86_FEATURE_XMM2);has_avx2=boot_cpu_has(X86_FEATURE_AVX2)&&cpu_has_xfeatures(XFEATURE_MASK_SSE|XFEATURE_MASK_YMM,NULL);
 c=new_context();if(!c)return -ENOMEM;
 for(unsigned batch=1;batch<=16;batch*=2)for(unsigned operation=0;operation<3;operation++)for(unsigned pattern=0;pattern<4;pattern++){
  c->batch=batch;
  c->config=(struct n100_component_config){.length=63,.operation=operation,.pattern=pattern};configure(c);result=verify(c);if(result){release_context(c);return result;}
 }
 release_context(c);pr_info("n100-component-probe: scalar/SSE/AVX2 init checks passed; sse=%d avx2=%d\n",has_sse,has_avx2);return misc_register(&device);
}
static void __exit stop(void){misc_deregister(&device);}
module_init(start);module_exit(stop);MODULE_LICENSE("GPL");MODULE_DESCRIPTION("Isolated N100 component and kernel SIMD entry-cost experiment");
