#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded native ZRAM comparison, restoring the installed stock module and swap."""
from pathlib import Path
import argparse,hashlib,json,lzma,os,platform,signal,subprocess,tempfile,time
p=argparse.ArgumentParser();p.add_argument('--algorithms',nargs='+',default=['lzo-rle','lz4','lz4-n100','lz4-rep8']);p.add_argument('--resume-pressure',type=Path);p.add_argument('--mode',choices=['io','pressure'],default='io');p.add_argument('--pressure-binary',type=Path);p.add_argument('--state-helper',type=Path);p.add_argument('--repeats',type=int,default=3);p.add_argument('--module',type=Path,required=True);p.add_argument('--validated-sha256',required=True);p.add_argument('--benchmark',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
if os.geteuid()!=0:raise SystemExit('Root required')
def out(args):return subprocess.check_output(args,text=True).strip()
def run(args):subprocess.run(args,check=True)
def read(path):return Path(path).read_text().strip()
def reset_primary():
 assert not any(line.split()[0]=='/dev/zram0' for line in Path('/proc/swaps').read_text().splitlines()[1:])
 if not Path('/sys/block/zram0').exists():return
 if int(read('/sys/block/zram0/disksize'))==0:return
 run(['udevadm','settle','--timeout=10'])
 for attempt in range(20):
  result=subprocess.run(['zramctl','--reset','/dev/zram0'],capture_output=True,text=True)
  if result.returncode==0:return
  time.sleep(.25)
 raise RuntimeError('Drained primary reset stayed busy: '+result.stderr)
def unload():
 run(['udevadm','settle','--timeout=10'])
 for attempt in range(20):
  result=subprocess.run(['rmmod','zram'],capture_output=True,text=True)
  if result.returncode==0:return
  time.sleep(.25)
 raise RuntimeError('ZRAM module stayed referenced; no force-unload attempted: '+result.stderr)
def build_note(module):
 data=module.read_bytes()
 if module.suffix=='.xz':data=lzma.decompress(data)
 with tempfile.TemporaryDirectory(prefix='n100-module-note-') as directory:
  folder=Path(directory);image=folder/'input.ko';image.write_bytes(data)
  run(['objcopy','--dump-section','.note.gnu.build-id='+str(folder/'note'),str(image),str(folder/'copy.ko')])
  note=(folder/'note').read_bytes();assert len(note)>16;return note
assert not a.output.exists(),'Preserve existing measurements'
if a.mode=='pressure':assert a.pressure_binary and a.state_helper and 1<=a.repeats<=5
if a.resume_pressure:assert a.mode=='pressure' and a.resume_pressure.is_dir()
assert hashlib.sha256(a.module.read_bytes()).hexdigest()==a.validated_sha256
assert out(['modinfo','-F','vermagic',str(a.module)]).split()[0]==platform.release()
assert out(['modinfo','-F','name',str(a.module)])=='zram'
assert ':modules_object_t:' in out(['ls','-Zd',str(a.module)])
assert not Path('/sys/module/n100_lz4_probe').exists()
assert sorted(x.name for x in Path('/sys/block').glob('zram*'))==['zram0'],'Inspect other ZRAM devices before replacing the module'
assert read('/sys/kernel/reboot/type')=='pci'
for key in ['panic','panic_on_oops','hardlockup_panic','softlockup_panic']:assert int(read('/proc/sys/kernel/'+key))>0
run(['sysctl','-w','kernel.nmi_watchdog=1'])
assert read('/sys/module/pstore/parameters/backend')=='efi_pstore'
swaps=[line.split() for line in Path('/proc/swaps').read_text().splitlines()[1:]]
assert [x[0] for x in swaps if 'zram' in x[0]]==['/dev/zram0']
assert int(next(x for x in swaps if x[0]=='/dev/zram0')[3])<512*1024
assert sum(int(x[2])-int(x[3]) for x in swaps if 'zram' not in x[0])>1024*1024
mem=dict(line.split(':',1) for line in Path('/proc/meminfo').read_text().splitlines())
assert int(mem['MemAvailable'].split()[0])>1024*1024
units=['dev-zram0.swap','systemd-zram-setup@zram0.service']
for unit in units:
 assert out(['systemctl','is-active',unit])=='active'
 assert not os.path.lexists('/run/systemd/system/'+unit),'Preserve pre-existing runtime unit overrides'
stock=Path(out(['modinfo','-n','zram']));assert 'extra/n100-zram-lab' not in str(stock)
stock_note=build_note(stock);assert Path('/sys/module/zram/notes/.note.gnu.build-id').read_bytes()==stock_note
a.output.mkdir(parents=True)
state={'status':'running','mode':a.mode,'started':time.time(),'kernel':platform.release(),'experimental_sha256':a.validated_sha256,'stock_module':str(stock),'stock_sha256':hashlib.sha256(stock.read_bytes()).hexdigest(),'stock_build_note':stock_note.hex(),'primary_disksize':int(read('/sys/block/zram0/disksize')),'primary_algorithm':read('/sys/block/zram0/comp_algorithm').split('[')[1].split(']')[0],'primary_swap_private':Path('/proc/swaps').read_text()}
def save(**values):
 state.update(values);tmp=a.output/'checkpoint.tmp';tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(a.output/'checkpoint.json')
save();changed=False;experimental=False;masked=False
signal.signal(signal.SIGTERM,lambda *_:(_ for _ in ()).throw(SystemExit('Service terminated; restoring stock ZRAM')))
try:
 save(phase='draining-primary');changed=True;masked=True
 run(['systemctl','mask','--runtime',*units])
 run(['systemctl','stop','dev-zram0.swap'])
 run(['systemctl','stop','systemd-zram-setup@zram0.service'])
 assert not any('zram' in line for line in Path('/proc/swaps').read_text().splitlines()[1:])
 reset_primary();unload();run(['modprobe','lz4hc_compress'])
 run(['insmod',str(a.module),'num_devices=1']);experimental=True
 assert Path('/sys/module/zram/notes/.note.gnu.build-id').read_bytes()==build_note(a.module)
 assert int(read('/sys/block/zram0/disksize'))==0
 assert len(set(a.algorithms))==len(a.algorithms) and 2<=len(a.algorithms)<=5
 assert all(name in read('/sys/block/zram0/comp_algorithm').split() for name in a.algorithms)
 save(phase='benchmarking')
 if a.mode=='io':
  run(['/usr/bin/python3',str(a.benchmark),'--output',str(a.output/'io'),'--algorithms',*a.algorithms,'--repeats','5','--seconds','5','--size-mib','64','--profile'])
  result=a.output/'io/checkpoint.json'
 else:
  pressure_output=a.resume_pressure or a.output/'pressure'
  save(pressure_output_private=str(pressure_output))
  command=['/usr/bin/python3',str(a.benchmark),'--output',str(pressure_output),'--binary',str(a.pressure_binary),'--state-helper',str(a.state_helper),'--repeats',str(a.repeats),'--algorithms',*a.algorithms]
  if a.resume_pressure:command.append('--resume')
  run(command);result=pressure_output/'checkpoint.json'
 assert json.loads(result.read_text())['status']=='complete'
 assert int(read('/sys/block/zram0/disksize'))==0
 assert not any('zram' in line for line in Path('/proc/swaps').read_text().splitlines()[1:])
 save(phase='restoring')
except BaseException as error:
 save(status='failed',error=repr(error));raise
finally:
 if changed:
  try:
   run(['systemctl','stop',*units])
   reset_primary()
   if experimental:unload()
   if not Path('/sys/module/zram').exists():run(['modprobe','zram'])
   if masked:run(['systemctl','unmask','--runtime',*units])
   run(['systemctl','reset-failed',*units])
   run(['systemctl','start','dev-zram0.swap'])
   assert out(['systemctl','is-active','systemd-zram-setup@zram0.service'])=='active'
   assert int(read('/sys/block/zram0/disksize'))==state['primary_disksize']
   assert '['+state['primary_algorithm']+']' in read('/sys/block/zram0/comp_algorithm')
   assert out(['systemctl','is-active','dev-zram0.swap'])=='active'
   assert all(not os.path.lexists('/run/systemd/system/'+unit) for unit in units)
   assert Path(out(['modinfo','-n','zram']))==stock
   assert Path('/sys/module/zram/notes/.note.gnu.build-id').read_bytes()==stock_note
   save(stock_restored=True,phase='finished')
  except BaseException as error:
   save(status='failed',restore_error=repr(error),finished=time.time());raise
save(status='complete',finished=time.time())
