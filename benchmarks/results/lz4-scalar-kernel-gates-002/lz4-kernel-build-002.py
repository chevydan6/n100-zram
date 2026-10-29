import fcntl,hashlib,json,os,pathlib,re,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);status=r/'build/astra-audit/lz4-kernel-build-002.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 save('waiting for confirmation measurement to finish');deadline=time.monotonic()+5000
 while True:
  active=subprocess.check_output(['systemctl','--user','show','n100-lz4-confirm-energy-002.service','-p','ActiveState','--value'],text=True).strip()
  if active not in ['active','activating','deactivating']:break
  if time.monotonic()>deadline:raise TimeoutError('confirmation remained active')
  time.sleep(5)
 p=r/'build/lz4-scalar-confirm-energy-002/checkpoint.json'
 if not p.exists() or json.loads(p.read_text())['status']!='complete':save('deferred; confirmation did not complete');raise SystemExit(0)
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);save('checking exact-kernel source and building scalar backends')
  out=r/'build/lz4-kernel-build-002';out.mkdir();steps=[]
  def run(label,cmd):
   start=time.time()
   with (out/(label+'.log')).open('w') as log:p=subprocess.run(cmd,stdout=log,stderr=subprocess.STDOUT,timeout=1200)
   steps.append(dict(label=label,command=cmd,status=p.returncode,seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==0,label
  archive=r/'build/astra-kernel-source-review-003/linux-7.2.11.tar.xz';source={}
  for name in ['lz4_compress.c','lz4_decompress.c','lz4defs.h']:
   data=subprocess.check_output(['tar','-xOf',str(archive),'linux-7.2.11/lib/lz4/'+name]);repo=(r/'src/kernel-lz4'/name).read_bytes();source[name]=dict(exact_sha256=hashlib.sha256(data).hexdigest(),repo_sha256=hashlib.sha256(repo).hexdigest(),identical=data==repo)
  (out/'source-comparison.json').write_text(json.dumps(source,indent=2)+'\n')
  reference=r/'build/astra-zram-reference-001/zram';kernel=r/'build/astra-vm/root/usr/src/kernels/7.2.11-200.fc44.x86_64';header=kernel/'include/linux/lz4.h'
  for bits in [12,13]:
   first=r/f'build/lz4-kernel-small{bits}-002';target=r/f'build/lz4-kernel-matched{bits}-002'
   run(f'prepare-small{bits}',['python3','tools/prepare-small-table-backend.py','--reference',str(reference),'--lz4-header',str(header),'--bits',str(bits),'--output',str(first)])
   run(f'prepare-control{bits}',['python3','tools/prepare-small-table-backend.py','--reference',str(first),'--lz4-header',str(header),'--bits','14','--control','--output',str(target)])
   run(f'build{bits}',['make','-j1','-C',str(kernel),'M='+str(target),'CONFIG_ZRAM_BACKEND_LZ4_SMALL=y','CONFIG_ZRAM_BACKEND_LZ4_CONTROL=y','KCFLAGS=-DCONFIG_ZRAM_BACKEND_LZ4_SMALL=1 -DCONFIG_ZRAM_BACKEND_LZ4_CONTROL=1','modules'])
   module=target/'zram.ko';vermagic=subprocess.check_output(['modinfo','-F','vermagic',str(module)],text=True).strip();assert vermagic.startswith('7.2.11-200.fc44.x86_64')
   objects={}
   for name in ['n100s_lz4_compress.o','n100c_lz4_compress.o','backend_lz4_small.o','backend_lz4_control.o']:
    asm=subprocess.check_output(['objdump','-d',str(target/name)],text=True);assert not re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm),name;objects[name]=hashlib.sha256((target/name).read_bytes()).hexdigest()
   (out/f'module{bits}.json').write_text(json.dumps(dict(module_sha256=hashlib.sha256(module.read_bytes()).hexdigest(),vermagic=vermagic,scalar_objects=objects,scope='Built only; guest/native tests pending'),indent=2)+'\n')
  (out/'result.json').write_text(json.dumps(dict(status='built',steps=steps,source_comparison=source,scope='Separate default-off 12/13-bit scalar backends with 14-bit same-module controls; no host loading'),indent=2)+'\n')
 save('built; guest correctness pending')
except SystemExit:raise
except BaseException as e:save('failed; preserve artifacts',error=repr(e));raise
