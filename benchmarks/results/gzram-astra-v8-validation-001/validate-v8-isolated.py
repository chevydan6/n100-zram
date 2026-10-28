import csv,hashlib,json,os,pathlib,shutil,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root);out=root/'build/astra-v8-isolated-validation';out.mkdir();steps=[]
assert json.loads((root/'build/astra-v8-scans-validation/result.json').read_text())['status']=='passed'
files=['gzram/bench-isolated.c','gzram/bench.c'];hashes={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
(out/'source-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
variants=['lz4-small-scalar']
for policy in ['wordmixed','bitdirect']:
 for isa in ['scalar','avx2']:variants.append(f'ghy-{policy}-{isa}-1024')
for policy in ['blockdirect2','blockdirect3','bitdirectpipe4','bitdirectavxbits4','bitdirectblock2','bitdirectblock2pipe4','bitdirectblock2avxbits4','bitdirectblock3','bitdirectblock3pipe4','bitdirectblock3avxbits4']:variants.append(f'ghy-{policy}-avx2-1024')
for policy in ['bitdirectblock2','bitdirectblock3']:variants.append(f'ghy-{policy}-scalar-1024')
assert len(variants)==17
runtime=root/'build/astra-toolchain/root/usr/lib64';asanflags=['-fsanitize=address,undefined','-fno-omit-frame-pointer',f'-B{runtime}',f'-Wl,-rpath,{runtime}']
def run(label,cmd,env=None,timeout=600):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:r=subprocess.run(cmd,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=timeout)
 steps.append(dict(label=label,command=cmd,status=r.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert r.returncode==0,label
try:
 for sanitized in [False,True]:
  source=root/'build'/('astra-v8-asan' if sanitized else 'astra-v8');env=dict(os.environ,GZRAM_VARIANT_LIST=','.join(variants))
  for key in ['GZRAM_HYBRID_SCREEN','GZRAM_CORPUS_LIST','GZRAM_ENERGY_FD']:env.pop(key,None)
  if sanitized:env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
  for shared in [0,1,2]:
   selected=list(variants)
   if shared==2:
    for policy in ['bitdirect','bitdirectpipe4','bitdirectavxbits4','bitdirectblock2avxbits4','bitdirectblock3avxbits4']:
     selected.append(f'ghy-{policy}shared-avx2-1024')
    selected.append('ghy-bitdirectshared-scalar-1024')
   env['GZRAM_VARIANT_LIST']=','.join(selected)
   name=('asan-' if sanitized else '')+(['own','shared','aliases'][shared]);target=root/'build'/('astra-v8-isolated-'+name);target.mkdir()
   for f in source.glob('*.so'):os.link(f,target/f.name)
   shutil.copy2(source/'manifest.json',target/'manifest.json')
   flags=['gcc','-O1' if sanitized else '-O2','-g','-Wall','-Wextra','-Werror','-DOPS=8192',f'-DSHARED_DECODE={shared}']+(asanflags if sanitized else [])
   command=[*flags,'gzram/bench-isolated.c','-ldl','-o',str(target/'benchmark')];run(name+'-build',command)
   metadata=dict(command=command,source_hashes=hashes,binary_sha256=hashlib.sha256((target/'benchmark').read_bytes()).hexdigest(),calls_per_batch=8192,shared_decode=shared,operation_order='random permutation of all (variant, operation) tasks each round',setup='All frames prepared before timing; restore immutable frames into common addresses; no encoder invoked immediately before timed decode setup',maximum_frame_banks=64)
   (target/'benchmark-build.json').write_text(json.dumps(metadata,indent=2)+'\n')
   run(name+'-all-corpora',[str(target/'benchmark'),str(target),'--validate-only'],env)
   # Exercise timed bookkeeping and shuffled operation tasks under sanitizers too.
   smoke=out/(name+'-smoke');cmd=[f.replace('-DOPS=8192','-DOPS=128') for f in flags]+['gzram/bench-isolated.c','-ldl','-o',str(smoke)];run(name+'-smoke-build',cmd)
   smoke_env=dict(env,GZRAM_CORPUS_LIST='repeat16,sparse-words,random')
   with (out/(name+'-smoke.csv')).open('w') as stdout,(out/(name+'-smoke.stderr')).open('w') as stderr:
    result=subprocess.run([str(smoke),str(target)],env=smoke_env,stdout=stdout,stderr=stderr,timeout=600)
   assert result.returncode==0,(name,result.returncode)
   rows=list(csv.DictReader((out/(name+'-smoke.csv')).open()));assert len(rows)==len(selected)*3*18
   assert len({(r['corpus'],r['round'],r['variant'],r['operation']) for r in rows})==len(rows)
   tasks=[line.split() for line in (out/(name+'-smoke.stderr')).read_text().splitlines() if line.startswith('Task ')]
   assert len(tasks)==len(rows)
   seen_before=set()
   for corpus in ['repeat16','sparse-words','random']:
    for round in range(9):
     round_tasks=[t for t in tasks if t[1]==corpus and int(t[2])==round];assert {int(t[3]) for t in round_tasks}==set(range(2*len(selected)))
     for v in selected:
      sequence=[t[5] for t in round_tasks if t[4]==v];seen_before.add(sequence[0]);assert set(sequence)=={'compress','decompress'}
   assert seen_before=={'compress','decompress'}
   if shared==2:
    lines=(out/(name+'-smoke.stderr')).read_text().splitlines();entries={x.split()[1]:x.split()[3] for x in lines if x.startswith('Entry ')}
    assert entries['ghy-bitdirect-avx2-1024']==entries['ghy-bitdirectshared-avx2-1024']
    assert all(entries[v]==entries['ghy-bitdirect-avx2-1024'] for v in selected if 'shared-avx2-' in v)
    for corpus in ['repeat16','sparse-words','random']:
     frames={x.split()[2]:x.split()[3] for x in lines if x.startswith('Frames '+corpus+' ')}
     assert all(frames[v]==frames['ghy-bitdirect-avx2-1024'] for v in selected if 'shared-avx2-' in v)

   steps.append(dict(label=name+'-timed-smoke',status=0,rows=len(rows),random_order_verified=True));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n')
 assert hashes=={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
 (out/'result.json').write_text(json.dumps(dict(status='passed',variants=variants,source_hashes=hashes,steps=len(steps)),indent=2)+'\n')
except BaseException as e:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e),steps=len(steps)),indent=2)+'\n');raise
