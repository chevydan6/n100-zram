#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Prepare the measured cutoff-2/grouped SIMD codec with a scalar dispatcher.

Generation only. Validate the generated userspace codec before kernel builds.
Vector trial and decode objects are separate from the dispatcher and private
LZ4 fallback. No kernel loading, registration or performance claim is made.
"""
import argparse
import hashlib
import json
import re
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--checkpoint', type=Path, required=True)
p.add_argument('--scalar-port', type=Path, required=True)
p.add_argument('--output', type=Path, required=True)
a = p.parse_args()
assert not a.output.exists()
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
manifest = json.loads((a.checkpoint / 'manifest.json').read_text())
source_root = a.checkpoint / 'source-checkpoint'
for name in ['gzram/src/gzram.c', 'gzram/src/gzram.h', 'gzram/src/hybrid.c']:
    assert sha(source_root / name) == manifest['source_sha256'][name], name
assert sha(a.checkpoint / 'tables.h') == manifest['generated_tables_sha256']
scalar_manifest = json.loads((a.scalar_port / 'manifest.json').read_text())
assert scalar_manifest['policy'].startswith('bitdirect scalar guard;')
for name, digest in scalar_manifest['generated_sha256'].items():
    assert sha(a.scalar_port / name) == digest, name
record = dict(scope='Unbuilt guarded SIMD GHY1 prototype; no execution or performance claim',
              checkpoint_manifest_sha256=sha(a.checkpoint / 'manifest.json'),
              scalar_manifest_sha256=sha(a.scalar_port / 'manifest.json'),
              generator_sha256=sha(Path(__file__)), transformations=[])
a.output.mkdir(parents=True)
def write(name, text):
    target = a.output / name
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(text)
def replace_one(s, old, new):
    assert s.count(old) == 1, old
    return s.replace(old, new)
def function_span(s, name):
    pattern = (r'^(?:__attribute__\(\([^\n]*\)\)\s+)?(?:AVX\s+)?(?:static\s+)?'
               r'(?:int|void|unsigned|size_t)\s+' + re.escape(name) + r'\([^)]*\)\s*\{')
    matches = list(re.finditer(pattern, s, re.M)); assert len(matches) == 1, name
    start, body = matches[0].start(), matches[0].end() - 1
    depth = 0
    for token in re.finditer(r'//[^\n]*|/\*.*?\*/|"(?:\\.|[^"\\])*"|\x27(?:\\.|[^\x27\\])*\x27|[{}]', s[body:], re.S):
        if token[0] == '{': depth += 1
        elif token[0] == '}':
            depth -= 1
            if depth == 0: return start, body + token.end()
    raise AssertionError(name)
compat = '''#ifdef __KERNEL__
#include <linux/types.h>
#include <linux/string.h>
#define UINT64_C(value) value##ULL
#else
#include <stdint.h>
#include <string.h>
#endif'''
vector_header = '''#ifdef __KERNEL__
#ifndef _LINUX_FPU_COMPILATION_UNIT
#error Vector objects require the kernel FPU compilation flags
#endif
/* Intrinsics only; do not import GCC's userspace allocation helpers. */
#define _MM_MALLOC_H_INCLUDED
#endif
#include <immintrin.h>'''
# Preserve the previously validated scalar fallback and private LZ4 bodies.
for name in scalar_manifest['generated_sha256']:
    if name == 'userspace-adapter.c': continue
    text = (a.scalar_port / name).read_text()
    text = text.replace('__attribute__((noinline))', '__attribute__((__noinline__))')
    write('scalar/' + name, text)
core = (source_root / 'gzram/src/gzram.c').read_text()
header = (source_root / 'gzram/src/gzram.h').read_text()
header = replace_one(header, '#include <stddef.h>', '#ifdef __KERNEL__\n#include <linux/types.h>\n#else\n#include <stddef.h>\n#endif')
for role, key in [('encoder', 'block2avxbits4base'), ('decoder', 'ctz')]:
    flags = [flag[2:].split('=', 1) for flag in manifest['candidate_extra_flags']['core_objects'][key]
             if flag.startswith('-DGZRAM_')]
    text = replace_one(core, '#include <stdint.h>\n#include <string.h>', compat)
    text = replace_one(text, '#include <immintrin.h>', vector_header)
    start, end = function_span(text, 'gzram_avx2_available')
    # Only internal vector objects get unconditional availability. The scalar
    # dispatcher must have established CPU/OS support and entered kernel FPU.
    text = text[:start] + 'int gzram_avx2_available(void) { return 1; }' + text[end:]
    h = header
    for symbol in ['encode_scalar', 'decode_scalar', 'encode_avx2', 'decode_avx2', 'decode_mixed', 'encode_hint_avx2', 'avx2_available']:
        old = 'gzram_' + symbol; new = 'n100_vector_' + role + '_' + symbol
        text = re.sub(r'\b' + old + r'\b', new, text)
        h = re.sub(r'\b' + old + r'\b', new, h)
    text = ''.join('#define ' + name + ' ' + value + '\n' for name, value in flags) + text
    write('vector-' + role + '/core.c', text)
    write('vector-' + role + '/gzram.h', h)
    write('vector-' + role + '/tables.h', (a.checkpoint / 'tables.h').read_text())
# Retain the measured hybrid selection and accepted-frame path. Split before
# the scalar fallback, so rejected pages do not run LZ4 inside kernel FPU state.
source = (source_root / 'gzram/src/hybrid.c').read_text()
start, end = function_span(source, 'lz4_encode')
source = source[:start] + source[end:]
cut = source.index(' size_t room=cap-HEADER;')
fallback = source[cut:source.index('\n#if defined(GZRAM_HYBRID_DIRECT_REPEAT)', cut)]
assert fallback.endswith('\n}')
fallback += '\n'
source = source[:cut] + ' return 0;\n}\n'
source = replace_one(source, '#define _GNU_SOURCE\n', '')
source = replace_one(source, '#include "gzram.h"', '#include "vector-encoder/gzram.h"')
source = replace_one(source, '#include <linux/lz4.h>', '#include "scalar/private-lz4.h"')
source = replace_one(source, '#include <stdint.h>\n#include <string.h>', compat)
source = replace_one(source, '#include <immintrin.h>', vector_header)
source = source.replace('__attribute__((noinline))', '__attribute__((__noinline__))')
source = re.sub(r'\bgzram_base_encode_avx2\b', 'n100_vector_encoder_encode_avx2', source)
source = re.sub(r'\bgzram_avx2_available\b', 'n100_vector_encoder_avx2_available', source)
flags = ['GZRAM_HYBRID_GUARD 32', 'GZRAM_HYBRID_WORD_SCALAR 1',
         'GZRAM_HYBRID_CTZ_DECODE 1', 'GZRAM_HYBRID_MERGE_REPEAT 1',
         'GZRAM_HYBRID_MERGE_REPEAT_FAST 1']
source = ''.join('#define ' + flag + '\n' for flag in flags) + source
source += '''int n100_vector_trial(const void *s,size_t n,void *d,size_t cap,unsigned log)
{ return encode(s,n,d,cap,log,n100_vector_encoder_encode_avx2); }
'''
write('vector-trial.c', source)
fallback = fallback.replace('lz4_encode(src,dst+HEADER,(int)n,(int)room)',
                            'n100_private_lz4_compress_default((const char *)src,(char *)dst+HEADER,(int)n,(int)room,work)')
assert 'lz4_encode(' not in fallback
write('fallback.c', '''/* SPDX-License-Identifier: GPL-2.0-only */
#include "scalar/private-lz4.h"
''' + compat + '''
#define PAGE 4096
#define HEADER 8
static void header(uint8_t *dst,size_t n,unsigned mode)
{ memcpy(dst,"GHY1",4);dst[4]=(uint8_t)n;dst[5]=(uint8_t)(n>>8);dst[6]=(uint8_t)mode;dst[7]=0; }
/* Called only after dispatcher validation, outside the FPU critical section. */
int n100_lz4_fallback(const void *input,size_t n,void *output,size_t cap,void *work)
{
 const uint8_t *src=input;uint8_t *dst=output;
''' + fallback)
write('simd.h', '''/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_GHY_SIMD_PORT_H
#define N100_GHY_SIMD_PORT_H
#include "scalar/ghy_scalar.h"
/* Same bounds/workspace contract as scalar; pages remain independent.
 * The kernel dispatcher owns FPU entry/exit. Do not call from an FPU section. */
int n100_simd_available(void);
int n100_simd_encode(const void *,size_t,void *,size_t,unsigned,void *,size_t);
int n100_simd_decode(const void *,size_t,void *,size_t);
#endif
''')
write('dispatch.c', '''/* SPDX-License-Identifier: GPL-2.0-only */
#include "simd.h"
#include "scalar/private-lz4.h"
''' + compat + '''
#ifdef __KERNEL__
#include <asm/cpufeature.h>
#include <asm/fpu/api.h>
#include <asm/fpu/types.h>
int n100_simd_available(void)
{ return boot_cpu_has(X86_FEATURE_AVX2) && cpu_has_xfeatures(XFEATURE_MASK_SSE|XFEATURE_MASK_YMM,0); }
static int usable(void) { return n100_simd_available() && irq_fpu_usable(); }
#define begin_vector() kernel_fpu_begin()
#define end_vector() kernel_fpu_end()
#else
int n100_simd_available(void) {
#ifdef N100_TEST_FORCE_SCALAR
 return 0;
#else
 return !!__builtin_cpu_supports("avx2");
#endif
}
static int usable(void) { return n100_simd_available(); }
#define begin_vector() ((void)0)
#define end_vector() ((void)0)
#endif
int n100_vector_trial(const void *,size_t,void *,size_t,unsigned);
int n100_vector_decoder_decode_mixed(const void *,size_t,void *,size_t);
int n100_lz4_fallback(const void *,size_t,void *,size_t,void *);
int n100_simd_encode(const void *src,size_t n,void *dst,size_t cap,unsigned log,
                     void *work,size_t work_bytes)
{
 if(!work||work_bytes<n100_ghy_workspace_size()||
    (uintptr_t)work%n100_ghy_workspace_alignment())return 0;
 if(n>4096||log<5||log>12||!dst||(!src&&n)||cap<8)return 0;
 if(!n||!usable())return n100_ghy_encode(src,n,dst,cap,log,work,work_bytes);
 begin_vector();
 int got=n100_vector_trial(src,n,dst,cap,log);
 end_vector();
 return got?got:n100_lz4_fallback(src,n,dst,cap,work);
}
int n100_simd_decode(const void *input,size_t size,void *dst,size_t cap)
{
 if(!input||size<8||size>LZ4_COMPRESSBOUND(4096)+8)return -1;
 const uint8_t *src=input;
 if(memcmp(src,"GHY1",4)||src[6]>2||src[7])return -1;
 size_t n=(size_t)src[4]+((size_t)src[5]<<8);
 if(n>4096||n>cap||(!dst&&n))return -1;
 if(src[6]!=1||!usable())return n100_ghy_decode(src,size,dst,cap);
 if(!n)return -1;
 begin_vector();
 int got=n100_vector_decoder_decode_mixed(src+8,size-8,dst,n);
 end_vector();
 return got==(int)n?got:-1;
}
''')
write('userspace-adapter.c', '''/* SPDX-License-Identifier: GPL-2.0-only */
#ifdef __KERNEL__
#error Userspace test adapter is not a kernel API
#endif
#include "simd.h"
#include "scalar/private-lz4.h"
static _Thread_local n100_private_lz4_stream_t work;
int gzram_avx2_available(void) { return n100_simd_available(); }
int gzram_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log)
{ return n100_ghy_encode(s,n,d,cap,log,&work,sizeof(work)); }
int gzram_encode_avx2(const void *s,size_t n,void *d,size_t cap,unsigned log)
{ return n100_simd_encode(s,n,d,cap,log,&work,sizeof(work)); }
int gzram_decode_scalar(const void *s,size_t n,void *d,size_t cap)
{ return n100_ghy_decode(s,n,d,cap); }
int gzram_decode_avx2(const void *s,size_t n,void *d,size_t cap)
{ return n100_simd_decode(s,n,d,cap); }
''')
record['transformations'] = ['Verified immutable V8 source and table hashes',
 'Separate namespaced core objects with measured encoder/decoder flags',
 'Internal vector availability constant; public scalar dispatch checks CPU/OS/context',
 'Preserved hybrid acceptance body; extracted LZ4/raw fallback outside FPU section',
 'Preserved validated scalar port, reserved noinline spelling for kernel compatibility',
 'No GHY1/GZR1 format change intended; byte identity and all validation still required']
record['generated_sha256'] = {str(p.relative_to(a.output)):sha(p) for p in sorted(a.output.rglob('*')) if p.is_file()}
write('manifest.json',json.dumps(record,indent=2)+'\n')
print(a.output)
