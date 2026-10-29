import hashlib,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root);out=root/'build/astra-v9-validation-002';out.mkdir();results=[]
files=['gzram/src/gzram.c','gzram/src/hybrid.c','gzram/tools/build.py','gzram/bench.c','gzram/tests/hybrid.py','gzram/tools/run-native.py','gzram/tools/with-rapl.py']
hashes={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files};(out/'source-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
def run(label,args,env=None,timeout=1200):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:result=subprocess.run(args,stdout=log,stderr=subprocess.STDOUT,env=env,timeout=timeout)
 results.append(dict(label=label,command=args,status=result.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(results,indent=2)+'\n')
 if result.returncode:raise RuntimeError(label+' failed')
runtime=root/'build/astra-toolchain/root/usr/lib64';asanflags=f'-fsanitize=address,undefined -fno-omit-frame-pointer -B{runtime} -Wl,-rpath,{runtime}'
try:
 for name,sanitized in [('astra-v9',False),('astra-v9-asan',True)]:
  directory=root/'build'/name;env=dict(os.environ)
  for key in ['GZRAM_CORPUS_LIST','GZRAM_VARIANT_LIST','GZRAM_HYBRID_SCREEN','GZRAM_ENERGY_FD']:env.pop(key,None)
  if sanitized:env['EXTRA_CFLAGS']=asanflags
  else:env.pop('EXTRA_CFLAGS',None)
  if not sanitized:
   # Only the Python fixture variable changed. Preserve and verify the normal
   # build already produced by the failed test-harness attempt.
   manifest=json.loads((directory/'manifest.json').read_text())
   for path,digest in manifest['source_sha256'].items():assert hashlib.sha256((root/path).read_bytes()).hexdigest()==digest,path
   for path,digest in manifest['artifacts'].items():assert hashlib.sha256((directory/path).read_bytes()).hexdigest()==digest,path
   benchmark=json.loads((directory/'benchmark-build.json').read_text())
   assert benchmark['source_sha256']==hashes['gzram/bench.c']
   assert benchmark['binary_sha256']==hashlib.sha256((directory/'benchmark').read_bytes()).hexdigest()
   previous=root/'build/astra-v9-validation';audit=json.loads((previous/'codegen.json').read_text())
   assert all(x['identical'] for x in audit.values())
   (out/'codegen.json').write_text(json.dumps(audit,indent=2)+'\n')
   record=dict(label='normal-build-reuse',status=0,reason='Only Python fixture loop variable renamed after harness TypeError; all codec/benchmark source and artifact hashes verified',previous_result=str(previous/'result.json'),previous_result_sha256=hashlib.sha256((previous/'result.json').read_bytes()).hexdigest(),manifest_sha256=hashlib.sha256((directory/'manifest.json').read_bytes()).hexdigest(),benchmark=benchmark,old_text_sections_preserved=len(audit))
   results.append(record);(out/'steps.json').write_text(json.dumps(results,indent=2)+'\n')
  else:
   assert not directory.exists()
   run(name+'-build',['python3','gzram/tools/build.py','--output',str(directory)],env)
   command=['gcc','-O1','-g','-Wall','-Wextra','-Werror','-DOPS=8192',*asanflags.split(),'gzram/bench.c','-ldl','-o',str(directory/'benchmark')]
   run(name+'-bench-build',command)
   (directory/'benchmark-build.json').write_text(json.dumps(dict(command=command,source_sha256=hashes['gzram/bench.c'],binary_sha256=hashlib.sha256((directory/'benchmark').read_bytes()).hexdigest(),calls_per_batch=8192),indent=2)+'\n')
  if sanitized:env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
  for policy in ['bitdirectbounded','bitdirectblock2avxbits4bounded','bitdirectblock3avxbits4bounded']:
   command=['python3','gzram/tests/hybrid.py','--library',str(directory/f'libgzram-hybrid-{policy}.so'),'--same-encoding-libraries',*dict.fromkeys([str(directory/f'libgzram-hybrid-{policy.removesuffix("bounded")}.so'),str(directory/'libgzram-hybrid-bitdirect.so')]),'--other-libraries',str(directory/'libgzram-hybrid-wordmixed.so')]
   run(name+'-'+policy,command,env)
  run(name+'-registry',[str(directory/'benchmark'),str(directory),'--validate-only'],env)
 run('sizes',['python3','gzram/tools/measure-sizes.py','--directory','build/astra-v9','--benchmark','build/astra-v9/benchmark','--output','build/astra-v9-sizes'])
 run('size-summary',['python3','gzram/tools/summarize-sizes.py','--input','build/astra-v9-sizes'])
 assert hashes=={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
 (out/'result.json').write_text(json.dumps(dict(status='passed',steps=len(results),source_hashes_unchanged=True),indent=2)+'\n')
except BaseException as error:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(error),completed_steps=len(results)),indent=2)+'\n');raise
