#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded competing SHA256 workload; not an interactive responsiveness proxy."""
import argparse,hashlib,json,os,resource,signal,time
p=argparse.ArgumentParser();p.add_argument('--max-seconds',type=int,default=200);p.add_argument('--batches',type=int,default=0);a=p.parse_args();assert 1<=a.max_seconds<=240 and 0<=a.batches<=10000
stop=False
def finish(*_):
 global stop
 stop=True
signal.signal(signal.SIGTERM,finish)
data=bytes(range(256))*4096;expected=hashlib.sha256(data).digest();started=time.monotonic_ns();count=0
print(json.dumps({'nice':os.getpriority(os.PRIO_PROCESS,0),'cpu_affinity':sorted(os.sched_getaffinity(0)),'phase':'ready','started_ns':started,'bytes_per_hash':len(data)}),flush=True)
while not stop and time.monotonic_ns()-started<a.max_seconds*1000000000:
 begin=time.monotonic_ns()
 for _ in range(16):assert hashlib.sha256(data).digest()==expected
 end=time.monotonic_ns();count+=1
 print(json.dumps({'phase':'batch','begin_ns':begin,'end_ns':end,'bytes':16*len(data)}),flush=True)
 if a.batches and count>=a.batches:break
r=resource.getrusage(resource.RUSAGE_SELF)
print(json.dumps({'phase':'complete','batches':count,'ended_ns':time.monotonic_ns(),'user_seconds':r.ru_utime,'system_seconds':r.ru_stime}),flush=True)
