#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Root-only measured execution of an exact-ABI, previously VM-tested codec probe."""
from pathlib import Path
import argparse,os,subprocess,json,time,hashlib,platform,csv
p=argparse.ArgumentParser();p.add_argument('--module',type=Path,required=True);p.add_argument('--binary',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
if os.geteuid()!=0:raise SystemExit('Root required')
if a.output.exists():raise SystemExit('Use a fresh result directory')
assert subprocess.check_output(['modinfo','-F','vermagic',str(a.module)],text=True).split()[0]==platform.release()
assert subprocess.check_output(['modinfo','-F','name',str(a.module)],text=True).strip()=='n100_lz4_probe'
if subprocess.check_output(['getenforce'],text=True).strip()=='Enforcing':
 assert ':modules_object_t:' in subprocess.check_output(['ls','-Zd',str(a.module)],text=True),'Stage module in matching-kernel extra directory and restorecon; keep SELinux enforcing'
assert not Path('/sys/module/n100_lz4_probe').exists(),'Existing probe must be inspected first'
assert Path('/sys/kernel/reboot/type').read_text().strip()=='pci','Verified PCI reboot path required'
for key in ['panic','panic_on_oops','hardlockup_panic','softlockup_panic']:
 assert int(Path('/proc/sys/kernel',key).read_text())>0,(key,'recovery policy missing')
subprocess.run(['sysctl','-w','kernel.nmi_watchdog=1'],check=True)
assert Path('/sys/module/pstore/parameters/backend').read_text().strip()=='efi_pstore'
a.output.mkdir(parents=True);loaded=False
state={'status':'running','completed':[],'kernel':platform.release(),'module_sha256':hashlib.sha256(a.module.read_bytes()).hexdigest(),'binary_sha256':hashlib.sha256(a.binary.read_bytes()).hexdigest(),'started':time.time()}
def save(**values):
 state.update(values);tmp=a.output/'checkpoint.tmp';tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(a.output/'checkpoint.json')
def metadata():
 import glob
 result={'time':time.time()}
 for pattern in ['/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/class/thermal/thermal_zone*/temp']:
  for name in glob.glob(pattern):
   try:result[name]=Path(name).read_text().strip()
   except OSError:pass
 return result
try:
 save(before=metadata())
 subprocess.run(['modprobe','lz4_compress'],check=True)
 subprocess.run(['insmod',str(a.module),'iterations=1024'],check=True);loaded=True
 log=subprocess.check_output(['dmesg'],text=True)
 (a.output/'kernel-init-private.log').write_text(log)
 assert 'n100-lz4-probe: simd=1' in log
 assert 'malformed/truncated differential checks passed: 2048' in log
 assert Path('/dev/n100-lz4-bench').exists()
 for session in range(3):
  label=f'session-{session}';save(current=label)
  with (a.output/(label+'.csv.tmp')).open('w') as output,(a.output/(label+'.stderr')).open('w') as error:
   subprocess.run([str(a.binary),'/dev/n100-lz4-bench'],stdout=output,stderr=error,check=True)
  rows=list(csv.DictReader((a.output/(label+'.csv.tmp')).open()))
  corpora={r['corpus'] for r in rows}
  assert len(corpora) in [6,8] and len(rows)==len(corpora)*108
  assert {r['state'] for r in rows}=={'clean','sse-dirty','ymm-dirty'}
  assert {int(r['operation']) for r in rows}==set(range(4)) and {int(r['round']) for r in rows}==set(range(9))
  assert len({(r['corpus'],r['round'],r['state'],r['operation']) for r in rows})==len(rows)
  (a.output/(label+'.csv.tmp')).replace(a.output/(label+'.csv'))
  state['completed'].append(label);save()
 save(status='unloading',after=metadata(),current=None)
except BaseException as error:
 save(status='failed',error=repr(error),finished=time.time());raise
finally:
 if loaded:
  try:
   subprocess.run(['rmmod','n100_lz4_probe'],check=True)
   assert not Path('/sys/module/n100_lz4_probe').exists() and not Path('/dev/n100-lz4-bench').exists()
  except BaseException as error:
   save(status='failed',cleanup_error=repr(error),finished=time.time());raise
save(status='complete',finished=time.time(),cleanup_verified=True)
