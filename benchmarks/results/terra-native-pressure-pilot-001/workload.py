#!/usr/bin/env python3
"""Bounded synthetic working set plus repeated compiler launch under a cgroup."""
import json, mmap, os, pathlib, subprocess, time, resource
base=pathlib.Path('/home/dan/n100-zram/build/astra-zram-corpora-001')
names=['bash-elf','libc-elf','sparse-words','repeat8','period127','mixed-pages','clusters50','random']
data=[(base/(n+'.bin')).read_bytes() for n in names]
size=192*1024*1024
start=time.monotonic(); cpu=time.process_time_ns(); durations=[]; checks=0
with mmap.mmap(-1,size) as memory:
    for offset in range(0,size,512*1024): memory[offset:offset+512*1024]=data[(offset//(512*1024))%len(data)]
    for phase in range(4):
        t=time.monotonic_ns()
        for page in range(0,size//4096,37):
            pos=page*4096; corpus=(pos//(512*1024))%len(data); within=pos%(512*1024)
            if memory[pos:pos+32] != data[corpus][within:within+32]: raise RuntimeError('working set mismatch')
            checks+=1
        durations.append(time.monotonic_ns()-t)
        t=time.monotonic_ns()
        subprocess.run(['/usr/bin/gcc','-fsyntax-only','/home/dan/n100-zram/gzram/tests/zram-roundtrip.c'],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.PIPE,timeout=30)
        durations.append(time.monotonic_ns()-t)
u=resource.getrusage(resource.RUSAGE_SELF); c=resource.getrusage(resource.RUSAGE_CHILDREN)
print(json.dumps({'elapsed_s':time.monotonic()-start,'self_cpu_ns':time.process_time_ns()-cpu,'checks':checks,'phase_ns':durations,'minor_faults':u.ru_minflt+c.ru_minflt,'major_faults':u.ru_majflt+c.ru_majflt}))
