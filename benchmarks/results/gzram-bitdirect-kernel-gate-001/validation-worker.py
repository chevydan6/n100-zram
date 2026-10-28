import fcntl,hashlib,json,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');out=root/'build/astra-bitdirect-kernel-validation-001';out.mkdir();steps=[]
files=['gzram/kernel/hybrid-selftest.c','gzram/tools/build-hybrid-selftest.py','gzram/tools/vm-scalar-selftest.py']
hashes={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
def save(status,**extra):(out/'status.json').write_text(json.dumps(dict(status=status,steps=steps,source_hashes=hashes,**extra),indent=2)+'\n')
def verify():assert hashes=={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
def acquire():
 lock=open('/home/dan/.cache/n100-zram/native-validation.lock','r+');deadline=time.monotonic()+5400
 while True:
  try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);return lock
  except BlockingIOError:
   if time.monotonic()>deadline:raise TimeoutError('Native lock remained held')
   time.sleep(10)
try:
 save('waiting for userspace correctness')
 result=root/'build/astra-bitdirect-port-001/result.json';deadline=time.monotonic()+5400
 while not result.exists():
  if time.monotonic()>deadline:raise TimeoutError('No userspace result; no kernel work attempted')
  time.sleep(10)
 assert json.loads(result.read_text())['status']=='passed'
 with acquire():
  verify();save('building under native lock')
  command=['python3','gzram/tools/build-hybrid-selftest.py','--control','build/astra-bitdirect-port-001/bitmerge','--candidate','build/astra-bitdirect-port-001/bitdirect','--kernel-build','build/astra-vm/root/usr/src/kernels/7.2.11-200.fc44.x86_64','--output','build/astra-bitdirect-kernel-001']
  with (out/'build.log').open('w') as log:r=subprocess.run(command,cwd=root,stdout=log,stderr=subprocess.STDOUT,timeout=600)
  steps.append(dict(command=command,status=r.returncode));assert r.returncode==0
 target=root/'build/astra-bitdirect-kernel-vm-001'
 command=['python3','gzram/tools/vm-scalar-selftest.py','--kind','hybrid','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module','build/astra-bitdirect-kernel-001/n100_gzram_hybrid_selftest.ko','--qemu','build/astra-vm/root/usr/bin/qemu-system-x86_64','--busybox','build/astra-vm/root/usr/bin/busybox','--bios','build/astra-vm/root/usr/share/seabios/bios-256k.bin','--qemu-data','build/astra-vm/root/usr/share/qemu','--library-path','build/astra-vm/root/usr/lib64','--output',str(target)]
 for attempt in range(12):
  save('waiting for isolated VM gate')
  with acquire():verify()
  r=subprocess.run(command,cwd=root,capture_output=True,text=True,timeout=220)
  (out/('vm-attempt-'+str(attempt)+'.log')).write_text(r.stdout+r.stderr)
  if r.returncode==0:steps.append(dict(command=command,status=0));break
  if not target.exists() and 'Native validation lock is held; no VM started' in r.stderr:continue
  raise RuntimeError('VM gate failed; preserve evidence')
 else:raise RuntimeError('Repeated lock contention')
 verify();save('passed')
except BaseException as error:save('failed',error=repr(error));raise
