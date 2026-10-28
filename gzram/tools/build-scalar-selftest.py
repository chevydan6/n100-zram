#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Build an isolated scalar GZR1 kernel self-test; never load or install it.

Use previously userspace-validated generated control/candidate directories.
The caller must separately verify their validation evidence. Hashes establish
input identity, not correctness. The result does not register a crypto codec.
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
a = p.parse_args()
a.output = a.output.resolve()
assert not a.output.exists()
a.output.mkdir(parents=True)
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
record = {'scope': 'Isolated scalar GZR1 kernel correctness module; unexecuted; no GHY1, SIMD, ZRAM or performance claim', 'inputs': {}}
for label in ['control', 'candidate']:
    source = getattr(a, label).resolve()
    manifest = json.loads((source / 'manifest.json').read_text())
    assert manifest['prefix'] == 'gzram'
    for name, digest in manifest['generated_sha256'].items():
        assert sha(source / name) == digest, (label, name)
    destination = a.output / label
    destination.mkdir()
    for name in ['core.c', 'gzram.h', 'tables.h']:
        shutil.copy2(source / name, destination / name)
    record['inputs'][label] = manifest
root = Path(__file__).resolve().parents[2]
selftest = root / 'gzram/kernel/scalar-selftest.c'
shutil.copy2(selftest, a.output / 'selftest.c')
record['selftest_sha256'] = sha(selftest)
symbols = ['encode_scalar', 'decode_scalar', 'encode_avx2', 'decode_avx2', 'avx2_available']
makefile = ['obj-m += n100_gzram_scalar_selftest.o',
            'n100_gzram_scalar_selftest-y := selftest.o control/core.o candidate/core.o',
            'ccflags-y += -O3 -fno-tree-vectorize -fno-strict-aliasing -mno-sse -mno-mmx -mno-avx -Werror']
for label in ['control', 'candidate']:
    makefile.append(f'CFLAGS_{label}/core.o += ' + ' '.join(f'-Dgzram_{s}={label}_{s}' for s in symbols))
(a.output / 'Makefile').write_text('\n'.join(makefile) + '\n')
command = ['make', '-j1', '-C', str(a.kernel_build.resolve()), f'M={a.output}', 'modules']
record['command'] = command
record['compiler'] = subprocess.check_output(['gcc', '--version'], text=True).splitlines()[0]
with (a.output / 'build.log').open('w') as log:
    result = subprocess.run(command, stdout=log, stderr=subprocess.STDOUT)
record['exit_code'] = result.returncode
if result.returncode == 0:
    module = a.output / 'n100_gzram_scalar_selftest.ko'
    disassembly = subprocess.check_output(['objdump', '-d', str(module)], text=True)
    (a.output / 'module.asm').write_text(disassembly)
    record['simd_register_instructions_found'] = bool(re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+', disassembly))
    record['module_sha256'] = sha(module)
    record['vermagic'] = subprocess.check_output(['modinfo', '-F', 'vermagic', str(module)], text=True).strip()
    record['status'] = 'built' if not record['simd_register_instructions_found'] else 'audit-failed'
else:
    record['status'] = 'build-failed'
(a.output / 'result.json').write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps({'status': record['status'], 'output': str(a.output)}))
raise SystemExit(0 if record['status'] == 'built' else 1)
