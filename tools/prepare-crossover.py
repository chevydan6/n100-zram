#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Build independent scalar/SSE2/AVX2 codecs with identical hash-table size."""
import argparse,os,shutil,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--bits',type=int,choices=[12,14],default=12);p.add_argument('--output',type=Path,default=root/'build/crossover');a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
for name,base,flags in [('scalar','scalar',['-mno-sse','-mno-mmx','-mno-avx']),('sse','sse-guard',['-msse2','-mno-avx']),('avx2','avx2-guard',['-mavx2'])]:
 dest=a.output/name;dest.mkdir(exist_ok=True)
 for filename in ['lz4_compress.c','lz4_decompress.c','lz4defs.h']:shutil.copy2(root/'build'/base/filename,dest/filename)
 private=dest/'include/linux';private.mkdir(parents=True,exist_ok=True);s=(root/'include/linux/lz4.h').read_text();assert s.count('#define LZ4_MEMORY_USAGE 14')==1;(private/'lz4.h').write_text(s.replace('#define LZ4_MEMORY_USAGE 14',f'#define LZ4_MEMORY_USAGE {a.bits}'))
 subprocess.run([os.environ.get('CC','gcc'),'-O3','-g','-fPIC','-fno-tree-vectorize','-fno-strict-aliasing','-Wall','-Wextra',*flags,'-I'+str(dest/'include'),'-I'+str(root/'include'),'-shared','-Wl,-Bsymbolic-functions',str(dest/'lz4_compress.c'),str(dest/'lz4_decompress.c'),'-o',str(a.output/(name+'.so'))],check=True)
 print(name,'built',flush=True)
