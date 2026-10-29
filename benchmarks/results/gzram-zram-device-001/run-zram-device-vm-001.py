import fcntl,hashlib,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root);status=root/'build/astra-audit/zram-device-vm-001-independent.json'
def save(state,**kw):status.write_text(json.dumps(dict(status=state,time=time.time(),**kw),indent=2)+'\n')
try:
 mem=dict(line.split(':',1) for line in pathlib.Path('/proc/meminfo').read_text().splitlines())
 available=int(mem['MemAvailable'].split()[0])
 if available<2*1024**2:
  save('deferred; existing 2 GiB headroom gate not met',mem_available_kib=available,host_unchanged=True)
  raise SystemExit(0)
 out=root/'build/astra-zram-corpora-001';out.mkdir()
 benchmark=root/'build/astra-v8-isolated-aliases/benchmark';directory=benchmark.parent
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
  names=subprocess.check_output([str(benchmark),str(directory),'--list-corpora'],text=True).splitlines()
  hashes={}
  expected=json.loads((root/'build/astra-v8-sizes/metadata.json').read_text())['corpus_sha256']
  for name in names:
   data=subprocess.check_output([str(benchmark),str(directory),'--dump-corpus='+name]);digest=hashlib.sha256(data).hexdigest()
   assert digest==expected[name];(out/(name+'.bin')).write_bytes(data);hashes[name]=digest
  (out/'manifest.json').write_text(json.dumps(hashes,indent=2)+'\n')
 vm=root/'build/astra-vm/root';result=root/'build/astra-zram-device-vm-001'
 command=['python3','gzram/tools/vm-zram-selftest.py','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module','build/astra-zram-bitdirect-001/zram.ko','--client','build/astra-zram-bitdirect-build-001/zram-roundtrip','--corpora-directory',str(out),'--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(result)]
 save('running bounded exact-kernel diskless guest',command=command)
 with (root/'build/astra-audit/zram-device-vm-001.log').open('w') as log:
  subprocess.run(command,check=True,timeout=240,stdout=log,stderr=subprocess.STDOUT)
 save('complete; guest correctness only',result=str(result))
except SystemExit:raise
except BaseException as e:save('failed; preserve outputs',error=repr(e));raise
