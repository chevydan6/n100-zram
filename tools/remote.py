#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded SSH supervisor with the existing project's native-suite lock.
Run under systemd/tmux on the controller to survive terminal disconnection.
"""
import argparse,fcntl,json,re,shlex,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--directory',required=True);p.add_argument('--id',required=True);p.add_argument('--lock',type=Path,required=True)
a=p.parse_args()
if not re.fullmatch('[a-zA-Z0-9-]+',a.id):raise SystemExit('Use an alphanumeric experiment ID')
root=Path(__file__).resolve().parents[1];local=root/'build'/a.id;local.mkdir(parents=True,exist_ok=True)
statefile=local/'controller.json'
state=json.loads(statefile.read_text()) if statefile.exists() else {'id':a.id,'status':'new'}
def save(**values):
 state.update(values);tmp=statefile.with_suffix('.tmp');tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(statefile)
def ssh(command,check=True):
 last=None
 for attempt in range(3):
  result=subprocess.run(['ssh','-o','BatchMode=yes','-o','StrictHostKeyChecking=yes','-o','ConnectTimeout=10',a.host,command],capture_output=True,text=True)
  if result.returncode!=255:
   if check and result.returncode:raise RuntimeError(result.stderr or result.stdout)
   return result
  last=result.stderr;time.sleep(3)
 raise RuntimeError('SSH unavailable after three attempts: '+str(last))
with a.lock.open('r') as lock:
 try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
 except BlockingIOError:raise SystemExit('Existing native suite owns the lock; defer this run')
 try:
  if state['status']=='new':
   ssh(shlex.join(['mkdir','-p',a.directory]))
   subprocess.run(['rsync','-a','--exclude','build','--exclude','__pycache__',str(root)+'/',a.host+':'+a.directory+'/'],check=True)
   save(status='prepared',host=a.host,directory=a.directory)
  if state['status']=='prepared':
   unit='n100-zram-'+a.id
   active=ssh(shlex.join(['systemctl','--user','is-active',unit]),check=False)
   if active.stdout.strip()!='active':
    ssh(shlex.join(['systemd-run','--user','--unit='+unit,'--property=WorkingDirectory='+a.directory,'/usr/bin/python3',a.directory+'/tools/run-native.py']))
   save(status='running',started=time.time())
  if state['status']=='running':
   deadline=time.monotonic()+1200
   while time.monotonic()<deadline:
    result=ssh(shlex.join(['cat',a.directory+'/build/run/checkpoint.json']),check=False)
    if result.returncode==0:
     remote=json.loads(result.stdout);save(remote_checkpoint=remote)
     if remote['status'] in ['complete','failed']:
      save(status=remote['status'],finished=time.time());break
    time.sleep(5)
   else:raise RuntimeError('Benchmark exceeded the 20-minute supervisor limit')
  subprocess.run(['rsync','-a',a.host+':'+a.directory+'/build/run/',str(local)+'/'],check=True)
  print(json.dumps(state,indent=2))
  if state['status']!='complete':raise SystemExit(1)
 except BaseException as error:
  save(supervisor_error=repr(error));raise
