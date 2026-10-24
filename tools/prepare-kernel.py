#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Prepare a namespaced optional module from the tested AVX2-guard prototype.
Run tools/build.py first. No source tree or installed module is modified.
"""
from pathlib import Path
import re,shutil
root=Path(__file__).resolve().parents[1];dest=root/'build/kernel';dest.mkdir(exist_ok=True)
for p in (root/'kernel').iterdir():
    if p.is_file():shutil.copy2(p,dest/p.name)
symbols=[]
for name in ['lz4_compress.c','lz4_decompress.c']:
    text=(root/'src/kernel-lz4'/name).read_text()
    symbols+=re.findall(r'EXPORT_SYMBOL\((\w+)\)',text)
    text=re.sub(r'EXPORT_SYMBOL\([^\n]+\);','',text)
    text=re.sub(r'MODULE_(?:LICENSE|DESCRIPTION|AUTHOR)\([^\n]*\);','',text)
    (dest/name).write_text(text.rstrip()+"\n")
(dest/'rename.h').write_text(''.join(f'#define {s} n100v_{s}\n' for s in symbols))
defs=(root/'build/avx2-guard/lz4defs.h').read_text()
defs=defs.replace('#include <immintrin.h>','typedef char n100_v32 __attribute__((vector_size(32)));')
defs=defs.replace('__m256i','n100_v32')
defs=defs.replace('_mm256_loadu_si256((const n100_v32 *)pIn)','({ n100_v32 v; __builtin_memcpy(&v,pIn,32); v; })')
defs=defs.replace('_mm256_loadu_si256((const n100_v32 *)pMatch)','({ n100_v32 v; __builtin_memcpy(&v,pMatch,32); v; })')
defs=defs.replace('_mm256_movemask_epi8(_mm256_cmpeq_epi8(a,b))','__builtin_ia32_pmovmskb256(a == b)')
defs=defs.replace('_mm256_loadu_si256((const n100_v32 *)s)','({ n100_v32 v; __builtin_memcpy(&v,s,32); v; })')
defs=defs.replace('_mm256_storeu_si256((n100_v32 *)d,v)','__builtin_memcpy(d,&v,32)')
defs=defs.replace('(uintptr_t)','(unsigned long)')
assert '_mm256' not in defs
(dest/'lz4defs.h').write_text(defs)
print(dest)
