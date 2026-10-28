import hashlib,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
assert json.loads((root/'build/astra-v8-validation/result.json').read_text())['status']=='passed'
out=root/'build/astra-v8-scans-validation';out.mkdir();steps=[]
source=root/'gzram/tests/scan-pipeline.py';digest=hashlib.sha256(source.read_bytes()).hexdigest()
for name,sanitized in [('astra-v8',False),('astra-v8-asan',True)]:
 env=dict(os.environ)
 if sanitized:env.update(LD_PRELOAD=str(root/'build/astra-toolchain/root/usr/lib64/libasan.so.8'),ASAN_OPTIONS='detect_leaks=0:abort_on_error=1',UBSAN_OPTIONS='halt_on_error=1:print_stacktrace=1')
 command=['python3',str(source),'--directory',str(root/'build'/name)];start=time.time()
 with (out/(name+'.log')).open('w') as log:r=subprocess.run(command,env=env,stdout=log,stderr=subprocess.STDOUT,timeout=600)
 steps.append(dict(command=command,status=r.returncode,elapsed_seconds=time.time()-start));(out/'steps.json').write_text(json.dumps(steps,indent=2)+'\n')
 assert r.returncode==0,name
assert hashlib.sha256(source.read_bytes()).hexdigest()==digest
(out/'result.json').write_text(json.dumps(dict(status='passed',source_sha256=digest,steps=steps),indent=2)+'\n')
