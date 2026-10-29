import hashlib,json,os,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);out=r/'build/astra-exec-bench-001';out.mkdir();steps=[]
def run(label,cmd,env=None):
 with (out/(label+'.log')).open('w') as log:p=subprocess.run(cmd,stdout=log,stderr=subprocess.STDOUT,env=env,timeout=900)
 steps.append(dict(label=label,command=cmd,status=p.returncode));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert p.returncode==0,label
try:
 variants=json.loads((r/'build/astra-v9-isolated-validation/result.json').read_text())['variants']
 for name in ['bitdirect','bitdirectbounded','bitdirectblock2avxbits4bounded','bitdirectblock3avxbits4bounded']:variants.append(f'ghy-{name}shared-avx2-1024')
 variants.append('ghy-bitdirectshared-scalar-1024')
 target=out/'benchmark';run('build',['gcc','-O2','-g','-Wall','-Wextra','-Werror','-DOPS=8192','-DSHARED_DECODE=2','gzram/bench-isolated.c','-ldl','-o',str(target)])
 env=dict(os.environ,GZRAM_VARIANT_LIST=','.join(variants),GZRAM_EXEC_CORPUS_DIR=str(r/'build/astra-exec-corpora-001'))
 old=json.loads((r/'build/astra-v9-sizes/metadata.json').read_text())['corpus_sha256']
 for name,digest in old.items():
  data=subprocess.check_output([str(target),'build/astra-v9-isolated-aliases','--dump-corpus='+name],env=env);assert hashlib.sha256(data).hexdigest()==digest,name
 manifest=json.loads((r/'build/astra-exec-corpora-001/manifest.json').read_text())
 for name in ['bash-exec','git-exec','libc-exec']:
  data=subprocess.check_output([str(target),'build/astra-v9-isolated-aliases','--dump-corpus='+name],env=env);assert data==(r/'build/astra-exec-corpora-001'/f'{name}.bin').read_bytes()
 env['GZRAM_CORPUS_LIST']='bash-exec,git-exec,libc-exec'
 run('validate',[str(target),'build/astra-v9-isolated-aliases','--validate-only'],env)
 (out/'result.json').write_text(json.dumps(dict(status='passed',original_corpora_identical=len(old),extra_corpora=3,variants=len(variants),scope='Userspace executable fixture and codec correctness; no performance measurement'),indent=2)+'\n')
except BaseException as e:(out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e)),indent=2)+'\n');raise
