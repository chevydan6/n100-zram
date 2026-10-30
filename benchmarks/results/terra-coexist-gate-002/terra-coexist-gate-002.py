import hashlib,json,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');status=r/'build/astra-audit/terra-coexist-gate-002.json';out=r/'build/terra-coexist-gate-002';out.mkdir()
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 previous=json.loads((r/'build/terra-coexist-gate-001/build-result.json').read_text());assert previous['status']=='built'
 module=r/'build/terra-coexist-zram-001/n100_zram.ko';client=r/'build/terra-coexist-gate-001/client'
 assert hashlib.sha256(module.read_bytes()).hexdigest()==previous['module_sha256'] and hashlib.sha256(client.read_bytes()).hexdigest()==previous['client_sha256']
 vm=r/'build/astra-vm/root';stock=pathlib.Path(subprocess.check_output(['modinfo','-n','zram'],text=True).strip());results={}
 for avx in [False,True]:
  name='avx2' if avx else 'fallback';dest=r/('build/terra-coexist-vm-002-'+name)
  cmd=['python3','gzram/tools/vm-coexist-zram.py','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module',str(module),'--stock-module',str(stock),'--client',str(client),'--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(dest),'--algorithms','ghy-bitdirect','ghy-simd','lz4-ghy','lz4','zstd']
  if avx:cmd.append('--guest-avx2')
  save('running corrected diskless coexistence and CPU-hotplug guest',avx2=avx,completed=results)
  with (out/(name+'.log')).open('w') as log:subprocess.run(cmd,cwd=r,stdout=log,stderr=subprocess.STDOUT,check=True,timeout=300)
  result=json.loads((dest/'result.json').read_text());assert result['status']=='passed';results[name]=dict(status='passed',markers=result['coexist_markers'],output=str(dest))
 save('passed; no native loading or performance claim',results=results)
except BaseException as e:save('failed or deferred; preserve artifacts',error=repr(e));raise
