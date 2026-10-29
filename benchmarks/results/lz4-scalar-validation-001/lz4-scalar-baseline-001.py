import fcntl,hashlib,json,os,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);out=r/'build/lz4-scalar-baseline-001';out.mkdir();steps=[]
def run(label,cmd,env=None):
 start=time.time()
 with (out/(label+'.log')).open('w') as f:p=subprocess.run(cmd,env=env,stdout=f,stderr=subprocess.STDOUT,timeout=1200)
 steps.append(dict(label=label,command=cmd,status=p.returncode,seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==0,label
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX)
  for name in ['scalar','avx2-guard']:
   assert not (r/'build'/name).exists() and not (r/'build'/(name+'.so')).exists()
  run('reference-build',['python3','tools/build.py','--variants','scalar','avx2-guard'])
  target=r/'build/lz4-scalar-table-001';run('table-build',['python3','tools/prepare-small-table.py','--output',str(target)])
  run('table-correctness',['python3','tests/small-table.py','--directory',str(target)])
  hashes={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [r/'src/kernel-lz4/lz4_compress.c',r/'src/kernel-lz4/lz4_decompress.c',r/'include/linux/lz4.h',r/'tools/prepare-small-table.py',r/'tests/small-table.py']}
  (out/'result.json').write_text(json.dumps(dict(status='passed',source_hashes=hashes,scope='Fresh baseline correctness; no new performance claim',steps=len(steps)),indent=2)+'\n')
except BaseException as e:(out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e),steps=len(steps)),indent=2)+'\n');raise
