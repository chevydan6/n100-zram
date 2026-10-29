import fcntl,json,os,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);out=r/'build/lz4-scalar-sanitizer-001';out.mkdir();steps=[]
def run(label,cmd,env):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:p=subprocess.run(cmd,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=1200)
 steps.append(dict(label=label,command=cmd,status=p.returncode,seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==0,label
try:
 assert json.loads((r/'build/lz4-scalar-baseline-001/result.json').read_text())['status']=='passed'
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX)
  runtime=r/'build/astra-toolchain/root/usr/lib64';target=r/'build/lz4-scalar-table-asan-001'
  env=dict(os.environ,EXTRA_CFLAGS=f'-fsanitize=address,undefined -fno-omit-frame-pointer -B{runtime} -Wl,-rpath,{runtime}')
  run('build',['python3','tools/prepare-small-table.py','--output',str(target)],env)
  env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
  run('guard-oracle-concurrency',['python3','tests/small-table.py','--directory',str(target)],env)
  (out/'result.json').write_text(json.dumps(dict(status='passed',scope='ASan/UBSan small-table independent decoder and boundary checks',steps=len(steps)),indent=2)+'\n')
except BaseException as e:(out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e)),indent=2)+'\n');raise
