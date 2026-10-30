#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Add a default-off guarded SIMD backend to a prepared scalar ZRAM tree.

Generate only: no module load, registration on the host, or performance claim.
The scalar and vector ports must already have passed their independent gates.
"""
import argparse, hashlib, json, shutil, subprocess
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__)
for name in ['reference','scalar-port','scalar-validation','simd-port','simd-validation','source-record','output']:
 p.add_argument('--'+name,type=Path,required=True)
a=p.parse_args();root=Path(__file__).resolve().parents[2]
assert not a.output.exists()
assert json.loads(a.simd_validation.read_text())['status']=='passed'
m=json.loads((a.simd_port/'manifest.json').read_text());sha=lambda f:hashlib.sha256(f.read_bytes()).hexdigest()
for name,digest in m['generated_sha256'].items():assert sha(a.simd_port/name)==digest,name
scalar=json.loads((a.scalar_port/'manifest.json').read_text())
for name in scalar['generated_sha256']:
 if name!='userspace-adapter.c':
  candidate=a.simd_port/'scalar'/name
  assert candidate.exists(),name
  old=(a.scalar_port/name).read_text().replace('__attribute__((noinline))','__attribute__((__noinline__))')
  assert candidate.read_text()==old,name
cmd=['python3',str(root/'gzram/tools/prepare-zram-backend.py'),'--reference',str(a.reference),'--port',str(a.scalar_port),'--validation',str(a.scalar_validation),'--source-record',str(a.source_record),'--output',str(a.output)]
subprocess.run(cmd,check=True)
out=a.output
for name in m['generated_sha256']:
 if name=='userspace-adapter.c' or name.startswith('scalar/') and name.endswith('.c'):continue
 target=out/'simd'/name;target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(a.simd_port/name,target)
backend=(root/'gzram/kernel/backend-ghy-bitdirect.c').read_text().replace('backend_ghy_bitdirect.h','backend_ghy_simd.h').replace('"ghy/ghy_scalar.h"','"simd/simd.h"').replace('n100_ghy_encode(', 'n100_simd_encode(').replace('n100_ghy_decode(', 'n100_simd_decode(').replace('backend_ghy_bitdirect','backend_ghy_simd').replace('"ghy-bitdirect"','"ghy-simd"').replace('Experimental scalar GHY1 ZRAM adapter. No SIMD or cross-page dictionary.','Experimental guarded SIMD GHY1 ZRAM adapter. No cross-page dictionary.')
(out/'backend_ghy_simd.c').write_text(backend)
(out/'backend_ghy_simd.h').write_text('/* SPDX-License-Identifier: GPL-2.0-only */\n#include "zcomp.h"\nextern const struct zcomp_ops backend_ghy_simd;\n')
z=(out/'zcomp.c').read_text();assert z.count('#include "backend_ghy_bitdirect.h"')==1;z=z.replace('#include "backend_ghy_bitdirect.h"','#include "backend_ghy_bitdirect.h"\n#include "backend_ghy_simd.h"');assert z.count('&backend_ghy_bitdirect,')==1;z=z.replace('&backend_ghy_bitdirect,','&backend_ghy_bitdirect,\n\t&backend_ghy_simd,');(out/'zcomp.c').write_text(z)
prototypes='''#include <linux/types.h>\nint n100_vector_trial(const void *,size_t,void *,size_t,unsigned);\nint n100_lz4_fallback(const void *,size_t,void *,size_t,void *);\n'''
for role in ['encoder','decoder']:
 prototypes+=f'int n100_vector_{role}_decode_mixed(const void *,size_t,void *,size_t);\nint n100_vector_{role}_encode_hint_avx2(const void *,size_t,void *,size_t,unsigned,unsigned *);\n'
(out/'simd/module-prototypes.h').write_text(prototypes)
scalar_objects=['backend_ghy_simd.o','simd/dispatch.o','simd/fallback.o'];vector_objects=['simd/vector-encoder/core.o','simd/vector-decoder/core.o','simd/vector-trial.o']
with (out/'Makefile').open('a') as f:
 f.write('\nzram-$(CONFIG_ZRAM_BACKEND_GHY_BITDIRECT) += '+' '.join(scalar_objects+vector_objects)+'\n')
 for obj in scalar_objects+vector_objects:
  f.write('CFLAGS_'+obj+' += -include $(src)/simd/module-prototypes.h -O3 -fno-tree-vectorize -fno-strict-aliasing -mno-sse -mno-mmx -mno-avx -Werror -Wframe-larger-than=1024 -fstack-usage\n')
 for obj in vector_objects:f.write('CFLAGS_'+obj+' += $(CC_FLAGS_FPU) -mavx2 -isystem $(shell $(CC) -print-file-name=include)\n')
(out/'simd-generation.json').write_text(json.dumps(dict(scope='Unbuilt default-off guest-test prototype; no host use',generator_sha256=sha(Path(__file__)),simd_port_manifest_sha256=sha(a.simd_port/'manifest.json'),scalar_port_manifest_sha256=sha(a.scalar_port/'manifest.json'),scalar_objects=scalar_objects,vector_objects=vector_objects),indent=2)+'\n')
