import hashlib,json,os,pathlib,re,subprocess,time,importlib.util
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root);out=root/'build/astra-scalar-generator-002';out.mkdir();steps=[]
source=root/'gzram/tools/prepare-scalar-port.py';digest=hashlib.sha256(source.read_bytes()).hexdigest()
spec=importlib.util.spec_from_file_location('codegen',root/'gzram/tools/audit-codegen.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
def run(label,command,env=None):
 start=time.time()
 with (out/(label+'.log')).open('w') as log:r=subprocess.run(command,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=600)
 steps.append(dict(label=label,command=command,status=r.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert r.returncode==0,label
runtime=root/'build/astra-toolchain/root/usr/lib64';flags=['gcc','-O3','-g','-fPIC','-shared','-Wall','-Wextra','-Werror','-fno-tree-vectorize','-fno-strict-aliasing','-mno-sse','-mno-mmx','-mno-avx']
comparisons={}
try:
 for name,options,previous in [('control',[],root/'build/astra-scalar-port-001/control'),('ctz',['--unpack','ctz'],root/'build/astra-scalar-port-001/ctz'),('bitpack',['--pack','ctz'],root/'build/astra-bitdirect-port-001/bitpack-core')]:
  target=out/name;run(name+'-prepare',['python3',str(source),'--output',str(target),*options])
  for sanitized in [False,True]:
   suffix='-asan' if sanitized else '';library=target/('libscalar'+suffix+'.so')
   extra=['-fsanitize=address,undefined','-fno-omit-frame-pointer','-B'+str(runtime),'-Wl,-rpath,'+str(runtime)] if sanitized else []
   run(name+'-build'+suffix,[*flags,*extra,str(target/'core.c'),'-o',str(library)])
   if not sanitized:
    comparisons[name]=dict(previous=module.text_sha(previous/'libscalar.so'),current=module.text_sha(library));assert len(set(comparisons[name].values()))==1,name
    asm=subprocess.check_output(['objdump','-d',str(library)],text=True);assert not re.search(r'%(?:xmm|ymm|zmm|mm)[0-9]+',asm)
   else:
    env=dict(os.environ,LD_PRELOAD=str(runtime/'libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
    run(name+'-sanitizer-check',['python3','gzram/tests/check.py','--library',str(library)],env)
 assert hashlib.sha256(source.read_bytes()).hexdigest()==digest
 (out/'result.json').write_text(json.dumps(dict(status='passed',generator_sha256=digest,scalar_text_comparisons=comparisons,steps=len(steps),scope='Generator maintenance only: previous scalar component code remains identical; not combined SIMD kernel integration'),indent=2)+'\n')
except BaseException as error:
 (out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(error),completed_steps=len(steps)),indent=2)+'\n');raise
