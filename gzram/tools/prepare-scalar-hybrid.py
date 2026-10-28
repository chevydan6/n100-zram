#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Prepare a scalar GHY1 prototype with explicit, caller-owned LZ4 workspace.

No build, installation or module loading. Inputs are separately validated scalar
GZR1 ports; manifest hashes prove identity, not validation. The generated test
adapter uses thread-local workspace. Kernel callers use the explicit API.
"""
import argparse
import hashlib
import json
import re
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--encoder-core', type=Path, required=True)
p.add_argument('--decoder-core', type=Path, required=True)
p.add_argument('--output', type=Path, required=True)
a = p.parse_args()
root = Path(__file__).resolve().parents[2]
assert not a.output.exists()
a.output.mkdir(parents=True)
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
record = {'scope': 'Unbuilt scalar GHY1 workspace prototype; no performance or kernel execution claim', 'core_inputs': {}}
for label, source in [('encoder', a.encoder_core), ('decoder', a.decoder_core)]:
    manifest = json.loads((source / 'manifest.json').read_text())
    assert manifest['prefix'] == 'gzram'
    for name, digest in manifest['generated_sha256'].items():
        assert sha(source / name) == digest, (label, name)
    record['core_inputs'][label] = manifest
    destination = a.output / label
    destination.mkdir()
    for name in ['core.c', 'gzram.h', 'tables.h']:
        text = (source / name).read_text()
        for symbol in ['encode_scalar', 'decode_scalar', 'encode_avx2', 'decode_avx2', 'avx2_available']:
            text = re.sub(r'\bgzram_' + symbol + r'\b', 'n100_' + label + '_' + symbol, text)
        (destination / name).write_text(text)

source_paths = ['gzram/src/hybrid.c', 'src/kernel-lz4/lz4_compress.c',
                'src/kernel-lz4/lz4_decompress.c', 'src/kernel-lz4/lz4defs.h',
                'include/linux/lz4.h', 'gzram/tools/prepare-scalar-hybrid.py']
record['source_sha256'] = {name: sha(root / name) for name in source_paths}
source = (root / 'gzram/src/hybrid.c').read_text()

def replace_once(old, new):
    global source
    assert source.count(old) == 1, old
    source = source.replace(old, new)

replace_once('#define _GNU_SOURCE\n', '')
replace_once('#include "gzram.h"', '#include "ghy_scalar.h"')
replace_once('#include <linux/lz4.h>', '#include "private-lz4.h"')
replace_once('#include <stdint.h>\n#include <string.h>', '''#ifdef __KERNEL__
#include <linux/types.h>
#include <linux/string.h>
#define UINT64_C(value) value##ULL
#else
#include <stdint.h>
#include <string.h>
#endif''')
replace_once('#include <immintrin.h>\n', '')
replace_once('/* Keep the 4 KiB compression workspace off the accepted GZRAM call path.\n * Userspace stack workspace; any kernel port would need per-stream storage. */',
             '/* Caller-owned private LZ4 state: never placed on the kernel stack. */')
replace_once('static int lz4_encode(const void *src,void *dst,int n,int cap)',
             'static int lz4_encode(const void *src,void *dst,int n,int cap,void *work)')
replace_once(' LZ4_stream_t work;\n return LZ4_compress_default(src,dst,n,cap,&work);',
             ' return LZ4_compress_default(src,dst,n,cap,work);')
replace_once('unsigned log,encode_fn gz)\n{', 'unsigned log,encode_fn gz,void *work)\n{')
replace_once('int packed=lz4_encode(src,dst+HEADER,(int)n,(int)room);',
             'int packed=lz4_encode(src,dst+HEADER,(int)n,(int)room,work);')
# Replace only the public adapters. The guarded scalar classifier and container
# algorithms above them remain sourced from the existing implementation.
start = source.index('\nint gzram_encode_scalar(')
assert source[start:].count('\nint ') == 4
source = source[:start] + '''
size_t n100_ghy_workspace_size(void) { return sizeof(LZ4_stream_t); }
size_t n100_ghy_workspace_alignment(void) { return _Alignof(LZ4_stream_t); }
int n100_ghy_encode(const void *src,size_t n,void *dst,size_t cap,unsigned log,
                    void *work,size_t work_bytes)
{
 if(!work||work_bytes<sizeof(LZ4_stream_t)||
    (uintptr_t)work%_Alignof(LZ4_stream_t))return 0;
 return encode(src,n,dst,cap,log,gzram_base_encode_scalar,work);
}
int n100_ghy_decode(const void *src,size_t n,void *dst,size_t cap)
{ return decode(src,n,dst,cap,gzram_base_decode_scalar); }
'''
source = source.replace('gzram_base_encode_scalar', 'n100_encoder_encode_scalar')
source = source.replace('gzram_base_decode_scalar', 'n100_decoder_decode_scalar')
# Guard=8 chooses the exact integer prefix search used by wordmixed's scalar
# entry. No vector classifier, CPU dispatch or alternate policy is compiled.
policy_flags = sorted(set(re.findall(r'GZRAM_HYBRID_[A-Z_]+', source)))
source = ('/* SPDX-License-Identifier: GPL-2.0-only */\n'
          '#if ' + ' || '.join('defined(' + flag + ')' for flag in policy_flags) +
          '\n#error Unexpected scalar hybrid policy override\n#endif\n'
          '#define GZRAM_HYBRID_GUARD 8\n#define GZRAM_HYBRID_WORD_SCALAR 1\n' + source)

# All LZ4 function/type identifiers are private; no symbol exports survive.
# The algorithm bodies and attribution remain from the matched LZ4 control.
def private_names(text):
    return re.sub(r'\bLZ4_([a-z][A-Za-z0-9_]*)\b', r'n100_private_lz4_\1', text)

(a.output / 'hybrid.c').write_text(private_names(source))
for name in ['lz4_compress.c', 'lz4_decompress.c', 'lz4defs.h']:
    text = (root / 'src/kernel-lz4' / name).read_text()
    text = text.replace('#include <linux/lz4.h>', '#include "private-lz4.h"')
    text = re.sub(r'^EXPORT_SYMBOL\([^\n]*\);\n', '', text, flags=re.M)
    text = re.sub(r'^MODULE_(?:LICENSE|DESCRIPTION)\([^\n]*\);\n', '', text, flags=re.M)
    (a.output / name).write_text(private_names(text))
header = (root / 'include/linux/lz4.h').read_text()
assert header.count('#define LZ4_MEMORY_USAGE 14') == 1
header = header.replace('#define LZ4_MEMORY_USAGE 14', '#define LZ4_MEMORY_USAGE 12')
header = header.replace('__LZ4_H__', '__N100_GHY_PRIVATE_LZ4_H__')
(a.output / 'private-lz4.h').write_text(private_names(header))
(a.output / 'ghy_scalar.h').write_text('''/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_GHY_SCALAR_PORT_H
#define N100_GHY_SCALAR_PORT_H
#ifdef __KERNEL__
#include <linux/types.h>
#else
#include <stddef.h>
#endif
/* Nonoverlapping buffers. Input <=4096; log=5..12. Encode returns bytes or 0;
 * decode returns bytes or -1 and may modify a bounded prefix on failure.
 * Each concurrent encode requires its own aligned workspace; its contents are
 * reset by LZ4 when used. No cross-page dictionary or mutable shared state. */
size_t n100_ghy_workspace_size(void);
size_t n100_ghy_workspace_alignment(void);
int n100_ghy_encode(const void *,size_t,void *,size_t,unsigned,void *,size_t);
int n100_ghy_decode(const void *,size_t,void *,size_t);
#endif
''')
(a.output / 'userspace-adapter.c').write_text('''/* SPDX-License-Identifier: GPL-2.0-only */
/* Test compatibility adapter only; never include in a kernel build. */
#ifdef __KERNEL__
#error Userspace test adapter is not a kernel API
#endif
#include "ghy_scalar.h"
#include "private-lz4.h"
static _Thread_local n100_private_lz4_stream_t work;
int gzram_avx2_available(void) { return 0; }
int gzram_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log)
{ return n100_ghy_encode(s,n,d,cap,log,&work,sizeof(work)); }
int gzram_encode_avx2(const void *s,size_t n,void *d,size_t cap,unsigned log)
{ return gzram_encode_scalar(s,n,d,cap,log); }
int gzram_decode_scalar(const void *s,size_t n,void *d,size_t cap)
{ return n100_ghy_decode(s,n,d,cap); }
int gzram_decode_avx2(const void *s,size_t n,void *d,size_t cap)
{ return n100_ghy_decode(s,n,d,cap); }
''')
record['generated_sha256'] = {str(path.relative_to(a.output)): sha(path)
                              for path in sorted(a.output.rglob('*')) if path.is_file()}
record['policy'] = 'wordmixed scalar guard; separate encoder/decoder objects; explicit private LZ4 workspace'
(a.output / 'manifest.json').write_text(json.dumps(record, indent=2) + '\n')
print(a.output)
