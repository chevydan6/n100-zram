#!/usr/bin/env python3
"""Randomized, bounded direct-I/O ZRAM pilot on one new non-swap device."""
import errno, hashlib, json, mmap, os, pathlib, random, stat, time
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
seed=74219
jobs=[(r,n,a) for r in range(5) for n in names for a in algs]
random.Random(seed).shuffle(jobs)
results={'scope':'Physical N100 direct block I/O pilot, includes syscall and Python overhead; not real swap or energy',
         'kernel':os.uname().release,'seed':seed,'rounds':5,'corpora':{n:hashlib.sha256(d).hexdigest() for n,d in inputs.items()},
         'before':before,'jobs':[],'cleanup':False}
def control_write(path, value):
    for attempt in range(100):
        try:
            path.write_text(value)
            return
        except OSError as error:
            if error.errno != errno.EBUSY or attempt == 99: raise
            time.sleep(.05)
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
            (sys/'comp_algorithm').write_text(alg)
            if '['+alg+']' not in (sys/'comp_algorithm').read_text(): raise RuntimeError('selection failure')
            (sys/'disksize').write_text(str(2*1024*1024))
            data=inputs[name]; buf[:]=data
            fd=os.open(str(dev),os.O_RDWR|os.O_CLOEXEC|os.O_DIRECT)
            try:
                cpu0=time.thread_time_ns(); t0=time.perf_counter_ns()
                n=os.pwritev(fd,[buf],0)
                write_ns=time.perf_counter_ns()-t0; write_cpu_ns=time.thread_time_ns()-cpu0
                if n!=len(data): raise RuntimeError('short write')
                mm=(sys/'mm_stat').read_text().split()
                buf[:]=bytes(len(data))
                cpu0=time.thread_time_ns(); t0=time.perf_counter_ns()
                n=os.preadv(fd,[buf],0)
                read_ns=time.perf_counter_ns()-t0; read_cpu_ns=time.thread_time_ns()-cpu0
                if n!=len(data) or buf[:]!=data: raise RuntimeError('read or data mismatch')
            finally: os.close(fd)
            results['jobs'].append({'round':round_,'corpus':name,'algorithm':alg,'write_ns':write_ns,'write_cpu_ns':write_cpu_ns,
                'read_ns':read_ns,'read_cpu_ns':read_cpu_ns,'orig_bytes':int(mm[0]),'compressed_bytes':int(mm[1]),'allocated_bytes':int(mm[2])})
            control_write(sys/'reset','1')
            if int((sys/'disksize').read_text()): raise RuntimeError('reset failed')
finally:
    if idx is not None and idx>0:
        control_write(P('/sys/class/zram-control/hot_remove'),str(idx))
        results['cleanup']=not P('/sys/block/zram'+str(idx)).exists()
    results['after']=fixed(); results['preserved']=before==results['after']
    print(json.dumps(results,sort_keys=True),flush=True)
if not results['cleanup'] or not results['preserved'] or len(results['jobs'])!=len(jobs): raise SystemExit('incomplete or restoration failure')
