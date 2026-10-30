import json,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/terra-native-probe-vm-002.json'
def save(s,**k):status.write_text(json.dumps(dict(status=s,time=time.time(),**k),indent=2)+'\n')
try:
 save('waiting for native-capable unloaded probe build');p=r/'build/terra-native-probe-002/result.json';deadline=time.monotonic()+1200
 while not p.exists():
  if time.monotonic()>deadline:raise TimeoutError('probe build pending')
  state=subprocess.check_output(['systemctl','--user','show','n100-gzram-terra-native-probe-build-002.service','-p','ActiveState','--value'],text=True).strip()
  if state=='failed':raise RuntimeError('probe build failed; inspect build log')
  time.sleep(5)
 assert json.loads(p.read_text())['status']=='built'
 vm=r/'build/astra-vm/root';out=r/'build/terra-native-probe-vm-002'
 command=['python3','gzram/tools/vm-scalar-selftest.py','--kind','probe','--guest-avx2','--probe-measurement-client','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module','build/terra-native-probe-002/n100_gzram_hybrid_probe.ko','--probe-client','build/astra-fpu-clients-002/measurement','--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(out)]
 save('running native-capable probe guest correctness',command=command)
 with (r/'build/astra-audit/terra-native-probe-vm-002.log').open('w') as log:subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=240)
 assert json.loads((out/'result.json').read_text())['status']=='passed';save('passed; native access and recovery still unverified')
except BaseException as e:save('failed or deferred; preserve artifacts',error=repr(e));raise
