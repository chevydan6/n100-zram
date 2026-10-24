#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Serialize one bounded pressure workload with existing native test suites."""
import argparse,fcntl,subprocess,shlex,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--directory',required=True);p.add_argument('--lock',type=Path,required=True);a=p.parse_args()
root=Path(__file__).resolve().parents[1]
with a.lock.open('r') as lock:
 deadline=time.monotonic()+1200
 while True:
  try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);break
  except BlockingIOError:
   if time.monotonic()>deadline:raise SystemExit('Existing native suite retained lock for 20 minutes; defer pressure test')
   time.sleep(2)
 subprocess.run(['ssh','-o','BatchMode=yes',a.host,shlex.join(['mkdir','-p',a.directory])],check=True)
 subprocess.run(['rsync','-a','--exclude','build','--exclude','__pycache__',str(root)+'/',a.host+':'+a.directory+'/'],check=True)
 result=None
 for session in range(3):
  result=subprocess.run(['ssh','-o','BatchMode=yes',a.host,shlex.join(['python3',a.directory+'/tools/run-pressure.py','--session',str(session)])])
  if result.returncode:break
 dest=root/'build/pressure-native';dest.mkdir(exist_ok=True)
 subprocess.run(['rsync','-a',a.host+':'+a.directory+'/build/pressure/',str(dest)+'/'],check=True)
 raise SystemExit(result.returncode)
