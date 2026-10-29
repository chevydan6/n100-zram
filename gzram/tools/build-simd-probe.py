#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Build a guest-only isolated GHY1 SIMD correctness module; never load it."""
import argparse
import hashlib
import json
import re
import shutil
import subprocess
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
for name in ['port', 'validation', 'kernel-build', 'output']:
    p.add_argument('--' + name, type=Path, required=True)
a = p.parse_args(); a.output = a.output.resolve()
assert not a.output.exists()
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
validation = json.loads(a.validation.read_text()); assert validation['status'] == 'passed'
manifest = json.loads((a.port / 'manifest.json').read_text())
root = Path(__file__).resolve().parents[2]
for name, digest in validation['source_hashes'].items(): assert sha(root / name) == digest, name
for name, digest in manifest['generated_sha256'].items(): assert sha(a.port / name) == digest, name
# The userspace gate must belong to precisely this generated port.
steps = json.loads((a.validation.parent / 'steps.json').read_text())
assert any(str(a.port.resolve() / 'dispatch.c') in s['command'] for s in steps)
a.output.mkdir(parents=True)
for name in manifest['generated_sha256']:
    if name == 'userspace-adapter.c': continue
    dest = a.output / name; dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(a.port / name, dest)
record = dict(scope='Guest-only instrumented SIMD syscall probe; no native execution or performance claim',
              port_manifest_sha256=sha(a.port / 'manifest.json'), validation_sha256=sha(a.validation),
              builder_sha256=sha(Path(__file__)), original_generated_sha256=manifest['generated_sha256'])
# Correctness-only counters prove that the vector calls really executed. They
# are not present in the codec port or any future performance build.
dispatch = (a.output / 'dispatch.c').read_text()
dispatch = '#include <linux/kernel.h>\n#include <linux/atomic.h>\n' + dispatch
dispatch = dispatch.replace('int n100_simd_encode(', '''static atomic64_t vector_encodes = ATOMIC64_INIT(0), vector_decodes = ATOMIC64_INIT(0);
int n100_simd_check_paths(void)
{
 int available=n100_simd_available();
 long long enc=atomic64_read(&vector_encodes),dec=atomic64_read(&vector_decodes);
 pr_info("GZRAM_SIMD_PATHS available=%d encode=%lld decode=%lld\\n",available,enc,dec);
 return available?((enc>0&&dec>0)?0:-EINVAL):((enc==0&&dec==0)?0:-EINVAL);
}
int n100_simd_encode(''')
assert dispatch.count(' end_vector();') == 2
needle = ' end_vector();\n return got?got:'
assert needle in dispatch
dispatch = dispatch.replace(needle, ' end_vector();\n atomic64_inc(&vector_encodes);\n return got?got:')
needle = ' end_vector();\n return got==(int)n?'
assert needle in dispatch
dispatch = dispatch.replace(needle, ' end_vector();\n atomic64_inc(&vector_decodes);\n return got==(int)n?')
(a.output / 'dispatch.c').write_text(dispatch)
selftest = (root / 'gzram/kernel/hybrid-probe.c').read_text()
selftest = '#include <asm/cpufeature.h>\nint n100_simd_check_paths(void);\n' + selftest
selftest = selftest.replace('"control/private-lz4.h"', '"scalar/private-lz4.h"')
selftest = selftest.replace(' if (control_workspace_size()', ' if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) return -EPERM;\n if (control_workspace_size()')
selftest = selftest.replace('static void __exit probe_exit(void) { misc_deregister(&probe_device); }',
                            'static void __exit probe_exit(void) { n100_simd_check_paths(); misc_deregister(&probe_device); }')
selftest = selftest.replace(' if (bracket && !irq_fpu_usable())', ' if (bracket) { result = -EOPNOTSUPP; goto out; }\n if (bracket && !irq_fpu_usable())')
(a.output / 'selftest.c').write_text(selftest)
shutil.copy2(root / 'gzram/kernel/hybrid-probe.h', a.output / 'hybrid-probe.h')
(a.output / 'adapters.c').write_text('''/* SPDX-License-Identifier: GPL-2.0-only */
#include "simd.h"
#define WORKSPACE(prefix) \\
 size_t prefix##_workspace_size(void) { return n100_ghy_workspace_size(); } \\
 size_t prefix##_workspace_alignment(void) { return n100_ghy_workspace_alignment(); }
WORKSPACE(control)
WORKSPACE(candidate)
int control_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log,void *w,size_t ws)
{ return n100_ghy_encode(s,n,d,cap,log,w,ws); }
int candidate_encode_scalar(const void *s,size_t n,void *d,size_t cap,unsigned log,void *w,size_t ws)
{ return n100_simd_encode(s,n,d,cap,log,w,ws); }
int control_decode_scalar(const void *s,size_t n,void *d,size_t cap)
{ return n100_ghy_decode(s,n,d,cap); }
int candidate_decode_scalar(const void *s,size_t n,void *d,size_t cap)
{ return n100_simd_decode(s,n,d,cap); }
''')
scalar = ['selftest', 'adapters', 'dispatch', 'fallback', 'scalar/encoder/core', 'scalar/decoder/core',
          'scalar/hybrid', 'scalar/lz4_compress', 'scalar/lz4_decompress']
