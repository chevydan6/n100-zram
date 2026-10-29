import json,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/simd-vm-001-queue.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 save('waiting for additional SIMD policy fixtures')
 deadline=time.monotonic()+7200;p=r/'build/astra-simd-policy-004-validation/result.json'
 while not p.exists():
  if time.monotonic()>deadline:raise TimeoutError('Policy validation pending')
  time.sleep(10)
 assert json.loads(p.read_text())['status']=='passed'
 assert json.loads((r/'build/astra-simd-kernel-002/result.json').read_text())['status']=='built'
 mem=dict(line.split(':',1) for line in pathlib.Path('/proc/meminfo').read_text().splitlines());available=int(mem['MemAvailable'].split()[0])
 if available<2*1024**2:
  save('deferred; existing 2 GiB available-memory gate not met',mem_available_kib=available,host_unchanged=True);raise SystemExit(0)
 vm=r/'build/astra-vm/root'
 for avx in [False,True]:
  # Each runner obtains the existing exclusive lock and rechecks live memory.
  out=r/('build/astra-simd-vm-001-'+('avx2' if avx else 'fallback'))
  command=['python3','gzram/tools/vm-scalar-selftest.py','--kind','simd','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module','build/astra-simd-kernel-002/n100_gzram_hybrid_selftest.ko','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(out)]
  if avx:command.append('--guest-avx2')
  save('running exact-kernel guest correctness',avx2=avx,command=command)
  with (r/('build/astra-audit/simd-vm-001-'+('avx2' if avx else 'fallback')+'.log')).open('w') as log:subprocess.run(command,cwd=r,check=True,timeout=240,stdout=log,stderr=subprocess.STDOUT)
 save('complete; no native timing or register-preservation claim')
except SystemExit:raise
except BaseException as e:save('failed; preserve outputs',error=repr(e));raise
