#!/usr/bin/env python3
"""Bounded cgroup workload using a temporary high-priority ZRAM swap device."""
import errno, json, os, pathlib, random, signal, subprocess, time
P=pathlib.Path
assert os.geteuid()==0 and os.uname().release=='7.2.11-n100-gzram-btf'
root=P('/sys/block/zram0')
def snapshot():
 return {'algorithm':(root/'comp_algorithm').read_text(),'disksize':(root/'disksize').read_text(),
         'swaps':[(q[0],q[1],q[-1]) for line in P('/proc/swaps').read_text().splitlines()[1:] if (q:=line.split())]}
def available():
 return int(next(x.split()[1] for x in P('/proc/meminfo').read_text().splitlines() if x.startswith('MemAvailable:')))*1024
before=snapshot(); assert '[zstd]' in before['algorithm'] and any(s[0]=='/dev/zram0' for s in before['swaps'])
assert available()>1024*1024*1024
base=P('/home/dan/n100-zram'); workload=base/'benchmarks/results/terra-native-browser-pressure-002/workload.py'
rng=random.Random(52734); jobs=[]
for r in range(2):
 order=['lz4','lzo-rle','ghy-bitdirect']; rng.shuffle(order); order.insert(0,'zstd'); jobs.extend((r,x) for x in order)
result={'scope':'Bounded generated browser and compiler workload; not user browsing', 'kernel':os.uname().release,'before':before,'seed':52734,'trials':[],'cleanup':False}
idx=None; active=False; unit=None
energy=P('/sys/class/powercap/intel-rapl:0/energy_uj'); max_e=int(P('/sys/class/powercap/intel-rapl:0/max_energy_range_uj').read_text())
def e(): return int(energy.read_text())
def control(path,value):
 for i in range(100):
  try: path.write_text(value); return
  except OSError as x:
   if x.errno!=errno.EBUSY or i==99: raise
   time.sleep(.05)
def stop(n,frame): raise InterruptedError('signal '+str(n))
signal.signal(signal.SIGTERM,stop)
try:
 idx=int(P('/sys/class/zram-control/hot_add').read_text()); assert idx>0
 sys=P('/sys/block/zram'+str(idx)); dev=P('/dev/zram'+str(idx))
 for _ in range(100):
  if dev.exists(): break
  time.sleep(.05)
 assert dev.exists() and not any(s[0]==str(dev) for s in before['swaps']) and int((sys/'disksize').read_text())==0
 for seq,(round_,alg) in enumerate(jobs):
  if available()<768*1024*1024: raise RuntimeError('insufficient available RAM for safe cleanup')
  if int(P('/sys/class/power_supply/BAT0/capacity').read_text())<20: raise RuntimeError('battery below 20 percent')
  (sys/'comp_algorithm').write_text(alg); assert '['+alg+']' in (sys/'comp_algorithm').read_text()
  (sys/'disksize').write_text(str(128*1024*1024))
  subprocess.run(['/usr/sbin/mkswap',str(dev)],check=True,capture_output=True,text=True)
  subprocess.run(['/usr/sbin/swapon','--priority','32760',str(dev)],check=True,capture_output=True,text=True); active=True
  unit='gzram-browser-pilot-'+str(os.getpid())+'-'+str(seq)
  userenv=['runuser','-u','dan','--','env','XDG_RUNTIME_DIR=/run/user/1000','DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus']
  cmd=userenv+['systemd-run','--user','--quiet','--wait','--pipe','--collect','--unit='+unit,
       '--property=MemoryAccounting=yes','--property=MemoryHigh=256M','--property=MemoryMax=640M',
       '--property=MemorySwapMax=128M','--property=TasksMax=512','/usr/bin/python3',str(workload)]
  e0=e(); t0=time.monotonic(); proc=subprocess.Popen(cmd,stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
  samples=[]; cg=P('/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice')/(unit+'.service')
  while proc.poll() is None:
   if time.monotonic()-t0>150: proc.terminate(); raise RuntimeError('workload timeout')
   sample={'t':time.monotonic()-t0,'available':available(),'mm_stat':(sys/'mm_stat').read_text().strip()}
   for key in ('memory.current','memory.swap.current','memory.events','memory.pressure','cpu.stat'):
    try: sample[key]=(cg/key).read_text().strip()
    except OSError: pass
   samples.append(sample);time.sleep(.5)
  stdout,stderr=proc.communicate(); e1=e(); elapsed=time.monotonic()-t0
  if proc.returncode:
   result['failed_trial']={'round':round_,'algorithm':alg,'stderr':stderr,'stdout':stdout,'samples':samples,'elapsed_s':elapsed}; raise RuntimeError('workload failed; details retained in result')
  payload=json.loads(stdout.strip().splitlines()[-1]); mm=(sys/'mm_stat').read_text().strip()
  result['trials'].append({'round':round_,'algorithm':alg,'workload':payload,'elapsed_s':elapsed,'package_uj':(e1-e0)%max_e,'device_mm_stat':mm,'samples':samples})
  subprocess.run(['/usr/sbin/swapoff',str(dev)],check=True,timeout=120,capture_output=True,text=True);active=False
  control(sys/'reset','1'); unit=None
finally:
 if unit: subprocess.run(['runuser','-u','dan','--','env','XDG_RUNTIME_DIR=/run/user/1000','DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus','systemctl','--user','stop',unit],timeout=30,check=False,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
 if active: subprocess.run(['/usr/sbin/swapoff',str(dev)],check=True,timeout=120,capture_output=True,text=True);active=False
 if idx is not None and idx>0:
  control(P('/sys/class/zram-control/hot_remove'),str(idx));result['cleanup']=not P('/sys/block/zram'+str(idx)).exists()
 result['after']=snapshot();result['preserved']=before==result['after'];print(json.dumps(result,sort_keys=True),flush=True)
if not result['cleanup'] or not result['preserved'] or len(result['trials'])!=len(jobs): raise SystemExit('incomplete or restoration failed')
