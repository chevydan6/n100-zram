#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Owned-device ZRAM pressure trials with bounded cgroups and resumable checkpoints."""
import argparse,errno,hashlib,json,os,platform,random,shutil,signal,subprocess,tempfile,threading,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);p.add_argument('--binary',type=Path,required=True);p.add_argument('--state-helper',type=Path,required=True);p.add_argument('--algorithms',nargs='+',default=['lzo-rle','lz4','lz4-n100','lz4-rep8']);p.add_argument('--corpora',nargs='+',choices=['period-tail','mixed-pages'],default=['period-tail','mixed-pages']);p.add_argument('--repeats',type=int,default=3);p.add_argument('--resume',action='store_true');a=p.parse_args()
assert os.geteuid()==0 and 1<=a.repeats<=5
os.sched_setaffinity(0,{1})  # Keep the sampler off the measured workload CPU.
assert all(x in ['lzo-rle','lz4','lz4-n100','lz4-rep8','lz4-small','lz4-control','lz4-mid'] for x in a.algorithms)
def read(name):return Path(name).read_text().strip()
def run(args,**kwargs):return subprocess.run(args,check=True,**kwargs)
def write(name,value):
 for attempt in range(40):
  try:Path(name).write_text(str(value));return
  except OSError as error:
   if error.errno!=errno.EBUSY or attempt==39:raise
   time.sleep(.25)  # Bounded wait for udev/blkid's transient block-device opens.
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
inputs={'binary':sha(a.binary),'state_helper':sha(a.state_helper),'script':sha(Path(__file__)),'kernel':platform.release(),'module_note':Path('/sys/module/zram/notes/.note.gnu.build-id').read_bytes().hex(),'algorithms':a.algorithms,'corpora':a.corpora,'repeats':a.repeats}
if a.output.exists():
 assert a.resume,'Preserve existing evidence; explicitly resume unchanged inputs'
 state=json.loads((a.output/'checkpoint.json').read_text());assert state['inputs']==inputs
else:a.output.mkdir(parents=True);state={'inputs':inputs,'completed':{},'attempts':{},'started':time.time()}
def save(**values):
 state.update(values);tmp=a.output/'checkpoint.tmp';tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(a.output/'checkpoint.json')
def snapshot(sys):
 result={'time':time.time(),'vmstat':{k:int(v) for k,v in (line.split() for line in Path('/proc/vmstat').read_text().splitlines()) if k in ['pswpin','pswpout','pgmajfault']},'mm_stat':read(sys/'mm_stat'),'io_stat':read(sys/'io_stat'),'swap_private':Path('/proc/swaps').read_text()}
 for pattern in ['/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor','/sys/class/thermal/thermal_zone*/temp']:
  import glob
  for name in glob.glob(pattern):
   try:result[name]=read(name)
   except OSError:pass
 return result
