#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Hold the project native lock while observing a persistent root test service."""
import argparse,fcntl,subprocess,time,shlex
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--unit',required=True);p.add_argument('--lock',type=Path,required=True);p.add_argument('--timeout-seconds',type=int,default=1200);p.add_argument('--ready-file',type=Path);p.add_argument('--after',nargs=argparse.REMAINDER);a=p.parse_args();assert 60<=a.timeout_seconds<=7200
with a.lock.open('r') as lock:
 deadline=time.monotonic()+a.timeout_seconds
 while True:
  try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);break
  except BlockingIOError:
   if time.monotonic()>deadline:raise SystemExit('Native lock stayed busy until deadline')
   time.sleep(2)
 print('LOCK_ACQUIRED',flush=True)
 if a.ready_file:
  assert a.ready_file.is_absolute()
  for command in [['mkdir','-p',str(a.ready_file.parent)],['touch','--',str(a.ready_file)]]:
   subprocess.run(['ssh','-o','BatchMode=yes','-o','ConnectTimeout=10',a.host,shlex.join(command)],check=True)
  print('READY_TRIGGER_WRITTEN',flush=True)
 started=False;previous=None
 deadline=time.monotonic()+a.timeout_seconds
 failures=0
 while time.monotonic()<deadline:
  result=subprocess.run(['ssh','-o','BatchMode=yes','-o','ConnectTimeout=10',a.host,'systemctl show '+a.unit+' -p LoadState -p ActiveState -p SubState -p ExecMainStatus -p ExecMainStartTimestampMonotonic'],capture_output=True,text=True)
  if result.returncode:
   failures+=1
   if failures==6:print('SSH unavailable after six attempts; retaining native lock and retrying until observation deadline',flush=True)
   time.sleep(3);continue
  failures=0;props=dict(x.split('=',1) for x in result.stdout.splitlines() if '=' in x)
  if int(props.get('ExecMainStartTimestampMonotonic','0') or 0)>0:started=True
  current=(props.get('ActiveState'),props.get('SubState'))
  if current!=previous:print(result.stdout,flush=True);previous=current
  if started and props.get('LoadState')=='not-found':raise SystemExit('Observed unit vanished; possible reboot. Inspect boot ID and checkpoint before resuming')
  if started and (props.get('SubState')=='exited' or props.get('ActiveState') in ['failed','inactive']):
   status=int(props.get('ExecMainStatus','1'))
   if status==0 and a.after:
    print('COLLECTING_UNDER_HARDWARE_LOCK',flush=True);subprocess.run(a.after,check=True)
   raise SystemExit(status)
  time.sleep(2)
 raise SystemExit('Observation deadline reached; inspect persistent unit before resuming')
