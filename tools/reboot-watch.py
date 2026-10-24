#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Reserve the native lock and verify a changed boot ID returns on a known kernel."""
from pathlib import Path
import argparse,fcntl,subprocess,time,json
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--lock',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--expected-kernel',required=True);p.add_argument('--timeout',type=int,default=300);a=p.parse_args()
if a.output.exists():raise SystemExit('Use a fresh evidence file')
a.output.parent.mkdir(parents=True,exist_ok=True)
def probe():
 result=subprocess.run(['ssh','-o','BatchMode=yes','-o','ConnectTimeout=5','-o','ConnectionAttempts=1',a.host,'cat /proc/sys/kernel/random/boot_id; uname -r'],capture_output=True,text=True,timeout=12)
 if result.returncode:return None
 lines=result.stdout.strip().splitlines()
 return {'boot_id':lines[0],'kernel':lines[1]} if len(lines)==2 else None
with a.lock.open('r') as lock:
 deadline=time.monotonic()+1200
 while True:
  try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);break
  except BlockingIOError:
   if time.monotonic()>deadline:raise SystemExit('Native test lock busy for 20 minutes')
   time.sleep(2)
 before=probe()
 if not before:raise SystemExit('SSH must work before starting recovery verification')
 print('LOCK_ACQUIRED; INITIAL_SSH_VERIFIED',flush=True)
 start=time.monotonic();record={'status':'waiting','before':before,'started':time.time()};a.output.write_text(json.dumps(record,indent=2)+'\n')
 while time.monotonic()-start<a.timeout:
  try:after=probe()
  except subprocess.TimeoutExpired:after=None
  if after and after['boot_id']!=before['boot_id']:
   record.update(status='passed' if after['kernel']==a.expected_kernel else 'unexpected-kernel',after=after,elapsed_seconds=time.monotonic()-start)
   a.output.write_text(json.dumps(record,indent=2)+'\n');print(json.dumps(record),flush=True)
   raise SystemExit(0 if record['status']=='passed' else 1)
  time.sleep(3)
 record.update(status='timeout',elapsed_seconds=time.monotonic()-start);a.output.write_text(json.dumps(record,indent=2)+'\n')
 raise SystemExit('Recovery observation timed out; inspect the same system before any further experiment')
