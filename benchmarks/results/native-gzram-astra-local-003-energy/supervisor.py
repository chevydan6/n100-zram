import fcntl,hashlib,json,os,pathlib,signal,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
fd=int(os.environ['GZRAM_ENERGY_FD']);assert os.geteuid()==1000
assert fcntl.fcntl(fd,fcntl.F_GETFL)&os.O_ACCMODE==os.O_RDONLY
assert os.readlink(f'/proc/self/fd/{fd}')==os.path.realpath('/sys/class/powercap/intel-rapl:0/energy_uj')
old=json.loads((root/'build/astra-local-003/checkpoint.json').read_text())
variants=old['inputs']['selected_variants'];assert len(variants)==22 and set(variants)==set(old['inputs']['variant_names'])
for name,entry in json.loads((root/'build/astra-local-003-preflight.json').read_text())['files'].items():
 if '/power_supply/' not in name:assert hashlib.sha256(pathlib.Path(name).read_bytes()).hexdigest()==entry['sha256'],name
status=root/'build/astra-audit/v3-energy-retry.json';child=None
command=['/usr/bin/nice','-n','5','/usr/bin/python3',str(root/'build/astra-v3/source-checkpoint/gzram/tools/run-native.py'),'--directory',str(root/'build/astra-v3'),'--output',str(root/'build/astra-local-003-energy-retry'),'--variants',*variants]
def save(**s):
 s.update(uid=os.getuid(),energy_counter_read_only=True,command=command,measurement_deadline_seconds=2100,lock_wait_deadline_seconds=600)
 status.write_text(json.dumps(s,indent=2)+'\n')
def interrupted(number,frame):raise InterruptedError('Supervisor signal '+str(number))
for number in [signal.SIGTERM,signal.SIGINT]:signal.signal(number,interrupted)
save(status='waiting for native lock',started=time.time())
with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('a+') as lock:
 deadline=time.monotonic()+600
 while True:
  try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);break
  except BlockingIOError:
   if time.monotonic()>deadline:raise TimeoutError('Native lock remained occupied; no benchmark launched')
   time.sleep(1)
save(status='running',started=time.time())
try:
 child=subprocess.Popen(command,pass_fds=(fd,),start_new_session=True)
 code=child.wait(timeout=2100)
 if code:raise RuntimeError('Runner exited '+str(code))
 save(status='complete',finished=time.time())
except BaseException as error:
 if child is not None:
  try:os.killpg(child.pid,signal.SIGTERM)
  except ProcessLookupError:pass
  try:child.wait(timeout=5)
  except subprocess.TimeoutExpired:
   try:os.killpg(child.pid,signal.SIGKILL)
   except ProcessLookupError:pass
   child.wait()
 save(status='failed',error=repr(error),finished=time.time());raise
