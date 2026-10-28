import hashlib,json,os,pathlib,re,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
assert json.loads((root/'build/astra-local-003-timing/checkpoint.json').read_text())['status']=='complete'
out=root/'build/astra-hybrid-port-001';out.mkdir();steps=[]
files=['gzram/tools/prepare-scalar-hybrid.py','gzram/tools/prepare-scalar-port.py','gzram/tests/workspace.py','gzram/tests/hybrid.py','gzram/src/gzram.c','gzram/src/gzram.h','gzram/src/hybrid.c']
hashes={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files};(out/'source-hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
def run(label,command,env=None):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:
  result=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,env=env,timeout=1200)
 steps.append(dict(label=label,command=list(map(str,command)),status=result.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n')
 assert result.returncode==0,label
runtime=root/'build/astra-toolchain/root/usr/lib64'
flags=['-O3','-g','-fPIC','-shared','-Wall','-Wextra','-Werror','-fno-tree-vectorize','-fno-strict-aliasing','-mno-sse','-mno-mmx','-mno-avx']
asan=['-fsanitize=address,undefined','-fno-omit-frame-pointer','-B'+str(runtime),'-Wl,-rpath,'+str(runtime)]
environment=dict(os.environ,LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
try:
 core=out/'bitpack-core'
 run('bitpack-prepare',['python3','gzram/tools/prepare-scalar-port.py','--output',str(core),'--pack','ctz'])
 for sanitized in [False,True]:
  suffix='-asan' if sanitized else '';library=core/('libscalar'+suffix+'.so')
  run('bitpack-build'+suffix,['gcc',*flags,*(asan if sanitized else []),str(core/'core.c'),'-o',str(library)])
  run('bitpack-check'+suffix,['python3','gzram/tests/check.py','--library',str(library)],environment if sanitized else None)
 control=root/'build/astra-scalar-port-001/control';ctz=root/'build/astra-scalar-port-001/ctz'
 for policy,encoder,decoder in [('wordmixed',control,control),('ctzunpack',control,ctz),('bitctz',core,ctz)]:
  d=out/policy
  run(policy+'-prepare',['python3','gzram/tools/prepare-scalar-hybrid.py','--encoder-core',str(encoder),'--decoder-core',str(decoder),'--output',str(d)])
  for sanitized in [False,True]:
   suffix='-asan' if sanitized else '';library=d/(f'libghy-{policy}'+suffix+'.so')
   sources=[d/name for name in ['encoder/core.c','decoder/core.c','hybrid.c','lz4_compress.c','lz4_decompress.c','userspace-adapter.c']]
   run(policy+'-build'+suffix,['gcc',*flags,*(asan if sanitized else []),'-Wl,-Bsymbolic-functions','-I'+str(d),'-I'+str(root/'include'),*map(str,sources),'-o',str(library)])
   env=environment if sanitized else None
   reference=root/'build/astra-v3/libgzram-hybrid-wordmixed.so'
   run(policy+'-hybrid'+suffix,['python3','gzram/tests/hybrid.py','--library',str(library),'--same-encoding-libraries',str(reference),'--other-libraries',str(reference)],env)
   run(policy+'-workspace'+suffix,['python3','gzram/tests/workspace.py','--library',str(library),'--reference',str(reference)],env)
   asm=subprocess.check_output(['objdump','-d',str(library)],text=True)
   assert not re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm),library
   (out/(policy+suffix+'-disassembly.sha256')).write_text(hashlib.sha256(asm.encode()).hexdigest()+'\n')
 assert hashes=={f:hashlib.sha256((root/f).read_bytes()).hexdigest() for f in files}
 (out/'result.json').write_text(json.dumps(dict(status='passed',steps=len(steps),source_hashes_unchanged=True,scope='Userspace scalar GHY1 explicit-workspace correctness; kernel compilation, kernel execution and performance untested'),indent=2)+'\n')
except BaseException as error:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(error),completed_steps=len(steps)),indent=2)+'\n');raise
