import hashlib,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root);out=root/'build/astra-v3-validation';assert out.is_dir();results=json.loads((out/"steps.json").read_text())
files=['gzram/src/gzram.c','gzram/src/hybrid.c','gzram/tools/build.py','gzram/bench.c','gzram/tests/hybrid.py','gzram/tools/run-native.py','gzram/tools/with-rapl.py']
hashes=json.loads((out/'source-hashes.json').read_text());assert hashes=={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
def run(label,args,env=None,timeout=1200):
 previous=next((r for r in results if r['label']==label),None)
 if previous is not None:
  assert previous['status']==0 and previous['command']==args
  return
 logfile=out/(label+'.log')
 if logfile.exists():logfile.rename(out/(label+'.interrupted.log'))
 start=time.time()
 with (out/(label+'.log')).open('w') as log:result=subprocess.run(args,stdout=log,stderr=subprocess.STDOUT,env=env,timeout=timeout)
 results.append(dict(label=label,command=args,status=result.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(results,indent=2)+'\n')
 if result.returncode:raise SystemExit(label+' failed')
runtime=root/'build/astra-toolchain/root/usr/lib64';asanflags=f'-fsanitize=address,undefined -fno-omit-frame-pointer -B{runtime} -Wl,-rpath,{runtime}'
for name,sanitized in [('astra-v3',False),('astra-v3-asan',True)]:
 directory=root/'build'/name;assert not directory.exists() or any(r['label']==name+'-build' and r['status']==0 for r in results);env=dict(os.environ)
 if sanitized:env['EXTRA_CFLAGS']=asanflags
 else:env.pop('EXTRA_CFLAGS',None)
 run(name+'-build',['python3','gzram/tools/build.py','--output',str(directory)],env)
 command=['gcc','-O1' if sanitized else '-O2','-g','-Wall','-Wextra','-Werror','-DOPS=8192']
 if sanitized:command+=asanflags.split()
 command+=['gzram/bench.c','-ldl','-o',str(directory/'benchmark')];run(name+'-bench-build',command)
 (directory/'benchmark-build.json').write_text(json.dumps(dict(command=command,source_sha256=hashes['gzram/bench.c'],binary_sha256=hashlib.sha256((directory/'benchmark').read_bytes()).hexdigest(),calls_per_batch=8192),indent=2)+'\n')
 if not sanitized:run('codegen',['python3','gzram/tools/audit-codegen.py','--baseline','build/astra-v2','--candidate',str(directory),'--output',str(out/'codegen.json')])
 if sanitized:env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
 for policy in ['ctzfull','bitctz','bitfull','select2','select3','select4','repeatmergefast','wordmixed']:
  command=['python3','gzram/tests/hybrid.py','--library',str(directory/f'libgzram-hybrid-{policy}.so')]
  if policy in ['ctzfull','bitctz','bitfull','select2','select3','select4']:
   command+=['--same-encoding-libraries',str(directory/'libgzram-hybrid-wordmixed.so'),str(directory/'libgzram-hybrid-ctzunpack.so'),'--other-libraries',str(directory/'libgzram-hybrid-ctzunpack.so')]
  elif policy=='repeatmergefast':command+=['--same-encoding-libraries',str(directory/'libgzram-hybrid-repeatmerge.so'),'--other-libraries',str(directory/'libgzram-hybrid-wordmixed.so')]
  else:command+=['--other-libraries',str(directory/'libgzram-hybrid-repeatmergefast.so')]
  run(name+'-'+policy,command,env)
 run(name+'-registry',[str(directory/'benchmark'),str(directory),'--validate-only'],env)
run('sizes',['python3','gzram/tools/measure-sizes.py','--directory','build/astra-v3','--benchmark','build/astra-v3/benchmark','--output','build/astra-v3-sizes'])
run('size-summary',['python3','gzram/tools/summarize-sizes.py','--input','build/astra-v3-sizes'])
assert hashes=={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
(out/'result.json').write_text(json.dumps(dict(status='passed',steps=len(results),source_hashes_unchanged=True),indent=2)+'\n')
