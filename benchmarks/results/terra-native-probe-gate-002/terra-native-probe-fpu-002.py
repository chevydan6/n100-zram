import fcntl,json,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/terra-native-probe-fpu-002.json'
def save(s,**k):status.write_text(json.dumps(dict(status=s,time=time.time(),**k),indent=2)+'\n')
try:
 assert json.loads((r/'build/astra-audit/terra-native-probe-vm-002.json').read_text())['status'].startswith('passed')
 out=r/'build/terra-native-probe-fpu-002';out.mkdir();runtime=r/'build/astra-vm/root/usr/lib64';client=out/'client'
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);save('building matched FPU-control client')
  command=['gcc','-O2','-g','-Wall','-Wextra','-Werror','-static','-fno-tree-vectorize','-pthread','-B'+str(runtime),'-L'+str(runtime),'gzram/benchmarks/simd-call.c','-o',str(client)]
  with (out/'build.log').open('w') as log:subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=300)
 vm=r/'build/astra-vm/root';dest=r/'build/terra-native-probe-fpu-vm-002'
 command=['python3','gzram/tools/vm-scalar-selftest.py','--kind','probe','--guest-avx2','--probe-measurement-client','--probe-fpu-control','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module','build/terra-native-probe-002/n100_gzram_hybrid_probe.ko','--probe-client',str(client),'--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(dest)]
 save('running matched FPU controls and nested-section rejection in guest')
 with (out/'guest.log').open('w') as log:subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=240)
 assert json.loads((dest/'result.json').read_text())['status']=='passed';save('passed; native measurement not started')
except BaseException as e:save('failed or deferred; preserve artifacts',error=repr(e));raise
