import fcntl,hashlib,json,os,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r)
with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
 fcntl.flock(lock,fcntl.LOCK_EX)
 source=r/'build/astra-simd-port-004-validation';assert json.loads((source/'result.json').read_text())['status']=='passed'
 out=r/'build/astra-simd-policy-004-validation';out.mkdir();steps=[]
 try:
  runtime=r/'build/astra-toolchain/root/usr/lib64'
  for mode in ['simd','forced']:
   for sanitized in [False,True]:
    suffix='-asan' if sanitized else '';original=source/f'lib{mode}{suffix}.so'
    library=out/f'libgzram-bitdirectblock2avxbits4-{mode}{suffix}.so';os.link(original,library)
    env=dict(os.environ)
    if sanitized:env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
    command=['python3','gzram/tests/hybrid.py','--library',str(library),'--same-encoding-libraries',str(r/'build/astra-v8/libgzram-hybrid-bitdirectblock2avxbits4.so'),'--other-libraries',str(r/'build/astra-v8/libgzram-hybrid-wordmixed.so')]
    started=time.time()
    with (out/(mode+suffix+'.log')).open('w') as log:result=subprocess.run(command,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=900)
    steps.append(dict(command=command,status=result.returncode,library_sha256=hashlib.sha256(original.read_bytes()).hexdigest(),seconds=time.time()-started));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert result.returncode==0
  (out/'result.json').write_text(json.dumps(dict(status='passed',scope='Additional policy-specific repeat headers, cutoff and scanner fixtures, beyond the general port validation',steps=len(steps),test_sha256=hashlib.sha256((r/'gzram/tests/hybrid.py').read_bytes()).hexdigest()),indent=2)+'\n')
 except BaseException as e:
  (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e)),indent=2)+'\n');raise
