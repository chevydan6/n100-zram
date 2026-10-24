#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Hold the project native lock while observing a persistent root test service."""
import argparse,fcntl,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--unit',required=True);p.add_argument('--lock',type=Path,required=True);a=p.parse_args()
with a.lock.open('r') as lock:
 deadline=time.monotonic()+1200
 while True:
  try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);break
  except BlockingIOError:
   if time.monotonic()>deadline:raise SystemExit('Native lock stayed busy for 20 minutes')
   time.sleep(2)
 print('LOCK_ACQUIRED',flush=True);started=False;previous=None
 deadline=time.monotonic()+1200
 failures=0
 while time.monotonic()<deadline:
  result=subprocess.run(['ssh','-o','BatchMode=yes','-o','ConnectTimeout=10',a.host,'systemctl show '+a.unit+' -p LoadState -p ActiveState -p SubState -p ExecMainStatus -p ExecMainStartTimestampMonotonic'],capture_output=True,text=True)
  if result.returncode:
   failures+=1
   if failures>=6:raise SystemExit('Unit could not be observed after six SSH attempts; inspect it before resuming')
   time.sleep(3);continue
  failures=0;props=dict(x.split('=',1) for x in result.stdout.splitlines() if '=' in x)
  if int(props.get('ExecMainStartTimestampMonotonic','0') or 0)>0:started=True
  current=(props.get('ActiveState'),props.get('SubState'))
  if current!=previous:print(result.stdout,flush=True);previous=current
  if started and (props.get('SubState')=='exited' or props.get('ActiveState') in ['failed','inactive']):raise SystemExit(int(props.get('ExecMainStatus','1')))
  time.sleep(2)
 raise SystemExit('Observation deadline reached; inspect persistent unit before resuming')
