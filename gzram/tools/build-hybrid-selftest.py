#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Build an isolated scalar GHY1 kernel self-test from validated workspace ports.

No native module loading or installation. The caller must check the corresponding
userspace validation evidence. Hashes establish source identity, not correctness.
"""
import argparse
import hashlib
import json
import re
import shutil
import subprocess
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
for name in ['control', 'candidate', 'kernel-build', 'output']:
    p.add_argument('--' + name, type=Path, required=True)
p.add_argument('--kind', choices=['selftest', 'probe'], default='selftest')
a = p.parse_args()
a.output = a.output.resolve()
assert not a.output.exists()
a.output.mkdir(parents=True)
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
record = {'scope': 'Unexecuted scalar GHY1 kernel ' + a.kind + '; no SIMD, ZRAM registration or performance claim', 'inputs': {}, 'kernel_attribute_normalization': {}}
for label in ['control', 'candidate']:
    directory = getattr(a, label).resolve()
    manifest = json.loads((directory / 'manifest.json').read_text())
    for name, digest in manifest['generated_sha256'].items():
        assert sha(directory / name) == digest, (label, name)
        target = a.output / label / name
        target.parent.mkdir(parents=True, exist_ok=True)
        if name == 'hybrid.c':
            # Linux defines a noinline macro. Reserved GCC attribute spelling
            # preserves the attribute while avoiding recursive macro expansion.
            text = (directory / name).read_text()
            count = text.count('__attribute__((noinline))')
            assert count == 2
            target.write_text(text.replace('__attribute__((noinline))', '__attribute__((__noinline__))'))
            record['kernel_attribute_normalization'][label] = dict(
                occurrences=count, before_sha256=digest, after_sha256=sha(target),
                change='noinline attribute token to equivalent reserved __noinline__ token')
        else:
            shutil.copy2(directory / name, target)
    record['inputs'][label] = manifest
# Both codecs must use precisely the same private LZ4 implementation and ABI.
for name in ['lz4_compress.c', 'lz4_decompress.c', 'lz4defs.h', 'private-lz4.h']:
    assert (a.output / 'control' / name).read_bytes() == (a.output / 'candidate' / name).read_bytes(), name
root = Path(__file__).resolve().parents[2]
selftest = root / ('gzram/kernel/hybrid-' + a.kind + '.c')
shutil.copy2(selftest, a.output / 'selftest.c')
record['selftest_sha256'] = sha(selftest)
if a.kind == 'probe':
    header = root / 'gzram/kernel/hybrid-probe.h'
    shutil.copy2(header, a.output / header.name)
    record['probe_header_sha256'] = sha(header)
objects = ['selftest.o', 'control/lz4_compress.o', 'control/lz4_decompress.o']
for label in ['control', 'candidate']:
    objects += [label + '/' + name + '.o' for name in ['encoder/core', 'decoder/core', 'hybrid']]
module_name = 'n100_gzram_hybrid_' + a.kind
makefile = ['obj-m += ' + module_name + '.o',
            module_name + '-y := ' + ' '.join(objects),
            'ccflags-y += -O3 -fno-tree-vectorize -fno-strict-aliasing -mno-sse -mno-mmx -mno-avx -Werror -Wframe-larger-than=1024 -fstack-usage']
for label in ['control', 'candidate']:
    definitions = []
    for role in ['encoder', 'decoder']:
        for symbol in ['encode_scalar', 'decode_scalar', 'encode_avx2', 'decode_avx2', 'avx2_available']:
            definitions.append(f'-Dn100_{role}_{symbol}={label}_{role}_{symbol}')
    for original, renamed in [('encode', 'encode_scalar'), ('decode', 'decode_scalar'),
                               ('workspace_size', 'workspace_size'), ('workspace_alignment', 'workspace_alignment')]:
        definitions.append(f'-Dn100_ghy_{original}={label}_{renamed}')
    for obj in ['encoder/core.o', 'decoder/core.o', 'hybrid.o']:
        makefile.append(f'CFLAGS_{label}/{obj} += ' + ' '.join(definitions))
(a.output / 'Makefile').write_text('\n'.join(makefile) + '\n')
command = ['make', '-j1', '-C', str(a.kernel_build.resolve()), f'M={a.output}', 'modules']
record['command'] = command
record['compiler'] = subprocess.check_output(['gcc', '--version'], text=True).splitlines()[0]
with (a.output / 'build.log').open('w') as log:
    result = subprocess.run(command, stdout=log, stderr=subprocess.STDOUT)
record['exit_code'] = result.returncode
if result.returncode == 0:
    module = a.output / (module_name + '.ko')
    disassembly = subprocess.check_output(['objdump', '-d', str(module)], text=True)
    (a.output / 'module.asm').write_text(disassembly)
    record['simd_register_instructions_found'] = bool(re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+', disassembly))
    record['module_sha256'] = sha(module)
    record['vermagic'] = subprocess.check_output(['modinfo', '-F', 'vermagic', str(module)], text=True).strip()
    record['stack_usage'] = {str(path.relative_to(a.output)): path.read_text().splitlines() for path in sorted(a.output.rglob('*.su'))}
    record['stack_usage_scope'] = 'Compiler per-function frame estimates, not measured whole-call-chain peak stack'
    record['status'] = 'built' if not record['simd_register_instructions_found'] else 'audit-failed'
else:
    record['status'] = 'build-failed'
(a.output / 'result.json').write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps({'status': record['status'], 'output': str(a.output)}))
raise SystemExit(0 if record['status'] == 'built' else 1)
