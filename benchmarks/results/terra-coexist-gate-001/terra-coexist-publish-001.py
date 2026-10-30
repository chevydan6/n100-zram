import fcntl,json,pathlib,shutil,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');p=r/'build/astra-audit/terra-coexist-gate-001.json';status=r/'build/astra-audit/terra-coexist-publish-001.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 save('waiting for coexistence gate');deadline=time.monotonic()+7800
 while True:
  if p.exists():
   g=json.loads(p.read_text());s=g['status']
   if s.startswith(('passed;','failed or deferred;')):break
  if time.monotonic()>deadline:raise TimeoutError('coexistence gate pending')
  time.sleep(5)
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);save('publishing coexistence evidence',gate=g['status'])
  branch=subprocess.check_output(['git','branch','--show-current'],cwd=r,text=True).strip();assert branch=='feature/n100-gzram-terra-validation',branch
  doc=r/'docs/GZRAM-TERRA-VALIDATION.md';assert not subprocess.check_output(['git','status','--porcelain','--',str(doc.relative_to(r))],cwd=r,text=True)
  dest=r/'benchmarks/results/terra-coexist-gate-001';dest.mkdir();shutil.copy2(p,dest/'gate-status.json')
  for name in ['terra-coexist-gate-001.py','terra-coexist-publish-001.py']:shutil.copy2(r/'build/astra-audit'/name,dest/name)
  for d,label in [('terra-coexist-gate-001','build'),('terra-coexist-vm-001-fallback','guest-fallback'),('terra-coexist-vm-001-avx2','guest-avx2')]:
   source=r/'build'/d
   if source.exists():
    target=dest/label;target.mkdir()
    for f in source.iterdir():
     if f.is_file() and f.suffix in ['.json','.log']:shutil.copy2(f,target/f.name)
  manifest=r/'build/terra-coexist-zram-001/coexist-manifest.json'
  if manifest.exists():shutil.copy2(manifest,dest/'coexist-manifest.json')
  if g['status'].startswith('passed;'):
   summary='Both diskless guests passed stock and namespaced device coexistence and CPU1 offline/online tests, with AVX2 hidden and exposed. Stock test data remained readable through prototype load, operations and unload. Details and marker counts are in guest result records. This is guest correctness, not native safety or performance.'
  else:summary='The coexistence gate did not pass or was deferred: '+g['status']+' '+g.get('error','')+'. Preserve its build logs and partial guest evidence. No native use or correctness claim follows.'
  (dest/'summary.md').write_text('# Namespaced ZRAM coexistence experiment\n\nThe prototype changes module, disk, control class and debugfs names and uses a separately allocated CPU-hotplug PREPARE state. Stock ZRAM uses the fixed CPUHP_ZCOMP_PREPARE state, so changing names alone is insufficient. CPU-hotplug ordering and lifetime are part of the experiment. No host module is loaded.\n\n'+summary+'\n')
  note='\nA [namespaced ZRAM coexistence experiment](../benchmarks/results/terra-coexist-gate-001/summary.md) records the CPU-hotplug state collision and the actual guest-gate outcome. This is not native performance or a verified hard-hang recovery path.\n';doc.write_text(doc.read_text()+note)
  files=['gzram/tools/prepare-coexist-zram.py','gzram/tools/vm-coexist-zram.py','gzram/tests/zram-roundtrip.c','docs/GZRAM-TERRA-VALIDATION.md',str(dest.relative_to(r))];subprocess.run(['git','add',*files],cwd=r,check=True)
  subprocess.run(['git','diff','--cached','--check','--',*files[:-1],str((dest/'summary.md').relative_to(r))],cwd=r,check=True)
  subprocess.run(['git','-c','user.name=Codex','-c','user.email=codex@openai.com','commit','-qm','Investigate namespaced ZRAM coexistence and CPU hotplug'],cwd=r,check=True)
  commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=r,text=True).strip();subprocess.run(['git','-c',"credential.helper=!gh auth git-credential",'push','origin','feature/n100-gzram-terra-validation'],cwd=r,check=True,timeout=120)
 save('complete',commit=commit,gate=g['status'])
except BaseException as e:save('failed; preserve artifacts',error=repr(e));raise
