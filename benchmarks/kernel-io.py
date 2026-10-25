#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Root-only, isolated ZRAM I/O baseline. Never resets an existing device."""
from pathlib import Path
import argparse,subprocess,os,json,time,random,hashlib,platform,errno,threading
parser=argparse.ArgumentParser()
parser.add_argument('--identical-read-fixture',action='store_true')
parser.add_argument('--compress-percentage',type=int,choices=[0,25,50,75,100],default=50)
parser.add_argument('--output',type=Path,required=True)
parser.add_argument('--algorithms',nargs='+',default=['lzo-rle','lz4'])
parser.add_argument('--seconds',type=int,default=5)
parser.add_argument('--repeats',type=int,default=3)
parser.add_argument('--size-mib',type=int,default=64)
parser.add_argument('--profile',action='store_true')
parser.add_argument('--counters',action='store_true')
parser.add_argument('--telemetry',action='store_true')
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
def write(path,value):
 for attempt in range(40):
  try:Path(path).write_text(str(value));return
  except OSError as error:
   if error.errno!=errno.EBUSY or attempt==39:raise
   time.sleep(.25)
index=None;owned=False
try:
 save(source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),kernel=platform.release(),started=time.time())
 metadata={'identical_read_fixture':a.identical_read_fixture,'compress_percentage':a.compress_percentage,'size_mib':a.size_mib,'kernel':platform.release(),'compiler':subprocess.check_output(['gcc','--version'],text=True),'fio':subprocess.check_output(['fio','--version'],text=True).strip(),'before':snapshot(),'recovery_policy':{name:read('/proc/sys/kernel/'+name) for name in ['panic','nmi_watchdog','hardlockup_panic','softlockup_panic']},'primary_swap':Path('/proc/swaps').read_text(),'zram_module_srcversion':read('/sys/module/zram/srcversion') if Path('/sys/module/zram/srcversion').exists() else None,'kernel_config_sha256':hashlib.sha256(Path('/boot/config-'+platform.release()).read_bytes()).hexdigest()}
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
 subprocess.run(['udevadm','settle','--timeout=10'],check=True)
 available=read(sys/'comp_algorithm').replace('[','').replace(']','').split()
 assert all(algorithm in available for algorithm in a.algorithms),(a.algorithms,available)
 save(device=str(device))
 base=['fio','--name=n100-zram','--filename='+str(device),'--size='+str(a.size_mib)+'M','--bs=4k','--ioengine=psync','--direct=1','--numjobs=1','--thread=1','--cpus_allowed=0','--randseed=100','--randrepeat=1','--group_reporting=1','--eta=never','--output-format=json','--buffer_compress_percentage='+str(a.compress_percentage),'--buffer_compress_chunk=4096','--refill_buffers=1']
 def fio(label,options,measure=False,profile=False):
  command=base+options
  if profile:command=['perf','record','-q','-g','-F','199','-e','cycles:k','-o',str(a.output/(label+'.perf.data')),'--']+command
  if measure and a.counters:
   command=['perf','stat','-a','-C','0','-x,','--no-big-num','-e','cycles,instructions,msr/aperf/,msr/mperf/','-o',str(a.output/(label+'.counters.csv')),'--']+command
  before=snapshot();ebefore=energy();start=time.monotonic_ns();stop=threading.Event()
  def sample():
   with (a.output/(label+'.telemetry-private.jsonl')).open('w',buffering=1) as log:
    while not stop.is_set():log.write(json.dumps(snapshot())+'\n');stop.wait(.5)
  sampler=None
  if measure and a.telemetry:sampler=threading.Thread(target=sample,daemon=True);sampler.start()
  try:
   with (a.output/(label+'.json')).open('w') as output,(a.output/(label+'.stderr')).open('w') as error:
    subprocess.run(command,stdout=output,stderr=error,check=True)
  finally:
   stop.set()
   if sampler:sampler.join(timeout=3)
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
  if a.identical_read_fixture:
   from fixed_pages import transfer
   fixture_sha=transfer(device,a.size_mib*1024*1024,a.compress_percentage)
   (a.output/(label+'-fixture.json')).write_text(json.dumps({'sha256':fixture_sha,'bytes':a.size_mib*1024*1024,'zero_percentage':a.compress_percentage})+'\n')
  else:fio(label+'-fill',['--rw=write','--verify=crc32c','--do_verify=0','--end_fsync=1'])
  for operation in (['randread'] if a.identical_read_fixture else ['randread','randwrite']):
   extra=['--verify=crc32c','--do_verify=0'] if operation=='randwrite' else ['--readonly']
   fio(label+'-'+operation+'-warm',['--rw='+operation,'--time_based=1','--runtime=1']+extra)
   fio(label+'-'+operation,['--rw='+operation,'--time_based=1','--runtime='+str(a.seconds)]+extra,measure=True)
  if a.identical_read_fixture:
   assert transfer(device,a.size_mib*1024*1024,a.compress_percentage,verify=True)==fixture_sha
   (a.output/(label+'-fixture-verify.json')).write_text(json.dumps({'sha256':fixture_sha,'status':'passed'})+'\n')
  else:fio(label+'-verify',['--rw=read','--verify=crc32c','--verify_only=1'])
  if a.profile and trial==0:
   fio(label+'-profile',['--rw=randread','--time_based=1','--runtime=3','--readonly'],profile=True)
   report=subprocess.check_output(['perf','report','--stdio','--no-children','--sort','symbol','--percent-limit','1','-i',str(a.output/(label+'-profile.perf.data'))],text=True,stderr=subprocess.STDOUT)
   (a.output/(label+'-profile.txt')).write_text(report)
  if a.profile and trial==0 and a.identical_read_fixture:
   assert transfer(device,a.size_mib*1024*1024,a.compress_percentage,verify=True)==fixture_sha
  if a.profile and trial==0 and not a.identical_read_fixture:
   fio(label+'-write-profile',['--rw=randwrite','--time_based=1','--runtime=3','--verify=crc32c','--do_verify=0'],profile=True)
   report=subprocess.check_output(['perf','report','--stdio','--no-children','--sort','symbol','--percent-limit','1','-i',str(a.output/(label+'-write-profile.perf.data'))],text=True,stderr=subprocess.STDOUT)
   (a.output/(label+'-write-profile.txt')).write_text(report)
   fio(label+'-profile-verify',['--rw=read','--verify=crc32c','--verify_only=1'])
 save(status='complete',finished=time.time())
except BaseException as error:
 save(status='failed',error=repr(error),finished=time.time());raise
finally:
 if owned:
  sys=Path('/sys/block')/f'zram{index}'
  if sys.exists():
   write(sys/'reset',1);write('/sys/class/zram-control/hot_remove',index)
