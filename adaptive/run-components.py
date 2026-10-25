#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Root-only bounded kernel component experiment; no ZRAM registration or replacement."""
import argparse,csv,hashlib,json,os,platform,random,signal,subprocess,threading,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--batches',nargs='+',type=int,choices=range(1,17));p.add_argument('--page-only',action='store_true');p.add_argument('--module',type=Path,required=True);p.add_argument('--validated-sha256',required=True);p.add_argument('--helper',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert os.geteuid()==0 and not a.output.exists();os.sched_setaffinity(0,{1})
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def out(args):return subprocess.check_output(args,text=True).strip()
assert sha(a.module)==a.validated_sha256
assert out(['modinfo','-F','name',str(a.module)])=='n100_component_probe'
assert out(['modinfo','-F','vermagic',str(a.module)]).split()[0]==platform.release()
assert ':modules_object_t:' in out(['ls','-Zd',str(a.module)])
assert not Path('/sys/module/n100_component_probe').exists()
assert Path('/sys/kernel/reboot/type').read_text().strip()=='pci'
for name in ['panic','panic_on_oops','hardlockup_panic','softlockup_panic']:assert int(Path('/proc/sys/kernel/'+name).read_text())>0
subprocess.run(['sysctl','-w','kernel.nmi_watchdog=1'],check=True)
model=next(line.split(':',1)[1].strip() for line in Path('/proc/cpuinfo').read_text().splitlines() if line.startswith('model name'))
assert 'N100' in model,'Native conclusions require the physical N100'
a.output.mkdir(parents=True);state={'cpu_model':model,'runner_sha256':sha(Path(__file__)),'status':'running','kernel':platform.release(),'module_sha256':a.validated_sha256,'helper_sha256':sha(a.helper),'completed':[],'scope':'Physical N100 kernel component experiment; syscall/dispatch/mutex/loop and kernel FPU handling included; normal ZRAM unchanged','started':time.time()}
def save(**kw):
 state.update(kw);p=a.output/'checkpoint.tmp';p.write_text(json.dumps(state,indent=2)+'\n');p.replace(a.output/'checkpoint.json')
def snapshot():
 import glob
 d={'time':time.time()}
 for pattern in ['/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor','/sys/class/thermal/thermal_zone*/temp']:
  for name in glob.glob(pattern):
   try:d[name]=Path(name).read_text().strip()
   except OSError:pass
 return d
stop=threading.Event()
def sample():
 with (a.output/'telemetry.jsonl').open('w',buffering=1) as log:
  while not stop.is_set():log.write(json.dumps(snapshot())+'\n');stop.wait(.5)
assert not a.page_only or a.batches
if a.batches:assert len(set(a.batches))==len(a.batches)
loaded=False;success=False
signal.signal(signal.SIGTERM,lambda *_:(_ for _ in ()).throw(SystemExit('Termination requested; unload owned probe')))
try:
 save(before=snapshot());subprocess.run(['insmod',str(a.module)],check=True);loaded=True
 batches=a.batches or [1]
 def environment(batch):
  env=dict(os.environ)
  if a.batches:env['N100_COMPONENT_BATCH']=str(batch)
  if a.page_only:env['N100_COMPONENT_PAGE_ONLY']='1'
  return env
 def configs(batch):return 6*sum(n<=65536//batch and (not a.page_only or n==4096) for n in [16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536])
 save(batches=batches,page_only=a.page_only,fpu_bracketing='once per batch; scalar fallback when required',normal_zram_unchanged=True)
 with (a.output/'validation.log').open('w') as log:
  for batch in batches:subprocess.run(['taskset','-c','0',str(a.helper),'/dev/n100-component-bench','--validate-only'],env=environment(batch),stdout=log,stderr=subprocess.STDOUT,check=True,timeout=120)
 assert all(f'COMPONENT_VALIDATION_PASS configurations={configs(batch)}' in (a.output/'validation.log').read_text() for batch in batches)
 thread=threading.Thread(target=sample,daemon=True);thread.start()
 order=[(batch,session) for batch in batches for session in range(3)];random.Random(100).shuffle(order)
 for batch,session in order:
  label=f'batch-{batch}-session-{session}' if a.batches else f'session-{session}';save(current=label)
  with (a.output/(label+'.csv.tmp')).open('w') as log,(a.output/(label+'.stderr')).open('w') as err:subprocess.run(['taskset','-c','0',str(a.helper),'/dev/n100-component-bench'],env=environment(batch),stdout=log,stderr=err,check=True,timeout=600)
  rows=list(csv.DictReader((a.output/(label+'.csv.tmp')).open()));expected=configs(batch)*60
  assert len(rows)==expected and len({(r['bytes'],r['operation'],r['pattern'],r['round'],r['state'],r['variant']) for r in rows})==expected
  if a.batches:assert all(int(r['batch'])==batch for r in rows)
  (a.output/(label+'.csv.tmp')).replace(a.output/(label+'.csv'));state['completed'].append(label);save()
 success=True
except BaseException as error:save(status='failed',error=repr(error));raise
finally:
 stop.set()
 if loaded:
  subprocess.run(['rmmod','n100_component_probe'],check=True);assert not Path('/sys/module/n100_component_probe').exists();save(probe_unloaded=True)
 if success:save(status='complete',current=None,after=snapshot(),finished=time.time())
