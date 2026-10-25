#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
import argparse,hashlib,json,os,shlex,shutil,subprocess
from pathlib import Path
root=Path(__file__).resolve().parents[2]
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,default=root/'build/gzram');a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
lines=['/* SPDX-License-Identifier: GPL-2.0-only */','/* Generated from mask bits by this project; no upstream table copied. */']
lines.append('static const unsigned char gz_count[256] = {'+','.join(str(m.bit_count()) for m in range(256))+'};')
for name in ['encode','decode']:
 lines.append(f'static const unsigned int gz_{name}_indices[256][8] = {{')
 for mask in range(256):
  present=[i for i in range(8) if mask&(1<<i)]
  row=present+[0]*(8-len(present)) if name=='encode' else [sum(bool(mask&(1<<j)) for j in range(i)) if mask&(1<<i) else 0 for i in range(8)]
  lines.append('{'+','.join(map(str,row))+'},')
 lines.append('};')
(a.output/'tables.h').write_text('\n'.join(lines)+'\n')
cc=os.environ.get('CC','gcc');extra=shlex.split(os.environ.get('EXTRA_CFLAGS',''))
flags=['-O3','-g','-fPIC','-Wall','-Wextra','-Werror','-fno-tree-vectorize','-fno-strict-aliasing','-mno-sse','-mno-mmx','-mno-avx']
cmd=[cc,*flags,*extra,'-I'+str(a.output),'-shared',str(root/'gzram/src/gzram.c'),'-o',str(a.output/'libgzram.so')];subprocess.run(cmd,check=True)
subprocess.run([cc,*flags,*extra,'-DGZRAM_SCALAR_FAST=1','-I'+str(a.output),'-shared',str(root/'gzram/src/gzram.c'),'-o',str(a.output/'libgzram-fast.so')],check=True)
subprocess.run([cc,*flags,*extra,'-DGZRAM_BLOCK_UNPACK=1','-I'+str(a.output),'-shared',str(root/'gzram/src/gzram.c'),'-o',str(a.output/'libgzram-block.so')],check=True)
subprocess.run([cc,*flags,*extra,'-DGZRAM_VARIABLE_PERIOD=1','-DGZRAM_SCALAR_FAST=1','-I'+str(a.output),'-shared',str(root/'gzram/src/gzram.c'),'-o',str(a.output/'libgzram-period.so')],check=True)
subprocess.run([cc,*flags,*extra,'-DGZRAM_VARIABLE_PERIOD=1','-DGZRAM_PERIOD_FILTER=1','-DGZRAM_SCALAR_FAST=1','-I'+str(a.output),'-shared',str(root/'gzram/src/gzram.c'),'-o',str(a.output/'libgzram-filter.so')],check=True)
# Matched optimized scalar LZ4 reference, built from this repository's source.
base=a.output/'lz4-small';private=base/'include/linux';private.mkdir(parents=True,exist_ok=True)
(private/'lz4.h').write_text((root/'include/linux/lz4.h').read_text().replace('#define LZ4_MEMORY_USAGE 14','#define LZ4_MEMORY_USAGE 12'))
subprocess.run([cc,*flags,*extra,'-I'+str(base/'include'),'-I'+str(root/'include'),'-shared','-Wl,-Bsymbolic-functions',str(root/'src/kernel-lz4/lz4_compress.c'),str(root/'src/kernel-lz4/lz4_decompress.c'),'-o',str(a.output/'lz4-small.so')],check=True)
manifest={'period_filter_candidate':True,'variable_period_candidate':True,'block_unpack_candidate':True,'fast_scalar_candidate':True,'candidate_extra_flags':{'fast_scalar':['-DGZRAM_SCALAR_FAST=1'],'block_unpack':['-DGZRAM_BLOCK_UNPACK=1'],'variable_period':['-DGZRAM_VARIABLE_PERIOD=1','-DGZRAM_SCALAR_FAST=1']},'compiler':subprocess.check_output([cc,'--version'],text=True).splitlines()[0],'flags':flags+extra,'source_sha256':{str(f.relative_to(root)):hashlib.sha256(f.read_bytes()).hexdigest() for f in [root/'gzram/src/gzram.c',root/'gzram/src/gzram.h',Path(__file__).resolve()]},'artifacts':{f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in a.output.glob('*.so')}}
(a.output/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n');print(a.output)
