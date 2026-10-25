#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded follow-up grid after a verified screen; no autonomous code generation."""
import argparse,hashlib,json,os,platform,sys
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--preceding',type=Path,required=True);p.add_argument('--directory',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
s=json.loads(a.preceding.read_text());assert s['status']=='complete' and set(s['completed'])=={'validation','session-0','session-1','session-2'},'Preceding screen not complete; inspect before continuing'
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
runner=Path(__file__).with_name('run-native.py')
assert platform.release()==s['inputs']['kernel']
assert sha(runner)==s['inputs']['runner_sha256'] and sha(a.directory/'benchmark')==s['inputs']['binary_sha256']
assert sha(Path('/usr/bin/bash'))==s['inputs']['bash_sha256']
assert all(sha(a.directory/name)==value for name,value in s['inputs']['libraries'].items()),'Codec artifacts changed; start a new screen'
variants=['lz4-small-scalar']
for size in [32,64,128,256,512,1024,2048,4096]:
 variants += [f'gz-avx2-{size}',f'gz-fast-scalar-{size}']
 for policy in ['guard32','fused','guard32mixed','wordguard']:
  variants += [f'ghy-{policy}-scalar-{size}',f'ghy-{policy}-avx2-{size}']
assert len(variants)==len(set(variants))==81
args=[sys.executable,str(runner),'--directory',str(a.directory),'--output',str(a.output),'--variants',*variants]
print('FOLLOWUP_GRID: 81 explicit variants; all 12 corpora; scalar/SIMD and encode/decode kept separate',flush=True)
os.execv(sys.executable,args)
