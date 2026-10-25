#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Private 4 KiB codec APIs with smaller, fully reset hash tables."""
import argparse,os,shlex,shutil,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,default=root/'build/small-table');a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
for bits in [14,13,12,11]:
 for kind,base,flags in [('scalar','scalar',['-mno-sse','-mno-mmx','-mno-avx']),('avx2','avx2-guard',['-mavx2'])]:
  name=f'table{bits}-{kind}';dest=a.output/name;dest.mkdir(exist_ok=True)
  for filename in ['lz4_compress.c','lz4_decompress.c','lz4defs.h']:shutil.copy2(root/'build'/base/filename,dest/filename)
  header=(root/'include/linux/lz4.h').read_text();assert header.count('#define LZ4_MEMORY_USAGE 14')==1
  private=dest/'include/linux';private.mkdir(parents=True,exist_ok=True);(private/'lz4.h').write_text(header.replace('#define LZ4_MEMORY_USAGE 14',f'#define LZ4_MEMORY_USAGE {bits}'))
  code='''
__attribute__((visibility("default"))) unsigned long n100_reuse_worksize(void) { return sizeof(LZ4_stream_t); }
__attribute__((visibility("default"))) void n100_reuse_init(void *work) { memset(work,0,sizeof(LZ4_stream_t)); }
__attribute__((visibility("default"))) int n100_reuse_compress(const char *src,char *dst,int size,int capacity,void *work)
{ if(size!=4096 || capacity<0) return 0; return LZ4_compress_default(src,dst,size,capacity,work); }
'''
  f=dest/'lz4_compress.c';f.write_text(f.read_text()+code)
  # Keep the baseline decoder; isolate compression/table-size effects.
  shutil.copy2(root/'src/kernel-lz4/lz4defs.h',dest/'baseline_defs.h')
  f=dest/'lz4_decompress.c';f.write_text(f.read_text().replace('#include "lz4defs.h"','#include "baseline_defs.h"')+'''
__attribute__((visibility("default"))) int n100_reuse_decompress(const char *src,char *dst,int size,int capacity)
{ return LZ4_decompress_safe(src,dst,size,capacity); }
''')
  subprocess.run([os.environ.get('CC','gcc'),'-O3','-g','-fPIC','-fvisibility=hidden','-fno-semantic-interposition','-fno-strict-aliasing','-fno-tree-vectorize','-Wall','-Wextra','-Wno-unused-parameter',*flags,*shlex.split(os.environ.get('EXTRA_CFLAGS','')),'-I'+str(dest/'include'),'-I'+str(root/'include'),'-shared','-Wl,-Bsymbolic-functions',str(dest/'lz4_compress.c'),str(dest/'lz4_decompress.c'),'-o',str(a.output/(name+'.so'))],check=True)
  print(name,'built',flush=True)
