import hashlib,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root);out=root/'build/astra-v7-validation';out.mkdir();results=[]
files=['gzram/src/gzram.c','gzram/src/hybrid.c','gzram/tools/build.py','gzram/bench.c','gzram/tests/hybrid.py','gzram/tools/run-native.py','gzram/tools/with-rapl.py']
hashes={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files};(out/'source-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
def run(label,args,env=None,timeout=1200):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:result=subprocess.run(args,stdout=log,stderr=subprocess.STDOUT,env=env,timeout=timeout)
 results.append(dict(label=label,command=args,status=result.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(results,indent=2)+'\n')
 if result.returncode:raise RuntimeError(label+' failed')
runtime=root/'build/astra-toolchain/root/usr/lib64';asanflags=f'-fsanitize=address,undefined -fno-omit-frame-pointer -B{runtime} -Wl,-rpath,{runtime}'
try:
 for name,sanitized in [('astra-v7',False),('astra-v7-asan',True)]:
  directory=root/'build'/name;assert not directory.exists();env=dict(os.environ)
  for key in ['GZRAM_CORPUS_LIST','GZRAM_VARIANT_LIST','GZRAM_HYBRID_SCREEN','GZRAM_ENERGY_FD']:env.pop(key,None)
  if sanitized:env['EXTRA_CFLAGS']=asanflags
  else:env.pop('EXTRA_CFLAGS',None)
  run(name+'-build',['python3','gzram/tools/build.py','--output',str(directory)],env)
  command=['gcc','-O1' if sanitized else '-O2','-g','-Wall','-Wextra','-Werror','-DOPS=8192']
  if sanitized:command+=asanflags.split()
  command+=['gzram/bench.c','-ldl','-o',str(directory/'benchmark')];run(name+'-bench-build',command)
  (directory/'benchmark-build.json').write_text(json.dumps(dict(command=command,source_sha256=hashes['gzram/bench.c'],binary_sha256=hashlib.sha256((directory/'benchmark').read_bytes()).hexdigest(),calls_per_batch=8192),indent=2)+'\n')
  if not sanitized:run('codegen',['python3','gzram/tools/audit-codegen.py','--baseline','build/astra-v6','--candidate',str(directory),'--output',str(out/'codegen.json')])
  if sanitized:env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
  for policy in ['bitdirectpipe1','bitdirectpipe2','bitdirectpipe4','bitdirectavxbits2','bitdirectavxbits4']:
   command=['python3','gzram/tests/hybrid.py','--library',str(directory/f'libgzram-hybrid-{policy}.so'),'--same-encoding-libraries',str(directory/'libgzram-hybrid-bitdirect.so'),'--other-libraries',str(directory/'libgzram-hybrid-wordmixed.so')]
   run(name+'-'+policy,command,env)
  run(name+'-registry',[str(directory/'benchmark'),str(directory),'--validate-only'],env)
 run('sizes',['python3','gzram/tools/measure-sizes.py','--directory','build/astra-v7','--benchmark','build/astra-v7/benchmark','--output','build/astra-v7-sizes'])
 run('size-summary',['python3','gzram/tools/summarize-sizes.py','--input','build/astra-v7-sizes'])
 assert hashes=={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
 (out/'result.json').write_text(json.dumps(dict(status='passed',steps=len(results),source_hashes_unchanged=True),indent=2)+'\n')
except BaseException as error:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(error),completed_steps=len(results)),indent=2)+'\n');raise
