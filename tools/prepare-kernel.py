#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Prepare a namespaced optional module from the tested AVX2-guard prototype.
Run tools/build.py first. No source tree or installed module is modified.
"""
from pathlib import Path
import argparse,json,re,shutil
from codec_experiments import add_runfill,add_rep8,add_matchrep8,add_branchrep8
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--variant',choices=['avx2-guard','sse-guard','scalar-control','scalar-fpu','scalar-runfill','scalar-rep8','scalar-matchrep8','scalar-selectrep8','scalar-branchrep8'],default='avx2-guard')
p.add_argument('--output',type=Path,default=root/'build/kernel')
a=p.parse_args();dest=a.output;dest.mkdir(parents=True,exist_ok=True)
for p in (root/'kernel').iterdir():
    if p.is_file():shutil.copy2(p,dest/p.name)
symbols=[]
for name in ['lz4_compress.c','lz4_decompress.c']:
    text=(root/'src/kernel-lz4'/name).read_text()
    if a.variant=='scalar-branchrep8' and name=='lz4_decompress.c':text=add_branchrep8(text)
    if a.variant in ['scalar-matchrep8','scalar-selectrep8','scalar-branchrep8'] and name=='lz4_decompress.c':text=add_matchrep8(text)
    if a.variant=='scalar-runfill' and name=='lz4_decompress.c':text=add_runfill(text)
    symbols+=re.findall(r'EXPORT_SYMBOL\((\w+)\)',text)
    text=re.sub(r'EXPORT_SYMBOL\([^\n]+\);','',text)
    text=re.sub(r'MODULE_(?:LICENSE|DESCRIPTION|AUTHOR)\([^\n]*\);','',text)
    (dest/name).write_text(text.rstrip()+"\n")
(dest/'rename.h').write_text(''.join(f'#define {s} n100v_{s}\n' for s in symbols))
source='scalar' if a.variant.startswith('scalar-') else a.variant
defs=(root/'build'/source/'lz4defs.h').read_text()
if a.variant=='scalar-rep8':defs=add_rep8(defs)
if a.variant=='avx2-guard':
    defs=defs.replace('#include <immintrin.h>','typedef char n100_v32 __attribute__((vector_size(32)));')
defs=defs.replace('__m256i','n100_v32')
defs=defs.replace('_mm256_loadu_si256((const n100_v32 *)pIn)','({ n100_v32 v; __builtin_memcpy(&v,pIn,32); v; })')
defs=defs.replace('_mm256_loadu_si256((const n100_v32 *)pMatch)','({ n100_v32 v; __builtin_memcpy(&v,pMatch,32); v; })')
defs=defs.replace('_mm256_movemask_epi8(_mm256_cmpeq_epi8(a,b))','__builtin_ia32_pmovmskb256(a == b)')
defs=defs.replace('_mm256_loadu_si256((const n100_v32 *)s)','({ n100_v32 v; __builtin_memcpy(&v,s,32); v; })')
defs=defs.replace('_mm256_storeu_si256((n100_v32 *)d,v)','__builtin_memcpy(d,&v,32)')
defs=defs.replace('(uintptr_t)','(unsigned long)')
assert '_mm256' not in defs
if a.variant=='sse-guard':
    defs=defs.replace('#include <immintrin.h>','typedef char n100_v16 __attribute__((vector_size(16)));')
    defs=defs.replace('__m128i','n100_v16')
    for pointer in ['pIn','pMatch','s']:
        defs=defs.replace(f'_mm_loadu_si128((const n100_v16 *){pointer})',f'({{ n100_v16 v; __builtin_memcpy(&v,{pointer},16); v; }})')
    defs=defs.replace('_mm_movemask_epi8(_mm_cmpeq_epi8(a,b))','__builtin_ia32_pmovmskb128(a == b)')
    defs=defs.replace('_mm_storeu_si128((n100_v16 *)d,v)','__builtin_memcpy(d,&v,16)')
assert '_mm' not in defs
(dest/'lz4defs.h').write_text(defs)
make=(dest/'Makefile').read_text()
flags='-msse2 -mno-avx' if a.variant=='sse-guard' else '-mno-sse -mno-mmx -mno-avx' if a.variant.startswith('scalar-') else '-mavx2'
(dest/'Makefile').write_text(make.replace('-mavx2',flags))
if a.variant in ['scalar-control','scalar-runfill','scalar-rep8','scalar-matchrep8','scalar-selectrep8','scalar-branchrep8']:
    dispatch=(dest/'dispatch.c').read_text().replace(' kernel_fpu_begin();','').replace(' kernel_fpu_end();','')
    (dest/'dispatch.c').write_text(dispatch)
if a.variant=='scalar-selectrep8':
    dispatch=(dest/'dispatch.c').read_text()
    dispatch=dispatch[:dispatch.index('int n100_lz4_compress(')]+"""
#include "select.h"
int n100_lz4_compress(const char *src,char *dst,int size,int capacity,void *work)
{
 return LZ4_compress_default(src,dst,size,capacity,work);
}
EXPORT_SYMBOL_GPL(n100_lz4_compress);
int n100_lz4_decompress(const char *src,char *dst,int size,int capacity)
{
 if (capacity == 4096 && n100_first_long_period(src,size))
  return n100v_LZ4_decompress_safe(src,dst,size,capacity);
 return LZ4_decompress_safe(src,dst,size,capacity);
}
EXPORT_SYMBOL_GPL(n100_lz4_decompress);
"""
    (dest/'dispatch.c').write_text(dispatch)
(dest/'experiment.json').write_text(json.dumps({'variant':a.variant,'fpu_bracket':a.variant not in ['scalar-control','scalar-runfill','scalar-rep8','scalar-matchrep8','scalar-selectrep8','scalar-branchrep8'],'purpose':'diagnostic probe; optional ZRAM patch remains AVX2-guard'},indent=2)+'\n')
print(dest)
