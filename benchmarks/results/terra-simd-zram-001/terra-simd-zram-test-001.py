import fcntl,hashlib,json,pathlib,re,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/terra-simd-zram-test-001.json';out=r/'build/terra-simd-zram-test-001';out.mkdir()
def save(s,**k):status.write_text(json.dumps(dict(status=s,time=time.time(),**k),indent=2)+'\n')
try:
 target=r/'build/terra-simd-zram-001';kernel=r/'build/astra-vm/root/usr/src/kernels/7.2.11-200.fc44.x86_64';save('building guest-only module')
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX)
  command=['make','-j1','-C',str(kernel),'M='+str(target),'CONFIG_ZRAM_BACKEND_GHY_BITDIRECT=y','modules']
  with (out/'build.log').open('w') as log:subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=900)
  module=target/'zram.ko';vermagic=subprocess.check_output(['modinfo','-F','vermagic',str(module)],text=True).strip();assert vermagic.startswith('7.2.11-200.fc44.x86_64')
  obj={}
  for name,expected in [('backend_ghy_simd.o',False),('simd/dispatch.o',False),('simd/fallback.o',False),('simd/vector-encoder/core.o',True),('simd/vector-decoder/core.o',True),('simd/vector-trial.o',True)]:
   asm=subprocess.check_output(['objdump','-d',str(target/name)],text=True);found=bool(re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm));assert found==expected,(name,found);obj[name]=hashlib.sha256((target/name).read_bytes()).hexdigest()
  (out/'build-result.json').write_text(json.dumps(dict(status='built',module_sha256=hashlib.sha256(module.read_bytes()).hexdigest(),vermagic=vermagic,object_sha256=obj,scope='Guest-only build; no host module load or timing claim'),indent=2)+'\n')
 vm=r/'build/astra-vm/root';results={}
 for avx in [False,True]:
  name='avx2' if avx else 'scalar-fallback';dest=r/('build/terra-simd-zram-vm-001-'+name)
  command=['python3','gzram/tools/vm-zram-selftest.py','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module',str(module),'--client','build/astra-zram-bitdirect-build-001/zram-roundtrip','--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(dest),'--algorithms','ghy-bitdirect','ghy-simd','lz4-ghy','lz4','zstd']
  if avx:command.append('--guest-avx2')
  save('running guest ZRAM correctness',avx2=avx,completed=results)
  with (out/(name+'.log')).open('w') as log:subprocess.run(command,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=240)
  result=json.loads((dest/'result.json').read_text());assert result['status']=='passed';results[name]=dict(status=result['status'],output=str(dest),scope='Guest correctness only; no native performance or direct SIMD path counter')
 save('passed; kernel-inclusive native timing remains untested',results=results)
except BaseException as e:save('failed; preserve artifacts',error=repr(e));raise
