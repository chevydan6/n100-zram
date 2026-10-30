#!/usr/bin/env python3
"""Randomized, bounded direct-I/O ZRAM pilot on one new non-swap device."""
import errno, hashlib, json, mmap, os, pathlib, random, signal, stat, time
P=pathlib.Path
assert os.geteuid()==0 and os.uname().release=='7.2.11-n100-gzram-btf'
root=P('/sys/block/zram0')
def fixed():
    return {'algorithm':(root/'comp_algorithm').read_text(),'disksize':(root/'disksize').read_text(),
            'swaps':[(line.split()[0],line.split()[1],line.split()[-1]) for line in P('/proc/swaps').read_text().splitlines()[1:]]}
before=fixed()
assert '[zstd]' in before['algorithm'] and any(s[0]=='/dev/zram0' for s in before['swaps'])
base=P('/home/dan/n100-zram/build/astra-zram-corpora-001')
names=['bash-elf','libc-elf','sparse-words','repeat8','period127','mixed-pages','clusters50','random']
inputs={n:(base/(n+'.bin')).read_bytes() for n in names}
assert all(len(d)==128*4096 for d in inputs.values())
algs=['ghy-bitdirect','ghy-simd','lz4-ghy','lz4','zstd','lzo-rle']
seed=94221
rng=random.Random(seed)
jobs=[]
for r in range(9):
    order=names.copy(); rng.shuffle(order)
    for n in order:
        variants=algs.copy(); rng.shuffle(variants)
        jobs.extend((r,n,a) for a in variants)
results={'scope':'Physical N100 direct block I/O with package energy; includes syscall and Python overhead, not swap or battery life',
         'kernel':os.uname().release,'seed':seed,'rounds':9,'batch_seconds':2,'corpora':{n:hashlib.sha256(d).hexdigest() for n,d in inputs.items()},
         'before':before,'jobs':[],'cleanup':False}
def control_write(path, value):
    for attempt in range(100):
        try:
            path.write_text(value)
            return
        except OSError as error:
            if error.errno != errno.EBUSY or attempt == 99: raise
            time.sleep(.05)
energy_path=P('/sys/class/powercap/intel-rapl:0/energy_uj')
try:
    energy_fd=os.open(str(energy_path),os.O_RDONLY|os.O_CLOEXEC)
    energy_range=int(P('/sys/class/powercap/intel-rapl:0/max_energy_range_uj').read_text())
    def energy(): return int(os.pread(energy_fd,64,0))
except OSError:
    energy_fd=None; energy_range=None
    def energy(): return None
def delta(start,end):
    return (end-start)%energy_range if start is not None and end is not None else None
results['energy_scope']='Package RAPL includes other activity; not whole-system energy or battery life'
results['energy_range_uj']=energy_range
def stop(signum, frame):
    raise InterruptedError('Received signal '+str(signum))
signal.signal(signal.SIGTERM,stop)
progress=P('/home/dan/n100-zram/build/terra-native-energy-hour-001-progress.jsonl')
assert not progress.exists()
idx=None
try:
    idx=int(P('/sys/class/zram-control/hot_add').read_text())
    if idx<=0: raise RuntimeError('Refusing active device')
    sys=P('/sys/block/zram'+str(idx)); dev=P('/dev/zram'+str(idx))
    for _ in range(100):
        if dev.exists(): break
        time.sleep(.05)
    if not stat.S_ISBLK(dev.stat().st_mode) or any(s[0]==str(dev) for s in fixed()['swaps']): raise RuntimeError('not a dedicated device')
    if int((sys/'disksize').read_text()): raise RuntimeError('device already initialized')
    with mmap.mmap(-1,128*4096) as buf:
        for round_,name,alg in jobs:
            battery=P('/sys/class/power_supply/BAT0/capacity')
            if battery.exists() and int(battery.read_text()) < 20: raise RuntimeError('Battery below 20 percent; stopping')
            (sys/'comp_algorithm').write_text(alg)
            if '['+alg+']' not in (sys/'comp_algorithm').read_text(): raise RuntimeError('selection failure')
            (sys/'disksize').write_text(str(2*1024*1024))
            data=inputs[name]; buf[:]=data
            fd=os.open(str(dev),os.O_RDWR|os.O_CLOEXEC|os.O_DIRECT)
            try:
                if os.pwritev(fd,[buf],0)!=len(data): raise RuntimeError('warmup write failed')
                e0=energy(); cpu0=time.thread_time_ns(); t0=time.perf_counter_ns(); wn=0
                while time.perf_counter_ns()-t0 < 2_000_000_000:
                    if os.pwritev(fd,[buf],0)!=len(data): raise RuntimeError('short write')
                    wn+=1
                write_ns=time.perf_counter_ns()-t0; write_cpu_ns=time.thread_time_ns()-cpu0; e1=energy()
                mm=(sys/'mm_stat').read_text().split()
                buf[:]=bytes(len(data))
                e2=energy(); cpu0=time.thread_time_ns(); t0=time.perf_counter_ns(); rn=0
                while time.perf_counter_ns()-t0 < 2_000_000_000:
                    if os.preadv(fd,[buf],0)!=len(data): raise RuntimeError('short read')
                    rn+=1
                read_ns=time.perf_counter_ns()-t0; read_cpu_ns=time.thread_time_ns()-cpu0; e3=energy()
                if buf[:]!=data: raise RuntimeError('read data mismatch')
            finally: os.close(fd)
            results['jobs'].append({'round':round_,'corpus':name,'algorithm':alg,'write_ns':write_ns,'write_cpu_ns':write_cpu_ns,
                'read_ns':read_ns,'read_cpu_ns':read_cpu_ns,'write_operations':wn,'read_operations':rn,'write_package_uj':delta(e0,e1),'read_package_uj':delta(e2,e3),'orig_bytes':int(mm[0]),'compressed_bytes':int(mm[1]),'allocated_bytes':int(mm[2])})
            with progress.open('a') as log: log.write(json.dumps(results['jobs'][-1],sort_keys=True)+'\n'); log.flush(); os.fsync(log.fileno())
            control_write(sys/'reset','1')
            if int((sys/'disksize').read_text()): raise RuntimeError('reset failed')
finally:
    if idx is not None and idx>0:
        control_write(P('/sys/class/zram-control/hot_remove'),str(idx))
        results['cleanup']=not P('/sys/block/zram'+str(idx)).exists()
    if energy_fd is not None: os.close(energy_fd)
    results['after']=fixed(); results['preserved']=before==results['after']
    print(json.dumps(results,sort_keys=True),flush=True)
if not results['cleanup'] or not results['preserved'] or len(results['jobs'])!=len(jobs): raise SystemExit('incomplete or restoration failure')
