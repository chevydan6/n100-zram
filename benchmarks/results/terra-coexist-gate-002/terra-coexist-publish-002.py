import fcntl,json,pathlib,shutil,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');p=r/'build/astra-audit/terra-coexist-gate-002.json';status=r/'build/astra-audit/terra-coexist-publish-002.json'
def save(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
try:
 deadline=time.monotonic()+900
 while not p.exists() or not json.loads(p.read_text())['status'].startswith(('passed;','failed or deferred;')):
  if time.monotonic()>deadline:raise TimeoutError('guest retry pending')
  time.sleep(5)
 gate=json.loads(p.read_text())
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);save('publishing corrected coexistence gate',gate=gate['status'])
  assert subprocess.check_output(['git','branch','--show-current'],cwd=r,text=True).strip()=='feature/n100-gzram-terra-validation'
  doc=r/'docs/GZRAM-TERRA-VALIDATION.md';assert not subprocess.check_output(['git','status','--porcelain','--',str(doc.relative_to(r))],cwd=r,text=True)
  dest=r/'benchmarks/results/terra-coexist-gate-002';dest.mkdir();shutil.copy2(p,dest/'gate-status.json')
  for name in ['terra-coexist-gate-002.py','terra-coexist-publish-002.py']:shutil.copy2(r/'build/astra-audit'/name,dest/name)
  for mode in ['fallback','avx2']:
   source=r/('build/terra-coexist-vm-002-'+mode)
   if source.exists():
    target=dest/('guest-'+mode);target.mkdir()
    for f in source.iterdir():
     if f.is_file() and f.suffix in ['.json','.log']:shutil.copy2(f,target/f.name)
  source=r/'build/terra-coexist-gate-002';target=dest/'launcher';target.mkdir()
  for f in source.iterdir():
   if f.is_file() and f.suffix in ['.json','.log']:shutil.copy2(f,target/f.name)
  if gate['status'].startswith('passed;'):
   body='Both exact-kernel diskless guests passed with AVX2 hidden and exposed. Each guest ran two load/unload cycles with five algorithms while stock zstd ZRAM remained active in the guest. Every algorithm/cycle completed the 26-corpus four-worker device checks, then offlined and onlined CPU1, repeated the checks pinned to CPU1, and rechecked stock-device data. Each guest recorded 10 CPU1 passes, 10 stock-data passes and two coexistence unload passes. Module and client hashes matched the first attempt. This is guest correctness, not native performance, recovery or production safety.'
  else:body='The corrected guest gate did not pass or was deferred: '+gate['status']+' '+gate.get('error','')+'. The raw logs and any partial results are preserved. No native or correctness claim follows.'
  (dest/'summary.md').write_text('# Corrected namespaced ZRAM coexistence guest gate\n\nThe first attempt failed because the minimal initramfs lacked /tmp; its evidence remains in ../terra-coexist-gate-001/. The corrected guest creates /tmp and reuses the hash-verified module and client.\n\n'+body+'\n\nThe experimental driver uses a separate dynamic CPU-hotplug PREPARE state, distinct block/device/control/debugfs names and no host load. Guest CPU-hotplug results do not establish hard-hang recovery, native pressure behavior or general CPU-hotplug correctness.\n')
  doc.write_text(doc.read_text()+'\nThe [corrected coexistence guest gate](../benchmarks/results/terra-coexist-gate-002/summary.md) records the actual retry outcome; the initial missing-/tmp failure remains preserved. Native recovery and performance remain unproven.\n')
  files=['gzram/tools/vm-coexist-zram.py','docs/GZRAM-TERRA-VALIDATION.md',str(dest.relative_to(r))];subprocess.run(['git','add',*files],cwd=r,check=True)
  subprocess.run(['git','diff','--cached','--check','--',*files[:-1],str((dest/'summary.md').relative_to(r))],cwd=r,check=True)
  subprocess.run(['git','-c','user.name=Codex','-c','user.email=codex@openai.com','commit','-qm','Record corrected namespaced ZRAM coexistence guest gate'],cwd=r,check=True)
  commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=r,text=True).strip();subprocess.run(['git','-c',"credential.helper=!gh auth git-credential",'push','origin','feature/n100-gzram-terra-validation'],cwd=r,check=True,timeout=120)
 save('complete',commit=commit,gate=gate['status'])
except BaseException as e:save('failed; preserve artifacts',error=repr(e));raise
