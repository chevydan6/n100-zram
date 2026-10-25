#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Userspace screening prototype: bounded virtual hash positions, no cross-page dict.
The workspace must be initialized once with n100_reuse_init(). Only 4 KiB input
is supported. This is not a drop-in replacement for the ordinary workspace API.
"""
import argparse,os,shlex,shutil,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,default=root/'build/reuse');a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
for variant,base,flags in [('reset4k-scalar','scalar',['-mno-sse','-mno-mmx','-mno-avx']),('reset4k-avx2','avx2-guard',['-mavx2']),('reuse-scalar','scalar',['-mno-sse','-mno-mmx','-mno-avx']),('reuse-avx2','avx2-guard',['-mavx2']),('reuse32-scalar','scalar',['-mno-sse','-mno-mmx','-mno-avx']),('reuse32-avx2','avx2-guard',['-mavx2'])]:
 dest=a.output/variant;dest.mkdir(exist_ok=True)
 for name in ['lz4_compress.c','lz4_decompress.c','lz4defs.h']:
  shutil.copy2(root/'build'/base/name,dest/name)
 text=(dest/'lz4_compress.c').read_text();original_text=text
 old='''\t\tU16 *hashTable = (U16 *) tableBase;

\t\thashTable[h] = (U16)(p - srcBase);'''
 new='''\t\tU16 *hashTable = (U16 *) tableBase;
\t\tconst LZ4_stream_t_internal *ctx = (const LZ4_stream_t_internal *)tableBase;
\t\thashTable[h] = (U16)((U32)(p-srcBase) + ctx->currentOffset);'''
 assert text.count(old)==1;text=text.replace(old,new)
 old='''\t\treturn hashTable[h] + srcBase;
\t}
}'''
 new='''\t\tconst U32 first = ((const LZ4_stream_t_internal *)tableBase)->currentOffset;
\t\tconst U32 position = hashTable[h];
\t\treturn srcBase + (position >= first ? position-first : 0);
\t}
}'''
 assert text.count(old)==1;text=text.replace(old,new)
 old='\tLZ4_resetStream((LZ4_stream_t *)state);'
 new='''\t/* Hash positions occupy a disjoint 4 KiB virtual interval per page.
\t * Older intervals behave exactly like zeroed entries, never a dictionary. */
\tU32 next = ctx->currentOffset + 4096U;
\tif (next >= 65536U) {
\t\tmemset(ctx->hashTable, 0, sizeof(ctx->hashTable));
\t\tnext = 0;
\t}
\tctx->currentOffset = next;
\tctx->initCheck = 0;
\tctx->dictionary = NULL;
\tctx->bufferStart = NULL;
\tctx->dictSize = 0;'''
 assert text.count(old)==1;text=text.replace(old,new)
 if variant.startswith('reset4k'):text=original_text
 text+='''
/* Dedicated prototype API. Initialize once; do not mix streaming interfaces. */
__attribute__((visibility("default")))
unsigned long n100_reuse_worksize(void) { return sizeof(LZ4_stream_t); }
__attribute__((visibility("default")))
void n100_reuse_init(void *work) { memset(work, 0, sizeof(LZ4_stream_t)); }
__attribute__((visibility("default")))
int n100_reuse_compress(const char *src,char *dst,int bytes,int capacity,void *work)
{
 if (bytes != 4096 || capacity < 0) return 0;
 return LZ4_compress_default(src,dst,bytes,capacity,work);
}
'''
 if variant.startswith('reuse32'):
  text=text.replace('U16 *hashTable = (U16 *) tableBase;','U32 *hashTable = (U32 *) tableBase;')
  text=text.replace('const U16 * const hashTable = (U16 *) tableBase;','const U32 * const hashTable = (U32 *) tableBase;')
  text=text.replace('hashTable[h] = (U16)((U32)(p-srcBase) + ctx->currentOffset);','hashTable[h] = (U32)(p-srcBase) + ctx->currentOffset;')
  text=text.replace('if (next >= 65536U)', 'if (next < ctx->currentOffset)')
  private=dest/'include/linux';private.mkdir(parents=True,exist_ok=True)
  header=(root/'include/linux/lz4.h').read_text().replace('hashTable[LZ4_HASH_SIZE_U32]','hashTable[LZ4_HASH_SIZE_U32 * 2]').replace('(LZ4_MEMORY_USAGE - 3)', '(LZ4_MEMORY_USAGE - 2)')
  (private/'lz4.h').write_text(header)
 text+='\n__attribute__((visibility("default")))\nunsigned long n100_reuse_epoch_offset(void) { return __builtin_offsetof(LZ4_stream_t_internal,currentOffset); }\n'
 (dest/'lz4_compress.c').write_text(text)
 # Compression is the experiment; retain the original decoder in both DSOs.
 shutil.copy2(root/'src/kernel-lz4/lz4defs.h',dest/'baseline_defs.h')
 decoder=(dest/'lz4_decompress.c').read_text().replace('#include "lz4defs.h"','#include "baseline_defs.h"')
 decoder+='''
__attribute__((visibility("default")))
int n100_reuse_decompress(const char *src,char *dst,int bytes,int capacity)
{ return LZ4_decompress_safe(src,dst,bytes,capacity); }
'''
 (dest/'lz4_decompress.c').write_text(decoder)
 cmd=[os.environ.get('CC','gcc'),'-O3','-g','-fPIC','-fvisibility=hidden','-fno-semantic-interposition','-fno-strict-aliasing','-fno-tree-vectorize','-Wall','-Wextra','-Wno-unused-parameter',*flags,*shlex.split(os.environ.get('EXTRA_CFLAGS','')),'-I'+str(dest/'include'),'-I'+str(root/'include'),'-shared','-Wl,-Bsymbolic-functions',str(dest/'lz4_compress.c'),str(dest/'lz4_decompress.c'),'-o',str(a.output/(variant+'.so'))]
 subprocess.run(cmd,check=True);print(variant,'built',flush=True)
