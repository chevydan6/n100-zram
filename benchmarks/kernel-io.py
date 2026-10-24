#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Root-only, isolated ZRAM I/O baseline. Never resets an existing device."""
from pathlib import Path
import argparse,subprocess,os,json,time,random,hashlib,platform
parser=argparse.ArgumentParser()
parser.add_argument('--output',type=Path,required=True)
parser.add_argument('--algorithms',nargs='+',default=['lzo-rle','lz4'])
parser.add_argument('--seconds',type=int,default=5)
parser.add_argument('--repeats',type=int,default=3)
parser.add_argument('--size-mib',type=int,default=64)
parser.add_argument('--profile',action='store_true')
a=parser.parse_args()
if os.geteuid()!=0:raise SystemExit('Root is required for a separate test device')
if not (1<=a.seconds<=30 and 1<=a.repeats<=10 and 4<=a.size_mib<=256):raise SystemExit('Outside bounded experiment limits')
if a.output.exists():raise SystemExit('Use a fresh output directory; existing evidence is never overwritten')
a.output.mkdir(parents=True);state={'status':'running','completed':[]}
def save(**values):
 state.update(values);tmp=a.output/'checkpoint.tmp';tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(a.output/'checkpoint.json')
def read(path):return Path(path).read_text().strip()
def snapshot():
 result={'time':time.time(),'load':read('/proc/loadavg')}
 for pattern in ['/sys/class/thermal/thermal_zone*/temp','/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor']:
  import glob
  for name in glob.glob(pattern):
   try:result[name]=read(name)
   except OSError:pass
 return result
rapl=[]
for energy in Path('/sys/class/powercap').glob('intel-rapl:*/energy_uj'):
 if energy.parent.name.count(':')!=1:continue
 rapl.append((energy,int(read(energy.parent/'max_energy_range_uj'))))
def energy():return {str(path):int(read(path)) for path,_ in rapl}
def write(path,value):Path(path).write_text(str(value))
index=None;owned=False
try:
 save(source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),kernel=platform.release(),started=time.time())
 metadata={'kernel':platform.release(),'compiler':subprocess.check_output(['gcc','--version'],text=True),'fio':subprocess.check_output(['fio','--version'],text=True).strip(),'before':snapshot(),'recovery_policy':{name:read('/proc/sys/kernel/'+name) for name in ['panic','nmi_watchdog','hardlockup_panic','softlockup_panic']},'primary_swap':Path('/proc/swaps').read_text(),'zram_module_srcversion':read('/sys/module/zram/srcversion') if Path('/sys/module/zram/srcversion').exists() else None,'kernel_config_sha256':hashlib.sha256(Path('/boot/config-'+platform.release()).read_bytes()).hexdigest()}
 (a.output/'environment-private.json').write_text(json.dumps(metadata,indent=2)+'\n')
 index=int(read('/sys/class/zram-control/hot_add'))
 sys=Path('/sys/block')/f'zram{index}';device=Path('/dev')/f'zram{index}'
 assert index!=0 and int(read(sys/'disksize'))==0
 assert str(device) not in Path('/proc/swaps').read_text()
 owned=True
 for _ in range(100):
  if device.exists():break
  time.sleep(.05)
 assert device.exists()
 available=read(sys/'comp_algorithm').replace('[','').replace(']','').split()
 assert all(algorithm in available for algorithm in a.algorithms),(a.algorithms,available)
 save(device=str(device))
 base=['fio','--name=n100-zram','--filename='+str(device),'--size='+str(a.size_mib)+'M','--bs=4k','--ioengine=psync','--direct=1','--numjobs=1','--thread=1','--cpus_allowed=0','--randseed=100','--randrepeat=1','--group_reporting=1','--eta=never','--output-format=json','--buffer_compress_percentage=50','--buffer_compress_chunk=4096','--refill_buffers=1']
 def fio(label,options,measure=False,profile=False):
  command=base+options
  if profile:command=['perf','record','-q','-g','-F','199','-e','cycles:k','-o',str(a.output/(label+'.perf.data')),'--']+command
  before=snapshot();ebefore=energy();start=time.monotonic_ns()
  with (a.output/(label+'.json')).open('w') as output,(a.output/(label+'.stderr')).open('w') as error:
   subprocess.run(command,stdout=output,stderr=error,check=True)
  elapsed=time.monotonic_ns()-start;eafter=energy();after=snapshot()
  data=json.loads((a.output/(label+'.json')).read_text());assert all(job['error']==0 for job in data['jobs'])
  if measure:
   io=sum(job['read']['total_ios']+job['write']['total_ios'] for job in data['jobs'])
   record={'before':before,'after':after,'elapsed_ns':elapsed,'completed_ios':io,'package_energy_uj':{str(path):(eafter[str(path)]-ebefore[str(path)])%maximum for path,maximum in rapl},'energy_scope':'whole package over entire fio process, including startup and background work','zram_mm_stat':read(sys/'mm_stat')}
   (a.output/(label+'.metrics.json')).write_text(json.dumps(record,indent=2)+'\n')
  state['completed'].append(label);save()
 order=[(trial,algorithm) for trial in range(a.repeats) for algorithm in a.algorithms]
 random.Random(100).shuffle(order)
 for trial,algorithm in order:
  label=f'{algorithm}-trial-{trial}'
  write(sys/'reset',1);write(sys/'comp_algorithm',algorithm);write(sys/'disksize',a.size_mib*1024*1024)
  fio(label+'-fill',['--rw=write','--verify=crc32c','--do_verify=0','--end_fsync=1'])
  for operation in ['randread','randwrite']:
   extra=['--verify=crc32c','--do_verify=0'] if operation=='randwrite' else ['--readonly']
   fio(label+'-'+operation+'-warm',['--rw='+operation,'--time_based=1','--runtime=1']+extra)
   fio(label+'-'+operation,['--rw='+operation,'--time_based=1','--runtime='+str(a.seconds)]+extra,measure=True)
  fio(label+'-verify',['--rw=read','--verify=crc32c','--verify_only=1'])
  if a.profile and trial==0:
   fio(label+'-profile',['--rw=randread','--time_based=1','--runtime=3','--readonly'],profile=True)
   report=subprocess.check_output(['perf','report','--stdio','--no-children','--sort','symbol','--percent-limit','1','-i',str(a.output/(label+'-profile.perf.data'))],text=True,stderr=subprocess.STDOUT)
   (a.output/(label+'-profile.txt')).write_text(report)
 save(status='complete',finished=time.time())
except BaseException as error:
 save(status='failed',error=repr(error),finished=time.time());raise
finally:
 if owned:
  sys=Path('/sys/block')/f'zram{index}'
  if sys.exists():
   write(sys/'reset',1);write('/sys/class/zram-control/hot_remove',index)
