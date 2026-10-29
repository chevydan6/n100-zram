import json,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/lz4-kernel-vm-002.json'
def save(s,**k):status.write_text(json.dumps(dict(status=s,time=time.time(),**k),indent=2)+'\n')
try:
 assert json.loads((r/'build/lz4-kernel-build-002/result.json').read_text())['status']=='built'
 vm=r/'build/astra-vm/root';results={}
 for bits in [12,13]:
  out=r/f'build/lz4-kernel-vm-{bits}-002';command=['python3','gzram/tools/vm-zram-selftest.py','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module',f'build/lz4-kernel-matched{bits}-002/zram.ko','--client','build/astra-zram-bitdirect-build-001/zram-roundtrip','--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(out),'--algorithms','lz4','lz4-control','lz4-small','zstd','lzo-rle']
  save('running exact-kernel guest',bits=bits,previous=results)
  with (r/f'build/astra-audit/lz4-kernel-vm-{bits}-002.log').open('w') as log:subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=240)
  result=json.loads((out/'result.json').read_text());assert result['status']=='passed';results[str(bits)]=dict(status=result['status'],output=str(out),module_sha256=result['hashes']['module'])
 save('passed; native performance and recovery pending',results=results)
except BaseException as e:save('failed or deferred; preserve artifacts',error=repr(e));raise
