import fcntl,hashlib,json,os,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);out=r/'build/terra-combined-sampling-benchmark-001';out.mkdir(); steps=[]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def run(name,cmd,env=None):
 start=time.time()
 with (out/(name+'.log')).open('w') as log: p=subprocess.run(cmd,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=1200)
 steps.append(dict(name=name,command=cmd,status=p.returncode,seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==0,name
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX)
  v=r/'build/terra-combined-sampling-validation-001'; assert json.loads((v/'result.json').read_text())['status']=='passed'
  runtime=r/'build/astra-toolchain/root/usr/lib64'; old=r/'build/terra-zerotwo-benchmark-001'; oldmanifest=json.loads((old/'manifest.json').read_text()); env=dict(os.environ,GZRAM_ZERO_GUARD_FIXTURES='1',GZRAM_EXEC_CORPUS_DIR=str(r/'build/astra-exec-corpora-001'))
  for kind in ('normal','asan'):
   d=out/kind;d.mkdir();table=r/('build/lz4-scalar-table-asan-001' if kind=='asan' else 'build/lz4-scalar-table-001')
   for bit in (11,12,13,14):os.link(table/f'table{bit}-scalar.so',d/f'table{bit}-scalar.so')
   for filename in ('combined-sample16.so','combined-sample64.so'):
    os.link(v/kind/filename,d/filename)
   parent='libgzram-hybrid-bitdirectblock2avxbits4bounded.so';os.link(r/('build/astra-v9-asan' if kind=='asan' else 'build/astra-v9')/parent,d/parent)
   flags=['-O1' if kind=='asan' else '-O2','-g','-Wall','-Wextra','-Werror']
   if kind=='asan': flags+=['-fsanitize=address,undefined','-fno-omit-frame-pointer','-B'+str(runtime),'-Wl,-rpath,'+str(runtime)]
   for name,ops in [('benchmark',8192),('smoke',128)]:run(kind+'-build-'+name,['gcc',*flags,f'-DOPS={ops}','benchmarks/matched-sampling.c','-ldl','-o',str(d/name)])
   run(kind+'-validate',[str(d/'benchmark'),str(d),'--validate-only'],env)
  d=out/'normal';names=subprocess.check_output([str(d/'benchmark'),str(d),'--list-corpora'],env=env,text=True).splitlines(); assert len(names)==36 and len(set(names))==36,(len(names),names)
  corpora={name:hashlib.sha256(subprocess.check_output([str(d/'benchmark'),str(d),'--dump-corpus='+name],env=env)).hexdigest() for name in names}
  assert all(corpora[n]==h for n,h in oldmanifest['corpora'].items())
  smokeenv=dict(env,GZRAM_CORPUS_LIST=','.join(n for n in names if n.startswith('zeroguard-') or n.startswith('zerotwoguard-')),GZRAM_ORDER_SEED='428')
  run('normal-smoke',[str(d/'smoke'),str(d)],smokeenv)
  files=['benchmarks/matched-sampling.c','gzram/bench.c','gzram/src/hybrid.c'];(out/'manifest.json').write_text(json.dumps(dict(status='passed',scope='Correctness and smoke only, not performance measurement',corpora=corpora,old_corpora_unchanged=True,sources={x:sha(r/x) for x in files},artifacts={p.name:sha(p) for p in d.iterdir()}),indent=2)+'\n')
except BaseException as e:(out/'failure.json').write_text(json.dumps(dict(error=repr(e),steps=steps),indent=2)+'\n');raise
