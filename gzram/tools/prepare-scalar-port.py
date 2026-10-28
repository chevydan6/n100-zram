#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Prepare an isolated scalar GZR1 component for userspace and kernel checks.

This does not build, load, register, or install a kernel codec. It is not the
GHY1/LZ4 container. The scalar scan/pack/unpack/repeat bodies are retained from
the measured source; SIMD helpers and dispatch are removed explicitly. Generated
userspace builds must pass guard/oracle/sanitizer checks before a kernel build.
"""
import argparse
import hashlib
import json
import re
from pathlib import Path

root = Path(__file__).resolve().parents[2]
p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--output', type=Path, required=True)
p.add_argument('--prefix', default='gzram')
p.add_argument('--unpack', choices=['reference', 'ctz'], default='reference')
p.add_argument('--repeat', choices=['reference', 'word'], default='reference')
p.add_argument('--pack', choices=['reference', 'ctz'], default='reference')
a = p.parse_args()
assert re.fullmatch(r'[A-Za-z_][A-Za-z_0-9]*', a.prefix)
assert not a.output.exists()
source = (root / 'gzram/src/gzram.c').read_text()
header = (root / 'gzram/src/gzram.h').read_text()


def replace_function(text, name, replacement=''):
    pattern = rf'^(?:AVX\s+)?(?:static\s+)?(?:int|void|unsigned|size_t)\s+{re.escape(name)}\([^)]*\)\s*\{{'
    matches = list(re.finditer(pattern, text, re.M))
    assert len(matches) == 1, (name, len(matches))
    begin = matches[0].start()
    body = matches[0].end() - 1
    # Ignore braces in strings/comments. Fail closed if the source shape changes.
    tokens = re.finditer(r'//[^\n]*|/\*.*?\*/|"(?:\\.|[^"\\])*"|\x27(?:\\.|[^\x27\\])*\x27|[{}]', text[body:], re.S)
    depth = 0
    for token in tokens:
        if token[0] == '{':
            depth += 1
        elif token[0] == '}':
            depth -= 1
            if depth == 0:
                return text[:begin] + replacement + text[body + token.end():]
    raise AssertionError('Unterminated function: ' + name)


vector_helpers = ['scan_avx2', 'pack_avx2', 'pack_block_avx2', 'unpack_avx2', 'unpack_block_avx2',
                  'repeat_avx2', 'variable_period_avx2']
assert re.findall(r'^AVX static (?:void|unsigned|size_t) (\w+)\(', source, re.M) == vector_helpers
for name in vector_helpers + ['gzram_encode_hint_avx2', 'gzram_decode_mixed']:
    source = replace_function(source, name)
source = replace_function(source, 'gzram_avx2_available', 'int gzram_avx2_available(void) { return 0; }')
source = replace_function(source, 'gzram_encode_avx2', '''int gzram_encode_avx2(const void *src,size_t n,void *dst,size_t cap,unsigned log)
{ return gzram_encode_scalar(src,n,dst,cap,log); }''')
source = replace_function(source, 'gzram_decode_avx2', '''int gzram_decode_avx2(const void *src,size_t n,void *dst,size_t cap)
{ return gzram_decode_scalar(src,n,dst,cap); }''')
source = source.replace('#include <immintrin.h>\n', '').replace('#define AVX __attribute__((target("avx2")))\n', '')
assert '__m256' not in source and '_mm' not in source and '__builtin_cpu' not in source
assert source.count('#include <stdint.h>\n#include <string.h>') == 1
source = source.replace('#include <stdint.h>\n#include <string.h>', '''#ifdef __KERNEL__
#include <linux/types.h>
#include <linux/string.h>
#include <linux/kernel.h>
#define UINT64_C(value) value##ULL
#else
#include <stdint.h>
#include <string.h>
#endif''')
header = header.replace('#include <stddef.h>', '#ifdef __KERNEL__\n#include <linux/types.h>\n#else\n#include <stddef.h>\n#endif')
flags = ['GZRAM_SCALAR_FAST']
if a.unpack == 'ctz':
    flags.append('GZRAM_CTZ_UNPACK')
if a.repeat == 'word':
    flags.append('GZRAM_WORD_REPEAT')
if a.pack == 'ctz':
    flags.append('GZRAM_CTZ_PACK')
unsupported = ['GZRAM_EMBED_PREFIX', 'GZRAM_VARIABLE_PERIOD', 'GZRAM_PERIOD_FILTER',
               'GZRAM_MIXED_ENCODE', 'GZRAM_MIXED_DECODE', 'GZRAM_BLOCK_UNPACK',
               'GZRAM_SELECT_PACK', 'GZRAM_CTZ_UNPACK_FULL', 'GZRAM_BLOCK_PACK_LIMIT',
               'GZRAM_BLOCK_PACK_DIRECT']
prologue = '/* SPDX-License-Identifier: GPL-2.0-only */\n'
prologue += '/* Generated scalar component port; no GHY1, SIMD or ZRAM registration. */\n'
prologue += '#if ' + ' || '.join('defined(' + name + ')' for name in unsupported) + '\n#error Unsupported scalar component configuration\n#endif\n'
prologue += ''.join('#define ' + name + ' 1\n' for name in flags)
source = prologue + source
for symbol in ['avx2_available', 'encode_scalar', 'encode_avx2', 'decode_scalar', 'decode_avx2']:
    source = re.sub(r'\bgzram_' + symbol + r'\b', a.prefix + '_' + symbol, source)
    header = re.sub(r'\bgzram_' + symbol + r'\b', a.prefix + '_' + symbol, header)
header = header.replace('Experimental userspace format.', 'Experimental scalar GZR1 component port.')
header = header.replace('AVX2 entry points check CPU/OS support and fall back to scalar.', 'AVX2-named compatibility entries always use scalar; availability returns zero.')
tables = '/* Generated popcount table; no vector shuffle tables. */\n'
tables += 'static const unsigned char gz_count[256] = {' + ','.join(str(mask.bit_count()) for mask in range(256)) + '};\n'
a.output.mkdir(parents=True)
for name, content in [('core.c', source), ('gzram.h', header), ('tables.h', tables)]:
    (a.output / name).write_text(content)
manifest = dict(scope='Unbuilt isolated scalar GZR1 component; no kernel integration or performance claim',
                source_sha256={name: hashlib.sha256((root / name).read_bytes()).hexdigest()
                               for name in ['gzram/src/gzram.c', 'gzram/src/gzram.h', 'gzram/tools/prepare-scalar-port.py']},
                prefix=a.prefix, flags=flags, removed_vector_helpers=vector_helpers,
                generated_sha256={name: hashlib.sha256((a.output / name).read_bytes()).hexdigest()
                                  for name in ['core.c', 'gzram.h', 'tables.h']})
(a.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print(a.output)
