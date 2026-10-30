import fcntl,hashlib,json,os,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);out=r/'build/terra-combined-sampling-validation-001';out.mkdir();steps=[]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
files=['gzram/src/hybrid.c','gzram/src/gzram.c','gzram/src/gzram.h','gzram/tests/hybrid.py','benchmarks/sample-owned-compile.py'];before={f:sha(r/f) for f in files}
def run(label,cmd,env=None):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:p=subprocess.run(cmd,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=1200)
 steps.append(dict(label=label,command=cmd,status=p.returncode,seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==0,label
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);runtime=r/'build/astra-toolchain/root/usr/lib64';artifacts={}
  for sanitized in [False,True]:
   src=r/'build'/('astra-v9-asan' if sanitized else 'astra-v9');label='asan' if sanitized else 'normal';directory=out/label;directory.mkdir();manifest=json.loads((src/'manifest.json').read_text());flags=manifest['flags'];base=manifest['candidate_extra_flags']['hybrid_policies']['bitdirectblock2avxbits4bounded'];extra=['-fsanitize=address,undefined','-fno-omit-frame-pointer','-B'+str(runtime),'-Wl,-rpath,'+str(runtime)] if sanitized else []
   objects=[src/x for x in ['hybrid-block2avxbits4base.o','hybrid-ctz.o','private-lz4_compress.o','private-lz4_decompress.o']];parent=src/'libgzram-hybrid-bitdirectblock2avxbits4bounded.so';env=dict(os.environ)
   if sanitized:env.update(LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
   for n in (16,64):
    lib=directory/f'combined-sample{n}.so';defs=base+['-DGZRAM_HYBRID_SAMPLE=1','-DGZRAM_HYBRID_SAMPLE_REPEAT=1',f'-DGZRAM_HYBRID_SAMPLE_WORDS={n}'];cmd=['gcc',*flags,*extra,*defs,'-I'+str(src/'lz4-small/include'),'-I'+str(r/'include'),'-I'+str(r/'gzram/src'),'-shared','-Wl,-Bsymbolic-functions',str(r/'gzram/src/hybrid.c'),*map(str,objects),'-o',str(lib)];run(label+f'-build-{n}',cmd)
    run(label+f'-hybrid-{n}',['python3','gzram/tests/hybrid.py','--library',str(lib),'--other-libraries',str(parent),str(src/'libgzram-hybrid-wordmixed.so')],env);artifacts[label+str(n)]={'sha256':sha(lib),'flags':defs}
  assert before=={f:sha(r/f) for f in files};(out/'result.json').write_text(json.dumps(dict(status='passed',scope='Additive userspace sampling candidates; no performance claim',sources=before,artifacts=artifacts,steps=steps),indent=2)+'\n')
except BaseException as e:(out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e),steps=steps),indent=2)+'\n');raise
