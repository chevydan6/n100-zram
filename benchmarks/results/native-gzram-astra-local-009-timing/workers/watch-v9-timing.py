import fcntl,hashlib,json,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/v9-timing-analysis-watch.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 save('waiting for timing supervisor')
 deadline=time.monotonic()+10000;p=r/'build/astra-audit/v9-timing-supervisor.json'
 while True:
  if p.exists():
   s=json.loads(p.read_text())['status']
   if s=='failed':raise RuntimeError('Timing failed; preserve all raw outputs')
   if s=='complete':break
  if time.monotonic()>deadline:raise TimeoutError('Timing remained pending')
  time.sleep(10)
 # Inhibitor wrapper exits after the supervisor; wait for that before postflight.
 for _ in range(60):
  state=subprocess.check_output(['systemctl','--user','show','n100-gzram-astra-v9-timing.service','-p','ActiveState','--value'],text=True).strip()
  if state not in ['active','activating','deactivating']:break
  time.sleep(1)
 assert state not in ['active','activating','deactivating']
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);save('auditing and analyzing completed cohort')
  pre=json.loads((r/'build/astra-local-009-timing-preflight.json').read_text());settings={}
  for name,v in pre['files'].items():settings[name]=hashlib.sha256(pathlib.Path(name).read_bytes()).hexdigest()==v['sha256']
  inhibitors=subprocess.check_output(['systemd-inhibit','--list','--no-pager'],text=True)
  post=dict(time=time.time(),temporary_inhibitor_released='GZRAM-V9' not in inhibitors,settings_unchanged=settings)
  (r/'build/astra-audit/v9-postflight.json').write_text(json.dumps(post,indent=2)+'\n')
  assert post['temporary_inhibitor_released']
  with (r/'build/astra-audit/v9-timing-analysis-watch.log').open('w') as log:subprocess.run(['python3','build/astra-audit/analyze-v9-timing.py'],cwd=r,check=True,timeout=2400,stdout=log,stderr=subprocess.STDOUT)
 save('complete; interpretation and commit pending')
except BaseException as e:save('failed; preserve raw artifacts',error=repr(e));raise
