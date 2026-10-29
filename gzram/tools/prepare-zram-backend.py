#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Prepare isolated scalar GHY1 ZRAM backends from a validated workspace port.

No build, installation, module load or host setting change. The caller supplies
matching prepared kernel source; a manifest is identity evidence, not validation.
"""
import argparse
import difflib
import hashlib
import json
import shutil
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
for name in ['reference', 'port', 'validation', 'source-record', 'output']:
    p.add_argument('--' + name, type=Path, required=True)
a = p.parse_args()
root = Path(__file__).resolve().parents[2]
reference, output = a.reference.resolve(), a.output.resolve()
assert reference.is_dir() and not output.exists()
assert reference not in output.parents and output not in reference.parents
assert json.loads(a.validation.read_text())['status'] == 'passed'
manifest = json.loads((a.port / 'manifest.json').read_text())
assert manifest['policy'].startswith('bitdirect scalar guard;')
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
for name, digest in manifest['generated_sha256'].items():
    assert sha(a.port / name) == digest, name
output.mkdir(parents=True)
reference_hashes = {}
for source in reference.iterdir():
    if source.is_file() and (source.suffix in ['.c', '.h'] or source.name in ['Makefile', 'Kconfig']):
        assert not source.name.endswith('.mod.c'), 'Use a clean reference source tree'
        shutil.copy2(source, output / source.name)
        reference_hashes[source.name] = sha(source)

def change(name, old, new):
    path = output / name
    text = path.read_text()
    assert text.count(old) == 1, (name, old)
    path.write_text(text.replace(old, new))

change('Kconfig', 'config ZRAM_BACKEND_LZ4HC', '''config ZRAM_BACKEND_GHY_BITDIRECT
	bool "Experimental scalar GHY1 bitdirect and matched private LZ4"
	depends on ZRAM && X86_64
	help
	  Default-off research backends with independently recoverable pages.
	  No SIMD, dictionaries, compression-level interface or batching.
	  This option does not change the default compressor.

config ZRAM_BACKEND_LZ4HC''')
change('zcomp.c', '#include "backend_lz4.h"', '''#include "backend_lz4.h"
#include "backend_ghy_bitdirect.h"''')
change('zcomp.c', 'static const struct zcomp_ops *backends[] = {', '''static const struct zcomp_ops *backends[] = {
#if IS_ENABLED(CONFIG_ZRAM_BACKEND_GHY_BITDIRECT)
	&backend_ghy_bitdirect,
	&backend_lz4_ghy,
#endif''')
(output / 'backend_ghy_bitdirect.h').write_text('''/* SPDX-License-Identifier: GPL-2.0-only */
#include "zcomp.h"
extern const struct zcomp_ops backend_ghy_bitdirect;
extern const struct zcomp_ops backend_lz4_ghy;
''')
for source, name in [('backend-ghy-bitdirect.c', 'backend_ghy_bitdirect.c'),
                     ('backend-lz4-ghy.c', 'backend_lz4_ghy.c')]:
    shutil.copy2(root / 'gzram/kernel' / source, output / name)
normalization = {}
for name, digest in manifest['generated_sha256'].items():
    target = output / 'ghy' / name
    target.parent.mkdir(parents=True, exist_ok=True)
    if name == 'hybrid.c':
        text = (a.port / name).read_text()
        count = text.count('__attribute__((noinline))')
        assert count == 2
        target.write_text(text.replace('__attribute__((noinline))', '__attribute__((__noinline__))'))
        normalization[name] = dict(occurrences=count, before=digest, after=sha(target))
    else:
        shutil.copy2(a.port / name, target)
objects = ['backend_ghy_bitdirect.o', 'backend_lz4_ghy.o', 'ghy/encoder/core.o',
           'ghy/decoder/core.o', 'ghy/hybrid.o', 'ghy/lz4_compress.o', 'ghy/lz4_decompress.o']
with (output / 'Makefile').open('a') as make:
    make.write('\n# Experimental only; keep stock ZRAM compilation flags unchanged.\n')
    make.write('zram-$(CONFIG_ZRAM_BACKEND_GHY_BITDIRECT) += ' + ' '.join(objects) + '\n')
    # An external-module build does not regenerate autoconf.h for this new
    # default-off option. Enable its source guard only with the explicit option.
    make.write('ccflags-$(CONFIG_ZRAM_BACKEND_GHY_BITDIRECT) += -DCONFIG_ZRAM_BACKEND_GHY_BITDIRECT=1\n')
    for name in objects:
        make.write('CFLAGS_' + name + ' += -O3 -fno-tree-vectorize -fno-strict-aliasing -mno-sse -mno-mmx -mno-avx -Werror -Wframe-larger-than=1024 -fstack-usage\n')
patch = []
for path in sorted(output.rglob('*')):
    if not path.is_file(): continue
    name = str(path.relative_to(output))
    previous = reference / name
    old = previous.read_text() if previous.exists() else ''
    new = path.read_text()
    if old != new:
        patch.extend(difflib.unified_diff(old.splitlines(True), new.splitlines(True),
                     fromfile='a/drivers/block/zram/' + name if previous.exists() else '/dev/null',
                     tofile='b/drivers/block/zram/' + name))
(output / 'ghy-backends.patch').write_text(''.join(patch))
record = dict(scope='Unbuilt isolated default-off scalar ZRAM prototype; no host use or performance claim',
              source_record=json.loads(a.source_record.read_text()), reference_sha256=reference_hashes,
              port_manifest=manifest, validation_sha256=sha(a.validation),
              generator_sha256=sha(Path(__file__)), attribute_normalization=normalization,
              objects=objects, backend_names=['ghy-bitdirect', 'lz4-ghy'],
              generated_sha256={str(f.relative_to(output)): sha(f) for f in sorted(output.rglob('*')) if f.is_file()})
(output / 'manifest.json').write_text(json.dumps(record, indent=2) + '\n')
print(output)
