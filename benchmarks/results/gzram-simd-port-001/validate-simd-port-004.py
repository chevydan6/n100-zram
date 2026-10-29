import fcntl,hashlib,json,os,pathlib,re,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
status=root/'build/astra-audit/simd-port-004-queue.json'
def state(s,**kw):status.write_text(json.dumps(dict(status=s,time=time.time(),**kw),indent=2)+'\n')
state('waiting for isolated V9 validation and exclusive lock')
try:
 deadline=time.monotonic()+7200
 while True:
  p=root/'build/astra-audit/v9-isolated-002-queue.json'
  if p.exists() and json.loads(p.read_text())['status'].startswith(('complete;','failed;')):break
  if time.monotonic()>deadline:raise TimeoutError('V9 validation still pending')
  time.sleep(10)
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);state('validating SIMD workspace port')
  d=root/'build/astra-simd-port-004';out=root/'build/astra-simd-port-004-validation';out.mkdir();steps=[]
  manifest=json.loads((d/'manifest.json').read_text())
  sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
  for name,h in manifest['generated_sha256'].items():assert sha(d/name)==h,name
  watched=['gzram/tests/hybrid.py','gzram/tests/workspace.py','gzram/tools/prepare-simd-hybrid.py'];hashes={n:sha(root/n) for n in watched}
  def run(label,cmd,env=None):
   start=time.time()
   with (out/(label+'.log')).open('w') as log:r=subprocess.run(cmd,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=1200)
   steps.append(dict(label=label,command=cmd,status=r.returncode,seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert r.returncode==0,label
  runtime=root/'build/astra-toolchain/root/usr/lib64';asan=['-fsanitize=address,undefined','-fno-omit-frame-pointer',f'-B{runtime}',f'-Wl,-rpath,{runtime}']
  sources=['scalar/encoder/core.c','scalar/decoder/core.c','scalar/hybrid.c','scalar/lz4_compress.c','scalar/lz4_decompress.c','fallback.c','dispatch.c','userspace-adapter.c','vector-encoder/core.c','vector-decoder/core.c','vector-trial.c']
  for sanitized in [False,True]:
   suffix='-asan' if sanitized else '';extra=asan if sanitized else [];objects=[];audit={}
   for source in sources:
    obj=out/(source.replace('/','-')+suffix+'.o');vector=source.startswith('vector')
    flags=['-mavx2'] if vector else ['-mno-sse','-mno-mmx','-mno-avx']
    run('build-'+obj.stem,['gcc','-O3','-g','-fPIC','-Wall','-Wextra','-Werror','-fno-tree-vectorize','-fno-strict-aliasing',*flags,*extra,'-I'+str(root/'include'),'-c',str(d/source),'-o',str(obj)])
    objects.append(str(obj))
    asm=subprocess.check_output(['objdump','-d',str(obj)],text=True)
    hasvector=bool(re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm))
    assert hasvector==vector,(source,hasvector)
    audit[source]=dict(vector_registers=hasvector,object_sha256=sha(obj),disassembly_sha256=hashlib.sha256(asm.encode()).hexdigest())
   (out/('codegen'+suffix+'.json')).write_text(json.dumps(audit,indent=2)+'\n')
   library=out/('libsimd'+suffix+'.so')
   run('link'+suffix,['gcc','-shared','-Wl,-Bsymbolic-functions',*extra,*objects,'-o',str(library)])
   env=dict(os.environ)
   if sanitized:env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
   reference=root/'build/astra-v8/libgzram-hybrid-bitdirectblock2avxbits4.so'
   run('hybrid'+suffix,['python3','gzram/tests/hybrid.py','--library',str(library),'--same-encoding-libraries',str(reference),'--other-libraries',str(root/'build/astra-v8/libgzram-hybrid-wordmixed.so')],env)
   run('workspace'+suffix,['python3','gzram/tests/workspace.py','--library',str(library),'--reference',str(reference),'--api-prefix','n100_simd','--reference-isa','avx2'],env)
   # Exercise feature-unavailable fallback even on the physical AVX2 machine.
   forced=out/('dispatch-forced'+suffix+'.o')
   run('forced-build'+suffix,['gcc','-O3','-g','-fPIC','-Wall','-Wextra','-Werror','-fno-tree-vectorize','-fno-strict-aliasing','-mno-sse','-mno-mmx','-mno-avx','-DN100_TEST_FORCE_SCALAR',*extra,'-I'+str(root/'include'),'-c',str(d/'dispatch.c'),'-o',str(forced)])
   forcedlib=out/('libforced'+suffix+'.so');forcedobjects=[str(forced) if pathlib.Path(o).name=='dispatch.c'+suffix+'.o' else o for o in objects]
   run('forced-link'+suffix,['gcc','-shared','-Wl,-Bsymbolic-functions',*extra,*forcedobjects,'-o',str(forcedlib)])
   run('forced-hybrid'+suffix,['python3','gzram/tests/hybrid.py','--library',str(forcedlib),'--same-encoding-libraries',str(reference),'--other-libraries',str(root/'build/astra-v8/libgzram-hybrid-wordmixed.so')],env)
   run('forced-workspace'+suffix,['python3','gzram/tests/workspace.py','--library',str(forcedlib),'--reference',str(reference),'--api-prefix','n100_simd'],env)
  assert hashes=={n:sha(root/n) for n in watched}
  for name,h in manifest['generated_sha256'].items():assert sha(d/name)==h,name
  (out/'result.json').write_text(json.dumps(dict(status='passed',steps=len(steps),source_hashes=hashes,scope='Userspace SIMD port, forced scalar fallback and object isolation; kernel compilation/execution/performance pending'),indent=2)+'\n')
 state('complete; kernel build pending')
except BaseException as e:
 state('failed; preserve artifacts',error=repr(e))
 if 'out' in globals() and out.exists():(out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e)),indent=2)+'\n')
 raise
