#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Generate isolated variants; never modify the reference kernel sources."""
from pathlib import Path
import subprocess, shutil, os, shlex
root=Path(__file__).resolve().parents[1]
out=Path(os.environ.get('BUILD_ROOT',root/'build')); out.mkdir(parents=True,exist_ok=True)
for name,width,copy in [('scalar',0,False),('sse',16,True),('avx2',32,True),('avx2-count',32,False),('avx2-guard',32,True),('sse-guard',16,True),('avx2-copy',32,True)]:
    dest=out/name; dest.mkdir(exist_ok=True)
    for f in (root/'src/kernel-lz4').iterdir(): shutil.copy2(f,dest/f.name)
    defs=(dest/'lz4defs.h').read_text()
    if width:
        defs='#include <immintrin.h>\n'+defs
        typ='__m128i' if width==16 else '__m256i'
        pref='_mm' if width==16 else '_mm256'
        mask='0xffffU' if width==16 else '0xffffffffU'
        code=f"""
    /* Only read complete vectors within the input limit. */
    while (pInLimit - pIn >= {width}) {{
        {typ} a = {pref}_loadu_si{128 if width==16 else 256}((const {typ} *)pIn);
        {typ} b = {pref}_loadu_si{128 if width==16 else 256}((const {typ} *)pMatch);
        unsigned equal = (unsigned){pref}_movemask_epi8({pref}_cmpeq_epi8(a,b));
        if (equal != {mask})
            return (unsigned)(pIn-pStart) + __builtin_ctz((~equal) & {mask});
        pIn += {width}; pMatch += {width};
    }}
"""
        if name.endswith('-guard'):
            code = '''
    if (pInLimit - pIn >= 8) {
        size_t diff = LZ4_read_ARCH(pMatch) ^ LZ4_read_ARCH(pIn);
        if (diff) return LZ4_NbCommonBytes(diff);
        pIn += 8; pMatch += 8;
    }
''' + code
        if name != 'avx2-copy':
            defs=defs.replace('const BYTE *const pStart = pIn;','const BYTE *const pStart = pIn;\n'+code)
        if copy:
            code=f"""
    /* Retain the original <=7-byte wild-copy overrun contract.
     * Short overlapping matches must keep sequential 8-byte expansion. */
    if ((uintptr_t)d - (uintptr_t)s >= {width}) {{
        while (e - d >= {width}) {{
            {typ} v = {pref}_loadu_si{128 if width==16 else 256}((const {typ} *)s);
            {pref}_storeu_si{128 if width==16 else 256}(({typ} *)d,v);
            d += {width}; s += {width};
        }}
        if (d == e) return;
    }}
"""
            defs=defs.replace('BYTE *const e = (BYTE *)dstEnd;','BYTE *const e = (BYTE *)dstEnd;\n'+code)
    (dest/'lz4defs.h').write_text(defs)
    flags=['-msse2','-mno-avx'] if width==16 else ['-mavx2'] if width else ['-mno-sse','-mno-mmx','-mno-avx']
    cmd=[os.environ.get('CC','gcc'),'-O3','-g','-fPIC','-fno-tree-vectorize','-Wall','-Wextra','-Wno-unused-parameter',*flags,*shlex.split(os.environ.get('EXTRA_CFLAGS','')),'-I'+str(root/'include'),'-shared','-Wl,-Bsymbolic-functions',str(dest/'lz4_compress.c'),str(dest/'lz4_decompress.c'),'-o',str(out/(name+'.so'))]
    subprocess.run(cmd,check=True)
    print(name, 'built', flush=True)
