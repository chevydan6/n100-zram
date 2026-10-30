import hashlib,json,pathlib,random,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');out=r/'build/terra-vm-zram-corpus-random-002';out.mkdir();status=out/'status.json';sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 module=r/'build/terra-coexist-zram-001/n100_zram.ko';record=json.loads((r/'build/terra-coexist-gate-001/build-result.json').read_text());assert sha(module)==record['module_sha256'];vm=r/'build/astra-vm/root';stock=pathlib.Path(subprocess.check_output(['modinfo','-n','zram'],text=True).strip());completed=[]
 for seed in (482,):
  algorithms=['ghy-bitdirect','ghy-simd','lz4-ghy','lz4','lzo-rle','zstd'];random.Random(seed+1000).shuffle(algorithms);dest=out/f'guest-{seed}';cmd=['python3','gzram/tools/vm-zram-corpus-random.py','--kernel','/boot/vmlinuz-7.2.11-200.fc44.x86_64','--module',str(module),'--stock-module',str(stock),'--client',str(r/'build/terra-coexist-gate-001/client'),'--corpora-directory','build/astra-zram-corpora-001','--qemu',str(vm/'usr/bin/qemu-system-x86_64'),'--busybox',str(vm/'usr/bin/busybox'),'--bios',str(vm/'usr/share/seabios/bios-256k.bin'),'--qemu-data',str(vm/'usr/share/qemu'),'--library-path',str(vm/'usr/lib64'),'--output',str(dest),'--algorithms',*algorithms,'--order-seed',str(seed),'--guest-avx2'];save('running shuffled guest allocator check',seed=seed,completed=completed)
  with (out/f'runner-{seed}.log').open('w') as f:subprocess.run(cmd,cwd=r,stdout=f,stderr=subprocess.STDOUT,check=True,timeout=600)
  result=json.loads((dest/'result.json').read_text());assert result['status']=='passed' and len(result['allocation_observations'])==312;completed.append(seed)
 save('passed; shuffled guest allocation only',seeds=completed,module_sha256=sha(module))
except BaseException as e:save('failed or deferred; preserve artifacts',error=repr(e));raise