vector = ['vector-encoder/core', 'vector-decoder/core', 'vector-trial']
prototypes = ['#include <linux/types.h>', 'int n100_simd_check_paths(void);',
              'int n100_vector_trial(const void *,size_t,void *,size_t,unsigned);',
              'int n100_lz4_fallback(const void *,size_t,void *,size_t,void *);']
for prefix in ['control', 'candidate']:
    prototypes += [f'size_t {prefix}_workspace_size(void);', f'size_t {prefix}_workspace_alignment(void);',
                   f'int {prefix}_encode_scalar(const void *,size_t,void *,size_t,unsigned,void *,size_t);',
                   f'int {prefix}_decode_scalar(const void *,size_t,void *,size_t);']
for role in ['encoder', 'decoder']:
    prototypes += [f'int n100_vector_{role}_decode_mixed(const void *,size_t,void *,size_t);',
                   f'int n100_vector_{role}_encode_hint_avx2(const void *,size_t,void *,size_t,unsigned,unsigned *);']
(a.output / 'module-prototypes.h').write_text('\n'.join(prototypes)+'\n')
module = 'n100_gzram_hybrid_probe'
makefile = ['obj-m += '+module+'.o',module+'-y := '+' '.join(s+'.o' for s in scalar+vector),
            'ccflags-y += -include $(src)/module-prototypes.h -O3 -fno-tree-vectorize -fno-strict-aliasing -mno-sse -mno-mmx -mno-avx -Werror -Wframe-larger-than=1024 -fstack-usage']
for source in vector:
    makefile.append('CFLAGS_'+source+'.o += $(CC_FLAGS_FPU) -mavx2 -isystem $(shell $(CC) -print-file-name=include)')
(a.output / 'Makefile').write_text('\n'.join(makefile)+'\n')
record['generated_sha256'] = {str(p.relative_to(a.output)):sha(p) for p in a.output.rglob('*') if p.is_file()}
command = ['make','-j1','-C',str(a.kernel_build.resolve()),'M='+str(a.output),'modules']
record['command'] = command
record['compiler'] = subprocess.check_output(['gcc','--version'],text=True).splitlines()[0]
include = Path(subprocess.check_output(['gcc','-print-file-name=include'],text=True).strip())
record['compiler_intrinsic_headers'] = {p.name:sha(p) for p in include.glob('*intrin.h')}
with (a.output / 'build.log').open('w') as log:
    result = subprocess.run(command,stdout=log,stderr=subprocess.STDOUT)
record['exit_code'] = result.returncode
record['status'] = 'build-failed'
if result.returncode == 0:
    audit = {}
    for source in scalar+vector:
        obj = a.output / (source+'.o')
        asm = subprocess.check_output(['objdump','-d',str(obj)],text=True)
        (a.output / (source.replace('/','-')+'.asm')).write_text(asm)
        found = bool(re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm))
        undefined = subprocess.check_output(['nm','-u',str(obj)],text=True)
        audit[source] = dict(vector_instructions=found,expected_vector=source in vector,
                             undefined_symbols=undefined.splitlines(),object_sha256=sha(obj))
    record['objects'] = audit
    record['module_sha256'] = sha(a.output / (module+'.ko'))
    record['vermagic'] = subprocess.check_output(['modinfo','-F','vermagic',str(a.output / (module+'.ko'))],text=True).strip()
    record['stack_usage'] = {str(p.relative_to(a.output)):p.read_text().splitlines() for p in a.output.rglob('*.su')}
    good = all(v['vector_instructions']==v['expected_vector'] for v in audit.values())
    good &= all(not any('lz4' in s.lower() or 'kernel_fpu' in s for s in audit[v]['undefined_symbols']) for v in vector)
    record['status'] = 'built' if good else 'audit-failed'
(a.output / 'result.json').write_text(json.dumps(record,indent=2)+'\n')
print(record['status'])
raise SystemExit(0 if record['status']=='built' else 1)
