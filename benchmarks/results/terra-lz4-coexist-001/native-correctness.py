#!/usr/bin/env python3
"""Bounded physical ZRAM round trips on a newly hot-added non-swap device."""
import concurrent.futures, hashlib, json, mmap, os, pathlib, stat, subprocess, time
P = pathlib.Path
assert os.geteuid() == 0
assert os.uname().release == '7.2.11-n100-gzram-btf'
root = P('/sys/block/zram0')
def fixed():
    return {'algorithm': (root/'comp_algorithm').read_text(), 'disksize': (root/'disksize').read_text(),
            'swaps': P('/proc/swaps').read_text()}
before=fixed()
assert '[zstd]' in before['algorithm'] and '/dev/zram0' in before['swaps']
corpus_dir=P('/home/dan/n100-zram/build/astra-zram-corpora-001')
names=['bash-elf','libc-elf','sparse-words','repeat8','period127','mixed-pages','clusters50','random']
inputs=[(name,(corpus_dir/(name+'.bin')).read_bytes()) for name in names]
assert all(len(data)==128*4096 for _,data in inputs)
pages=[data[i:i+4096] for _,data in inputs for i in range(0,len(data),4096)]
result={'kernel':os.uname().release,'scope':'Dedicated physical zram device correctness only; no performance or recovery claim',
        'corpora':{name:hashlib.sha256(data).hexdigest() for name,data in inputs},'before':before,'algorithms':{},'cleanup':False}
module=P('/home/dan/n100-zram/build/terra-lz4-coexist-001/n100_zram.ko')
assert hashlib.sha256(module.read_bytes()).hexdigest()=='b233b00e47d022a8c241af06603c54a9de2c38324022bb703d058929c99ceec8'
assert not P('/sys/module/n100_zram').exists()
subprocess.run(['/usr/sbin/insmod',str(module),'num_devices=0'],check=True)
idx=None
try:
    assert P('/sys/class/n100-zram-control/hot_add').exists()
    idx=int(P('/sys/class/n100-zram-control/hot_add').read_text().strip())
    if idx<0: raise RuntimeError('Refusing active or invalid device index')
    dev=P('/dev/n100zram'+str(idx)); sys=P('/sys/block/n100zram'+str(idx))
    for _ in range(100):
        if dev.exists(): break
        time.sleep(.05)
    st=dev.stat()
    if not stat.S_ISBLK(st.st_mode) or str(dev) in P('/proc/swaps').read_text(): raise RuntimeError('Unexpected device or active swap')
    if int((sys/'disksize').read_text()) != 0: raise RuntimeError('New device already initialized')
    for alg in ['lz4-small','lz4-control','lz4','zstd','lzo-rle']:
        (sys/'comp_algorithm').write_text(alg)
        if '['+alg+']' not in (sys/'comp_algorithm').read_text(): raise RuntimeError('algorithm selection failed')
        (sys/'disksize').write_text(str(16*1024*1024))
        fd=os.open(str(dev),os.O_RDWR|os.O_CLOEXEC|os.O_DIRECT)
        def work(worker):
            checks=0
            with mmap.mmap(-1,4096) as buf:
                for i in range(worker,len(pages),4):
                    expected=pages[i]; offset=i*4096; buf[:]=expected
                    if os.pwritev(fd,[buf],offset)!=4096: raise RuntimeError('short write')
                    buf[:]=bytes(4096)
                    if os.preadv(fd,[buf],offset)!=4096 or buf[:]!=expected: raise RuntimeError('round trip mismatch')
                    checks+=1
            return checks
        try:
            with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
                checks=sum(pool.map(work,range(4)))
            with mmap.mmap(-1,4096) as buf:
                for i in range(len(pages)-1,-1,-1):
                    if os.preadv(fd,[buf],i*4096)!=4096 or buf[:]!=pages[i]: raise RuntimeError('independent read mismatch')
                    checks+=1
        finally: os.close(fd)
        result['algorithms'][alg]={'checks':checks,'mm_stat':(sys/'mm_stat').read_text().strip(), 'io_stat':(sys/'io_stat').read_text().strip()}
        (sys/'reset').write_text('1')
        if int((sys/'disksize').read_text()) != 0: raise RuntimeError('device reset failed')
finally:
    if idx is not None and idx >= 0:
        P('/sys/class/n100-zram-control/hot_remove').write_text(str(idx))
        result['cleanup']=not P('/sys/block/n100zram'+str(idx)).exists()
    subprocess.run(['/usr/sbin/rmmod','n100_zram'],check=True)
    result['after']=fixed()
    result['preserved'] = result['before']==result['after']
    print(json.dumps(result,sort_keys=True),flush=True)
if not result['cleanup'] or not result['preserved']: raise SystemExit('restoration verification failed')
