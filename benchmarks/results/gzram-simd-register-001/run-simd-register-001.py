import json,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/simd-register-001.json'
def save(s,**k):status.write_text(json.dumps(dict(status=s,**k),indent=2)+'\n')
try:
 save('waiting for kernel probe build')
 p=r/'build/astra-simd-probe-001/result.json';deadline=time.monotonic()+900
 while not p.exists():
  if time.monotonic()>deadline:raise TimeoutError('probe build pending')
  time.sleep(3)
 assert json.loads(p.read_text())['status']=='built'
 mem=dict(line.split(':',1) for line in pathlib.Path('/proc/meminfo').read_text().splitlines());available=int(mem['MemAvailable'].split()[0])
 if available<2*1024**2:save('deferred; 2 GiB headroom gate',mem_available_kib=available);raise SystemExit(0)
 vm=r/'build/astra-vm/root';out=r/'build/astra-simd-register-vm-001'
 command=['python3','gzram/tools/vm-scalar-selftest.py','--kind','probe','--guest-avx2','--probe-measurement-client','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module','build/astra-simd-probe-001/n100_gzram_hybrid_probe.ko','--probe-client','build/astra-fpu-clients-002/measurement','--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(out)]
 save('running guest register test',command=command)
 with (r/'build/astra-audit/simd-register-vm-001.log').open('w') as log:subprocess.run(command,cwd=r,check=True,timeout=240,stdout=log,stderr=subprocess.STDOUT)
 result=json.loads((out/'result.json').read_text());assert result['status']=='passed'
 serial=(out/'serial.log').read_text();import re
 paths=re.findall(r'GZRAM_SIMD_PATHS available=(\d+) encode=(\d+) decode=(\d+)',serial)
 assert len(paths)==2 and all(int(a)==1 and int(b)>0 and int(c)>0 for a,b,c in paths),paths
 save('passed; guest register and vector path checks',paths=paths)
except SystemExit:raise
except BaseException as e:save('failed; preserve raw artifacts',error=repr(e));raise
