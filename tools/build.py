#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Generate isolated variants; never modify the reference kernel sources."""
from pathlib import Path
import subprocess, shutil, os, shlex
from codec_experiments import add_runfill,add_rep8,add_matchrep8,add_branchrep8
root=Path(__file__).resolve().parents[1]
out=Path(os.environ.get('BUILD_ROOT',root/'build')); out.mkdir(parents=True,exist_ok=True)
for name,width,copy in [('scalar',0,False),('scalar-runfill',0,False),('scalar-rep8',0,False),('scalar-matchrep8',0,False),('scalar-branchrep8',0,False),('sse',16,True),('avx2',32,True),('avx2-count',32,False),('avx2-guard',32,True),('sse-guard',16,True),('avx2-copy',32,True),('avx2-guard16',32,True),('avx2-guard32',32,True),('scalar-unroll',0,False),('scalar-gracemont',0,False),('avx2-guard-gracemont',32,True),('avx2-guard16-gracemont',32,True),('sse-guard-gracemont',16,True),('avx2-guard-overlap',32,True),('avx2-copy-overlap',32,True)]:
    dest=out/name; dest.mkdir(exist_ok=True)
    for f in (root/'src/kernel-lz4').iterdir(): shutil.copy2(f,dest/f.name)
    if name=='scalar-runfill':
        p=dest/'lz4_decompress.c';p.write_text(add_runfill(p.read_text()))
    if name=='scalar-matchrep8':
        p=dest/'lz4_decompress.c';p.write_text(add_matchrep8(p.read_text()))
    if name=='scalar-branchrep8':
        p=dest/'lz4_decompress.c';p.write_text(add_branchrep8(p.read_text()))
    defs=(dest/'lz4defs.h').read_text()
    if name=='scalar-rep8':defs=add_rep8(defs)
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
        if '-guard' in name:
            code = '''
    if (pInLimit - pIn >= 8) {
        size_t diff = LZ4_read_ARCH(pMatch) ^ LZ4_read_ARCH(pIn);
        if (diff) return (unsigned)(pIn-pStart) + LZ4_NbCommonBytes(diff);
        pIn += 8; pMatch += 8;
    }
''' * (4 if 'guard32' in name else 2 if 'guard16' in name else 1) + code
        if not name.startswith('avx2-copy'):
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
            if 'overlap' in name:
                code += """
    else if (e-d >= 32 && ((uintptr_t)d-(uintptr_t)s == 8 ||
                          (uintptr_t)d-(uintptr_t)s == 16)) {
        /* A complete period is initialized behind d. Reuse it only when
         * the period divides 32, so every vector starts at the same phase. */
        __m256i repeated;
        if ((uintptr_t)d-(uintptr_t)s == 8)
            repeated=_mm256_set1_epi64x((long long)LZ4_read_ARCH(s));
        else
            repeated=_mm256_broadcastsi128_si256(_mm_loadu_si128((const __m128i *)s));
        do {
            _mm256_storeu_si256((__m256i *)d,repeated);
            d+=32;s+=32;
        } while (e-d >= 32);
        if (d==e) return;
    }
"""
            defs=defs.replace('BYTE *const e = (BYTE *)dstEnd;','BYTE *const e = (BYTE *)dstEnd;\n'+code)
    if name == 'scalar-unroll':
        code='''
    while (pInLimit-pIn >= 32) {
        size_t a=LZ4_read_ARCH(pIn)^LZ4_read_ARCH(pMatch);
        size_t b=LZ4_read_ARCH(pIn+8)^LZ4_read_ARCH(pMatch+8);
        size_t c=LZ4_read_ARCH(pIn+16)^LZ4_read_ARCH(pMatch+16);
        size_t d=LZ4_read_ARCH(pIn+24)^LZ4_read_ARCH(pMatch+24);
        if (a|b|c|d) {
            if (a) return (unsigned)(pIn-pStart)+LZ4_NbCommonBytes(a);
            if (b) return (unsigned)(pIn-pStart)+8+LZ4_NbCommonBytes(b);
            if (c) return (unsigned)(pIn-pStart)+16+LZ4_NbCommonBytes(c);
            return (unsigned)(pIn-pStart)+24+LZ4_NbCommonBytes(d);
        }
        pIn+=32;pMatch+=32;
    }
'''
        defs=defs.replace('const BYTE *const pStart = pIn;','const BYTE *const pStart = pIn;\n'+code)
    (dest/'lz4defs.h').write_text(defs)
    flags=['-msse2','-mno-avx'] if width==16 else ['-mavx2'] if width else ['-mno-sse','-mno-mmx','-mno-avx']
    if name.endswith('-gracemont'): flags+=['-mtune=gracemont']
    cmd=[os.environ.get('CC','gcc'),'-O3','-g','-fPIC','-fno-tree-vectorize','-Wall','-Wextra','-Wno-unused-parameter',*flags,*shlex.split(os.environ.get('EXTRA_CFLAGS','')),'-I'+str(root/'include'),'-shared','-Wl,-Bsymbolic-functions',str(dest/'lz4_compress.c'),str(dest/'lz4_decompress.c'),'-o',str(out/(name+'.so'))]
    subprocess.run(cmd,check=True)
    print(name, 'built', flush=True)
