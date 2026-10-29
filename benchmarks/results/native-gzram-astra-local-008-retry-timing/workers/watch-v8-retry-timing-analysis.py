import fcntl,json,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');producer=pathlib.Path('/proc/49502/stat');status=root/'build/astra-audit/v8-retry-timing-analysis-watch.json'
def identity():
 try:return producer.read_text().rsplit(') ',1)[1].split()[19]
 except FileNotFoundError:return None
initial=identity();assert initial is not None,'Producer is no longer live; inspect terminal output first'
def save(state,**extra):status.write_text(json.dumps(dict(status=state,producer_pid=49502,producer_start_ticks=initial,time=time.time(),**extra),indent=2)+'\n')
save('waiting for live timing producer')
try:
 deadline=time.monotonic()+10000
 while identity()==initial:
  if time.monotonic()>deadline:raise TimeoutError('Existing producer remained live; no duplicate run or analysis launched')
  time.sleep(10)
 checkpoint=root/'build/astra-local-008-retry-timing/checkpoint.json'
 assert checkpoint.exists(),'Producer ended before creating a checkpoint; inspect authentication/launcher result'
 state=json.loads(checkpoint.read_text());assert state['status']=='complete',state.get('error',state['status'])
 save('waiting for native lock before audit and analysis')
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  deadline=time.monotonic()+3600
  while True:
   try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);break
   except BlockingIOError:
    if time.monotonic()>deadline:raise TimeoutError('Native lock busy; completed data retained')
    time.sleep(5)
  save('auditing and analyzing completed cohort')
  with (root/'build/astra-audit/v8-retry-timing-analysis-watch.log').open('w') as log:
   subprocess.run(['/usr/bin/taskset','-c','1','/usr/bin/python3',str(root/'build/astra-audit/analyze-v8-retry-timing.py')],cwd=root,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=1800)
 save('complete; interpretation pending')
except BaseException as error:
 save('failed; existing producer and raw outputs left untouched',error=repr(error));raise
