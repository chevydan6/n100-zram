import fcntl,hashlib,json,pathlib,re,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/terra-coexist-gate-001.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 save('waiting for measured cohort and its audit to release native lock');deadline=time.monotonic()+5400
 p=r/'build/astra-audit/terra-matched-codecs-publish-001.json'
 while True:
  if p.exists() and json.loads(p.read_text())['status'].startswith(('complete','failed')):break
  if time.monotonic()>deadline:raise TimeoutError('preceding measured cohort pending')
  time.sleep(5)
 out=r/'build/terra-coexist-gate-001';out.mkdir();target=r/'build/terra-coexist-zram-001';kernel=r/'build/astra-vm/root/usr/src/kernels/7.2.11-200.fc44.x86_64';steps=[]
 def run(label,cmd,expected=0,timeout=900):
  start=time.time()
  with (out/(label+'.log')).open('w') as log:p=subprocess.run(cmd,cwd=r,stdout=log,stderr=subprocess.STDOUT,timeout=timeout)
  steps.append(dict(label=label,command=cmd,status=p.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==expected,label
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);save('preparing namespaced prototype and auditing CPU hotplug registration')
  run('prepare',['python3','gzram/tools/prepare-coexist-zram.py','--source','build/terra-simd-zram-001','--build-record','build/terra-simd-zram-test-001/build-result.json','--guest-scalar','build/terra-simd-zram-vm-001-scalar-fallback/result.json','--guest-avx2','build/terra-simd-zram-vm-001-avx2/result.json','--output',str(target)])
  run('build',['make','-j1','-C',str(kernel),'M='+str(target),'CONFIG_ZRAM_BACKEND_GHY_BITDIRECT=y','modules'])
  module=target/'n100_zram.ko';assert subprocess.check_output(['modinfo','-F','name',str(module)],text=True).strip()=='n100_zram'
  vermagic=subprocess.check_output(['modinfo','-F','vermagic',str(module)],text=True).strip();assert vermagic.split()[0]=='7.2.11-200.fc44.x86_64'
  objects={}
  for name,expect in [('backend_ghy_simd.o',False),('simd/dispatch.o',False),('simd/fallback.o',False),('simd/vector-encoder/core.o',True),('simd/vector-decoder/core.o',True),('simd/vector-trial.o',True)]:
   asm=subprocess.check_output(['objdump','-d',str(target/name)],text=True);found=bool(re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm));assert found==expect,(name,found);objects[name]=hashlib.sha256((target/name).read_bytes()).hexdigest()
  runtime=r/'build/astra-vm/root/usr/lib64';client=out/'client'
  run('client-build',['gcc','-O2','-g','-Wall','-Wextra','-Werror','-static','-fno-tree-vectorize','-pthread','-B'+str(runtime),'-L'+str(runtime),'gzram/tests/zram-roundtrip.c','-o',str(client)])
  run('client-host-refusal',[str(client),'/dev/zram0','unused.bin'],expected=3)
  record=dict(status='built',module_sha256=hashlib.sha256(module.read_bytes()).hexdigest(),vermagic=vermagic,objects=objects,client_sha256=hashlib.sha256(client.read_bytes()).hexdigest(),scope='Unloaded prototype; coexistence and CPU hotplug guest tests pending; no native safety claim')
  (out/'build-result.json').write_text(json.dumps(record,indent=2)+'\n')
 vm=r/'build/astra-vm/root';stock=pathlib.Path(subprocess.check_output(['modinfo','-n','zram'],text=True).strip());results={}
 for avx in [False,True]:
  name='avx2' if avx else 'fallback';dest=r/('build/terra-coexist-vm-001-'+name)
  cmd=['python3','gzram/tools/vm-coexist-zram.py','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module',str(module),'--stock-module',str(stock),'--client',str(client),'--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(dest),'--algorithms','ghy-bitdirect','ghy-simd','lz4-ghy','lz4','zstd']
  if avx:cmd.append('--guest-avx2')
  save('running diskless coexistence and CPU-hotplug guest',avx2=avx,completed=results)
  run('guest-'+name,cmd,timeout=300)
  result=json.loads((dest/'result.json').read_text());assert result['status']=='passed';results[name]=dict(status='passed',markers=result['coexist_markers'],output=str(dest))
 save('passed; no native loading or performance claim',results=results)
except BaseException as e:save('failed or deferred; preserve artifacts',error=repr(e));raise
