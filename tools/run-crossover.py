#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Three physical-CPU smaller-table sessions; retain ratio and all regressions."""
import argparse,csv,hashlib,json,os,platform,subprocess,threading,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--directory',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--sizes',type=int,nargs='+',default=[16,32,64,128,256,512,1024,2048,4096]);a=p.parse_args();assert 1<=len(a.sizes)<=64 and len(set(a.sizes))==len(a.sizes) and all(16<=n<=4096 for n in a.sizes)
assert not a.output.exists();a.output.mkdir(parents=True)
os.sched_setaffinity(0,{1});env=dict(os.environ,N100_CROSSOVER_SIZES=','.join(map(str,a.sizes)))
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
state={'status':'running','completed':[],'scope':'Physical N100 whole-codec size sweep; kernel FPU costs, component thresholds and energy excluded','sizes':a.sizes,'kernel':platform.release(),'binary_sha256':sha(a.directory/'benchmark'),'libraries':{x.name:sha(x) for x in a.directory.glob('*.so')},'bash_sha256':sha(Path('/usr/bin/bash')),'compiler':subprocess.check_output(['gcc','--version'],text=True),'started':time.time()}
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
 with (a.output/'validation.log').open('w') as log:subprocess.run(['taskset','-c','0',str(a.directory/'benchmark'),str(a.directory),'--validate-only'],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
 sampler=threading.Thread(target=sample,daemon=True);sampler.start()
 for session in range(3):
  label=f'session-{session}';save(current=label)
  with (a.output/(label+'.csv.tmp')).open('w') as output,(a.output/(label+'.stderr')).open('w') as error:subprocess.run(['taskset','-c','0',str(a.directory/'benchmark'),str(a.directory)],env=env,stdout=output,stderr=error,check=True)
  rows=list(csv.DictReader((a.output/(label+'.csv.tmp')).open()));assert len(rows)==len(a.sizes)*162 and len({r['variant'] for r in rows})==3 and len({r['corpus'] for r in rows})==3 and {int(r['bytes']) for r in rows}==set(a.sizes)
  (a.output/(label+'.csv.tmp')).replace(a.output/(label+'.csv'));state['completed'].append(label);save()
 save(status='complete',after=snapshot(),current=None,finished=time.time())
except BaseException as error:save(status='failed',error=repr(error),finished=time.time());raise
finally:stop.set()
