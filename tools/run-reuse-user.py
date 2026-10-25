#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Three physical-CPU user-space screening sessions; not kernel ZRAM results."""
import argparse,csv,hashlib,json,os,platform,subprocess,threading,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--directory',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert not a.output.exists();a.output.mkdir(parents=True)
os.sched_setaffinity(0,{1});env=dict(os.environ,N100_REUSE_EXPERIMENT='1')
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
state={'status':'running','completed':[],'scope':'Physical N100 user-space screening only; kernel FPU overhead and ZRAM I/O excluded','kernel':platform.release(),'binary_sha256':sha(a.directory/'native'),'libraries':{x.name:sha(x) for x in a.directory.glob('*.so')},'bash_sha256':sha(Path('/usr/bin/bash')),'started':time.time()}
def save(**values):
 state.update(values);tmp=a.output/'checkpoint.tmp';tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(a.output/'checkpoint.json')
def snapshot():
 result={'time':time.time()}
 for pattern in ['/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor','/sys/class/thermal/thermal_zone*/temp']:
  import glob
  for name in glob.glob(pattern):
   try:result[name]=Path(name).read_text().strip()
   except OSError:pass
 return result
stop=threading.Event()
def sample():
 with (a.output/'telemetry.jsonl').open('w',buffering=1) as output:
  while not stop.is_set():output.write(json.dumps(snapshot())+'\n');stop.wait(1)
try:
 save(before=snapshot())
 with (a.output/'validation.log').open('w') as log:subprocess.run(['taskset','-c','0',str(a.directory/'native'),str(a.directory),'--validate-only'],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 sampler=threading.Thread(target=sample,daemon=True);sampler.start()
 for session in range(3):
  label=f'session-{session}';save(current=label)
  with (a.output/(label+'.csv.tmp')).open('w') as output,(a.output/(label+'.stderr')).open('w') as error:subprocess.run(['taskset','-c','0',str(a.directory/'native'),str(a.directory)],env=env,stdout=output,stderr=error,check=True)
  rows=list(csv.DictReader((a.output/(label+'.csv.tmp')).open()));assert len(rows)==2688 and len({r['variant'] for r in rows})==8 and len({r['corpus'] for r in rows})==8
  (a.output/(label+'.csv.tmp')).replace(a.output/(label+'.csv'));state['completed'].append(label);save()
 save(status='complete',after=snapshot(),current=None,finished=time.time())
except BaseException as error:save(status='failed',error=repr(error),finished=time.time());raise
finally:stop.set()
