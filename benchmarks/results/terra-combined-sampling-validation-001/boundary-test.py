import fcntl,json,os,pathlib,subprocess
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);out=r/'build/terra-combined-sampling-boundaries-001';out.mkdir();runtime=r/'build/astra-toolchain/root/usr/lib64';records=[]
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);v=r/'build/terra-combined-sampling-validation-001';assert json.loads((v/'result.json').read_text())['status']=='passed'
  for mode in ('normal','asan'):
   source=r/('build/astra-v9-asan' if mode=='asan' else 'build/astra-v9');env=dict(os.environ)
   if mode=='asan':env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
   for n in (16,64):
    lib=out/f'bitdirectsample{n}-bitdirectblock2-{mode}.so';os.symlink(v/mode/f'combined-sample{n}.so',lib)
    cmd=['python3','gzram/tests/hybrid.py','--library',str(lib),'--other-libraries',str(source/'libgzram-hybrid-bitdirectblock2avxbits4bounded.so'),str(source/'libgzram-hybrid-wordmixed.so')]
    with (out/f'{mode}-{n}.log').open('w') as f: subprocess.run(cmd,env=env,stdout=f,stderr=subprocess.STDOUT,check=True,timeout=1200)
    lines=(out/f'{mode}-{n}.log').read_text().splitlines();x=json.loads(lines[-1]);assert x['status']=='passed' and x['sampling_boundary_pages']>0 and x['block_selection_boundary_pages']>0 and json.loads(lines[-2])['scan_pipeline_pages']>0;records.append(dict(mode=mode,budget=n,result=x))
  (out/'result.json').write_text(json.dumps(dict(status='passed',records=records),indent=2)+'\n')
except BaseException as e:(out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e),records=records),indent=2)+'\n');raise
