#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded/resumable N100 userspace screening; never changes swap or kernel modules."""
import argparse,csv,hashlib,json,os,platform,subprocess,threading,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--variants',nargs='+');p.add_argument('--screen',action='store_true');p.add_argument('--directory',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--resume',action='store_true');a=p.parse_args();os.sched_setaffinity(0,{1})
assert not (a.screen and a.variants)
env=dict(os.environ,GZRAM_ORDER_SEED='100')
if a.screen:env['GZRAM_HYBRID_SCREEN']='1'
else:env.pop('GZRAM_HYBRID_SCREEN',None)
if a.variants:
 assert len(a.variants)==len(set(a.variants)) and all(name and ',' not in name for name in a.variants)
 env['GZRAM_VARIANT_LIST']=','.join(a.variants)
else:env.pop('GZRAM_VARIANT_LIST',None)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
model=next(line.split(':',1)[1].strip() for line in Path('/proc/cpuinfo').read_text().splitlines() if line.startswith('model name'))
assert 'N100' in model,'Performance runs must use the physical N100'
variant_names=subprocess.check_output([str(a.directory/'benchmark'),str(a.directory),'--list-variants'],env=env,text=True).splitlines()
corpora=subprocess.check_output([str(a.directory/'benchmark'),str(a.directory),'--list-corpora'],env=env,text=True).splitlines()
if a.variants:assert set(variant_names)==set(a.variants),'Unknown or missing requested variants'
assert variant_names and corpora and len(set(variant_names))==len(variant_names) and len(set(corpora))==len(corpora)
corpus_hashes={name:hashlib.sha256(subprocess.check_output([str(a.directory/'benchmark'),str(a.directory),'--dump-corpus='+name],env=env)).hexdigest() for name in corpora}
inputs={'corpus_sha256':corpus_hashes,'order_seeds':[100,101,102],'selected_variants':a.variants,'variant_names':variant_names,'corpora':corpora,'screen':a.screen,'cpu_model':model,'runner_sha256':sha(Path(__file__)),'kernel':platform.release(),'binary_sha256':sha(a.directory/'benchmark'),'manifest':json.loads((a.directory/'manifest.json').read_text()),'libraries':{f.name:sha(f) for f in a.directory.glob('*.so')},'bash_sha256':sha(Path('/usr/bin/bash')),'scope':'Physical N100 userspace codec screening; kernel FPU/I/O costs excluded; package energy includes batch bookkeeping/background work'}
if a.output.exists():
 assert a.resume;state=json.loads((a.output/'checkpoint.json').read_text());assert state['inputs']==inputs,'Sources or environment changed; preserve old output and start fresh'
else:a.output.mkdir(parents=True);state={'inputs':inputs,'completed':[],'attempts':{},'started':time.time()}
def save(**kwargs):
 state.update(kwargs);tmp=a.output/'checkpoint.tmp';tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(a.output/'checkpoint.json')
def snapshot():
 import glob
 d={'time':time.time()}
 for pattern in ['/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor','/sys/class/thermal/thermal_zone*/temp']:
  for name in glob.glob(pattern):
   try:d[name]=Path(name).read_text().strip()
   except OSError:pass
 return d
stop=threading.Event();thread=None
def sample():
 with (a.output/'telemetry.jsonl').open('a',buffering=1) as log:
  while not stop.is_set():log.write(json.dumps(snapshot())+'\n');stop.wait(.5)
try:
 save(status='running',before=snapshot());thread=threading.Thread(target=sample,daemon=True);thread.start()
 if 'validation' not in state['completed']:
  with (a.output/'validation.log').open('w') as out:subprocess.run(['taskset','-c','0',str(a.directory/'benchmark'),str(a.directory),'--validate-only'],stdout=out,stderr=subprocess.STDOUT,env=env,check=True)
  state['completed'].append('validation');save()
 for session in range(3):
  label=f'session-{session}'
  if label in state['completed']:continue
  attempt=state['attempts'].get(label,0);state['attempts'][label]=attempt+1;temporary=a.output/f'{label}.attempt-{attempt}.csv.tmp';save(current=label)
  session_env=dict(env,GZRAM_ORDER_SEED=str(100+session))
  with temporary.open('w') as out,(a.output/f'{label}.attempt-{attempt}.stderr').open('w') as err:subprocess.run(['taskset','-c','0',str(a.directory/'benchmark'),str(a.directory)],stdout=out,stderr=err,env=session_env,check=True)
  rows=list(csv.DictReader(temporary.open()));expected_variants=len(variant_names);expected_rows=expected_variants*len(corpora)*18
  assert len(rows)==expected_rows and len({(r['corpus'],r['round'],r['variant'],r['operation']) for r in rows})==expected_rows
  assert {r['variant'] for r in rows}==set(variant_names) and {r['corpus'] for r in rows}==set(corpora)
  temporary.replace(a.output/(label+'.csv'));state['completed'].append(label);save()
 save(status='complete',after=snapshot(),current=None,finished=time.time())
except BaseException as error:save(status='failed',error=repr(error),finished=time.time());raise
finally:
 stop.set()
 if thread:thread.join(timeout=3)
