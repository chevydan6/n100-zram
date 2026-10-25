#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Root-only bounded kernel component experiment; no ZRAM registration or replacement."""
import argparse,csv,hashlib,json,os,platform,signal,subprocess,threading,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--module',type=Path,required=True);p.add_argument('--validated-sha256',required=True);p.add_argument('--helper',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
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
a.output.mkdir(parents=True);state={'status':'running','kernel':platform.release(),'module_sha256':a.validated_sha256,'helper_sha256':sha(a.helper),'completed':[],'scope':'Physical N100 kernel component experiment; syscall/dispatch/mutex/loop and kernel FPU handling included; normal ZRAM unchanged','started':time.time()}
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
loaded=False;success=False
signal.signal(signal.SIGTERM,lambda *_:(_ for _ in ()).throw(SystemExit('Termination requested; unload owned probe')))
try:
 save(before=snapshot());subprocess.run(['insmod',str(a.module)],check=True);loaded=True
 with (a.output/'validation.log').open('w') as log:subprocess.run(['taskset','-c','0',str(a.helper),'/dev/n100-component-bench','--validate-only'],stdout=log,stderr=subprocess.STDOUT,check=True,timeout=120)
 assert 'COMPONENT_VALIDATION_PASS configurations=78' in (a.output/'validation.log').read_text()
 thread=threading.Thread(target=sample,daemon=True);thread.start()
 for session in range(3):
  label=f'session-{session}';save(current=label)
  with (a.output/(label+'.csv.tmp')).open('w') as log,(a.output/(label+'.stderr')).open('w') as err:subprocess.run(['taskset','-c','0',str(a.helper),'/dev/n100-component-bench'],stdout=log,stderr=err,check=True,timeout=600)
  rows=list(csv.DictReader((a.output/(label+'.csv.tmp')).open()));assert len(rows)==4680 and len({(r['bytes'],r['operation'],r['pattern'],r['round'],r['state'],r['variant']) for r in rows})==4680
  (a.output/(label+'.csv.tmp')).replace(a.output/(label+'.csv'));state['completed'].append(label);save()
 success=True
except BaseException as error:save(status='failed',error=repr(error));raise
finally:
 stop.set()
 if loaded:
  subprocess.run(['rmmod','n100_component_probe'],check=True);assert not Path('/sys/module/n100_component_probe').exists();save(probe_unloaded=True)
 if success:save(status='complete',current=None,after=snapshot(),finished=time.time())
