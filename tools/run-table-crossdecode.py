#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded identical-page N100 matrix; never changes modules or swap."""
import argparse,csv,hashlib,json,os,platform,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--directory',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
model=next(s.split(':',1)[1].strip() for s in Path('/proc/cpuinfo').read_text().splitlines() if s.startswith('model name'))
assert 'N100' in model and not a.output.exists()
a.output.mkdir(parents=True);os.sched_setaffinity(0,{1})
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def conditions():
 d={}
 for pattern in ['/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor','/sys/class/thermal/thermal_zone*/temp']:
  import glob
  for f in glob.glob(pattern):
   try:d[f]=Path(f).read_text().strip()
   except OSError:pass
 return d
state={'status':'running','scope':'Physical N100 warm-cache userspace cross-decoder attribution; not kernel ZRAM acceptance','kernel':platform.release(),'cpu_model':model,'runner_sha256':sha(Path(__file__)),'files_sha256':{p.name:sha(p) for p in a.directory.iterdir() if p.is_file()},'bash_sha256':sha(Path('/usr/bin/bash')),'completed':[],'before':conditions()}
def save():
 f=a.output/'checkpoint.tmp';f.write_text(json.dumps(state,indent=2)+'\n');f.replace(a.output/'checkpoint.json')
try:
 save()
 for i in range(3):
  state['current']=i;save();path=a.output/f'session-{i}.csv'
  with path.with_suffix('.csv.tmp').open('w') as out,(a.output/f'session-{i}.stderr').open('w') as err:
   subprocess.run(['taskset','-c','0',str(a.directory/'benchmark'),str(a.directory)],stdout=out,stderr=err,check=True,timeout=600)
  rows=list(csv.DictReader(path.with_suffix('.csv.tmp').open()));assert len(rows)==486
  assert len({(r['corpus'],r['round'],r['encoder_bits'],r['decoder_bits']) for r in rows})==486
  for corpus in {r['corpus'] for r in rows}:
   for bits in ['12','13','14']:
    selected=[r for r in rows if r['corpus']==corpus and r['encoder_bits']==bits]
    assert len({r['stream_hash'] for r in selected})==1
  path.with_suffix('.csv.tmp').replace(path);state['completed'].append(i);state['after']=conditions();save()
 state.update(status='complete',current=None);save()
except BaseException as e:state.update(status='failed',error=repr(e));save();raise