rapl=[(path,int(read(path.parent/'max_energy_range_uj'))) for path in Path('/sys/class/powercap').glob('intel-rapl:*/energy_uj') if path.parent.name.count(':')==1]
def energy():return {str(path):int(read(path)) for path,_ in rapl}
log_root=Path('/var/log/n100-zram-lab');log_root.mkdir(mode=0o700,exist_ok=True);run(['restorecon',str(log_root)])
index=None;owned=False;active_swap=False;child=None
signal.signal(signal.SIGTERM,lambda *_:(_ for _ in ()).throw(SystemExit('Terminated; clean up child and owned swap')))
try:
 save(status='running')
 index=int(read('/sys/class/zram-control/hot_add'));sys=Path('/sys/block')/f'zram{index}';device=Path('/dev')/f'zram{index}'
 assert index!=0 and int(read(sys/'disksize'))==0 and str(device) not in Path('/proc/swaps').read_text();owned=True
 for _ in range(100):
  if device.exists():break
  time.sleep(.05)
 assert device.exists()
 run(['udevadm','settle','--timeout=10'])
 assert all(algorithm in read(sys/'comp_algorithm').replace('[','').replace(']','').split() for algorithm in a.algorithms)
 order=[(trial,algorithm,corpus) for trial in range(a.repeats) for algorithm in a.algorithms for corpus in a.corpora];random.Random(100).shuffle(order)
 for trial,algorithm,corpus in order:
  label=f'{algorithm}-{corpus}-trial-{trial}'
  if label in state['completed']:continue
  attempt=state['attempts'].get(label,0);state['attempts'][label]=attempt+1
  folder=a.output/label/f'attempt-{attempt}';folder.mkdir(parents=True);save(current=label)
  write(sys/'reset',1);write(sys/'comp_algorithm',algorithm);write(sys/'disksize',64*1024*1024)
  # Four separate CPUs/workspaces, disjoint page offsets, all sixteen YMM registers.
  jobs=[];logs=[]
  try:
   for cpu in range(4):
    log=(folder/f'fpu-{cpu}.log').open('w');logs.append(log)
    jobs.append(subprocess.Popen(['taskset','-c',str(cpu),str(a.state_helper),str(device),str(cpu)],stdout=log,stderr=subprocess.STDOUT))
   codes=[job.wait(timeout=30) for job in jobs];assert codes==[0]*4
  finally:
   for job in jobs:
    if job.poll() is None:job.kill();job.wait()
   for log in logs:log.close()
  assert all('FPU_STATE_PASS' in (folder/f'fpu-{cpu}.log').read_text() for cpu in range(4))
  write(sys/'reset',1);write(sys/'comp_algorithm',algorithm);write(sys/'disksize',1024*1024*1024)
  run(['mkswap',str(device)],stdout=subprocess.DEVNULL)
  run(['swapon','--priority','200','--discard',str(device)]);active_swap=True
  before=snapshot(sys);ebefore=energy();started=time.monotonic_ns();stop=threading.Event()
  def sample():
   with (folder/'telemetry-private.jsonl').open('w',buffering=1) as log:
    while not stop.is_set():log.write(json.dumps(snapshot(sys))+'\n');stop.wait(.5)
  sampler=threading.Thread(target=sample,daemon=True);sampler.start()
  child='n100-zram-pressure-'+str(os.getpid())+'-'+str(time.monotonic_ns())
  unit_logs=Path(tempfile.mkdtemp(prefix='pressure-',dir=log_root))
  for name in ['stdout','stderr']:(unit_logs/name).touch(mode=0o600)
  run(['restorecon','-R',str(unit_logs)])
  command=['systemd-run','--quiet','--wait','--collect','--unit='+child,'--property=StandardOutput=append:'+str(unit_logs/'stdout'),'--property=StandardError=append:'+str(unit_logs/'stderr'),'--property=MemoryMax=384M','--property=MemoryHigh=320M','--property=MemorySwapMax=1G','--property=CPUQuota=100%','--property=CPUAffinity=0','--property=RuntimeMaxSec=180','--property=OOMPolicy=stop',str(a.binary)]
  if corpus=='mixed-pages':command.append('--mixed-pages')
  try:
   launched=subprocess.run(command,capture_output=True,text=True)
   (folder/'launcher.log').write_text(launched.stdout+launched.stderr)
   shutil.copyfile(unit_logs/'stdout',folder/'workload.jsonl');shutil.copyfile(unit_logs/'stderr',folder/'stderr.log')
   if launched.returncode:raise RuntimeError('Pressure unit failed: '+launched.stderr)
  finally:stop.set();sampler.join(timeout=3)
  elapsed=time.monotonic_ns()-started;eafter=energy();after=snapshot(sys)
  records=[json.loads(line) for line in (folder/'workload.jsonl').read_text().splitlines()]
  assert records[-1]=={'status':'passed'}
  assert len([r for r in records if r.get('phase')=='verify'])==3
  health=next(r for r in records if r.get('phase')=='cgroup_health');assert all(health['memory_events'].get(k,0)==0 for k in ['oom','oom_kill','oom_group_kill'])
  delta={key:after['vmstat'][key]-before['vmstat'][key] for key in before['vmstat']}
  assert delta['pswpin']>100000 and delta['pswpout']>100000,'Workload did not exercise enough real swapping'
  assert all(int(x)==0 for x in after['io_stat'].split()[:2]),'Device read/write failure'
  result={'status':'passed','algorithm':algorithm,'corpus':corpus,'trial':trial,'elapsed_ns':elapsed,'package_energy_uj':{str(path):(eafter[str(path)]-ebefore[str(path)])%maximum for path,maximum in rapl},'energy_scope':'whole package over workload including systemd startup and background activity','vmstat_delta':delta,'before':before,'after':after,'workload':records,'fpu_processes':4,'scope':'768 MiB working set, 384 MiB memcg maximum, actual installed 4 GiB N100; controlled reclaim, not whole-machine OOM'}
  (folder/'result-private.json').write_text(json.dumps(result,indent=2)+'\n')
  run(['swapoff',str(device)]);active_swap=False;write(sys/'reset',1);child=None
  state['completed'][label]=str(folder.relative_to(a.output));save()
 save(status='cleaning',current=None)
except BaseException as error:save(status='failed',error=repr(error),finished=time.time());raise
finally:
 try:
  if child:subprocess.run(['systemctl','stop',child],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
  if active_swap:run(['swapoff',str(device)])
  if owned and sys.exists():write(sys/'reset',1);write('/sys/class/zram-control/hot_remove',index)
 except BaseException as error:save(status='failed',cleanup_error=repr(error),finished=time.time());raise
save(status='complete',cleanup_verified=True,finished=time.time())
