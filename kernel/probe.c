// SPDX-License-Identifier: GPL-2.0-only
/* Experimental self-test module. Does not replace ZRAM or register a codec. */
#include <linux/module.h>
#include <linux/lz4.h>
#include <linux/slab.h>
#include <linux/ktime.h>
#include <linux/sched.h>
#include <linux/string.h>
#include "dispatch.h"
#include <asm/fpu/api.h>
static unsigned int iterations=1024;
module_param(iterations,uint,0444);
static int __init n100_probe_init(void)
{
 char *src=NULL,*packed=NULL,*reference=NULL,*decoded=NULL;
 void *work=NULL;int ret=-ENOMEM,kind,p,n,refsize,size;u32 random=100;
 u64 start,elapsed;
 if (iterations<1 || iterations>8192)return -EINVAL;
 src=kmalloc(4096,GFP_KERNEL);packed=kmalloc(4352,GFP_KERNEL);
 reference=kmalloc(4352,GFP_KERNEL);decoded=kmalloc(4352,GFP_KERNEL);
 work=kmalloc(LZ4_MEM_COMPRESS,GFP_KERNEL);
 if(!src||!packed||!reference||!decoded||!work)goto out;
 pr_info("n100-lz4-probe: simd=%d, per-page FPU bracketing, iterations=%u\n",n100_lz4_simd_available(),iterations);
 for(kind=0;kind<5;kind++){
  for(p=0;p<4096;p++){
   random^=random<<13;random^=random>>17;random^=random<<5;
   src[p]=kind==0?random:kind==1?0:kind==2?p%3:kind==3?p%31:p%127;
  }
  refsize=LZ4_compress_default(src,reference,4096,4352,work);
  size=n100_lz4_compress(src,packed,4096,4352,work);
  ret=-EINVAL;
  if(size<=0||size!=refsize||memcmp(packed,reference,size))goto out;
  if(n100_lz4_decompress(packed,decoded,size,4096)!=4096||memcmp(src,decoded,4096))goto out;
  if(LZ4_decompress_safe(packed,decoded,size,4096)!=4096||memcmp(src,decoded,4096))goto out;
  /* An already active kernel FPU section must choose scalar fallback. */
  if (n100_lz4_simd_available()) {
   int nested_comp,nested_dec; bool usable;
   kernel_fpu_begin();
   usable=irq_fpu_usable();
   nested_comp=n100_lz4_compress(src,packed,4096,4352,work);
   nested_dec=n100_lz4_decompress(packed,decoded,size,4096);
   kernel_fpu_end();
   if(usable||nested_comp!=size||nested_dec!=4096||memcmp(src,decoded,4096)){ret=-EINVAL;goto out;}
  }
  for(n=0;n<4;n++){
   unsigned int i;start=ktime_get_ns();
   for(i=0;i<iterations;i++){
    if(n==0)ret=LZ4_compress_default(src,packed,4096,4352,work);
    else if(n==1)ret=n100_lz4_compress(src,packed,4096,4352,work);
    else if(n==2)ret=LZ4_decompress_safe(packed,decoded,size,4096);
    else ret=n100_lz4_decompress(packed,decoded,size,4096);
    if(ret!=(n<2?size:4096)){ret=-EINVAL;goto out;}
    if((i&127)==127)cond_resched();
   }
   elapsed=ktime_get_ns()-start;
   pr_info("n100-lz4-probe: pattern=%d path=%d total_ns=%llu pages=%u compressed=%d\n",kind,n,elapsed,iterations,size);
  }
 }
 /* Differential malformed and truncated blocks, including output bounds. */
 memcpy(src,packed,size);
 for(n=0;n<2048;n++){
  int bytes=1+(n%511),capacity=(n%7)?4096:(n%257),scalar,vector;
  if((n&3)==0){bytes=n%size;memcpy(packed,src,bytes);}
  else for(p=0;p<bytes;p++){
   random^=random<<13;random^=random>>17;random^=random<<5;
   packed[p]=random;
  }
  memset(reference,0xa5,4352);memset(decoded,0xa5,4352);
  scalar=LZ4_decompress_safe(packed,reference,bytes,capacity);
  vector=n100_lz4_decompress(packed,decoded,bytes,capacity);
  if((scalar<0)!=(vector<0) || (scalar>=0 && (scalar!=vector || memcmp(reference,decoded,scalar))) ||
     memchr_inv(reference+capacity,0xa5,4352-capacity) ||
     memchr_inv(decoded+capacity,0xa5,4352-capacity)) {ret=-EINVAL;goto out;}
 }
 pr_info("n100-lz4-probe: malformed/truncated differential checks passed: 2048\n");
 ret=0;
out:
 kfree(work);kfree(decoded);kfree(reference);kfree(packed);kfree(src);
 return ret;
}
static void __exit n100_probe_exit(void) {}
module_init(n100_probe_init);
module_exit(n100_probe_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Experimental N100 LZ4 SIMD self-test and FPU-inclusive timing probe");
