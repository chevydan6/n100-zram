import hashlib,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root);out=root/'build/astra-probe-client-001';out.mkdir()
command=['gcc','-O2','-g','-Wall','-Wextra','-Werror','-static','-pthread','-B'+str(root/'build/astra-vm/root/usr/lib64'),'-L'+str(root/'build/astra-vm/root/usr/lib64'),'gzram/tests/hybrid-probe.c','-o',str(out/'client')]
record=dict(command=command,scope='Static device-interface correctness client and unchanged benchmark fixtures; no timing')
with (out/'build.log').open('w') as log:result=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT)
record['exit_code']=result.returncode
if result.returncode==0:
 record['binary_sha256']=hashlib.sha256((out/'client').read_bytes()).hexdigest();record['file']=subprocess.check_output(['file',str(out/'client')],text=True)
 assert 'statically linked' in record['file']
 record['source_sha256']={p:hashlib.sha256((root/p).read_bytes()).hexdigest() for p in ['gzram/tests/hybrid-probe.c','gzram/kernel/hybrid-probe.h']}
 env=dict(os.environ)
 for name in ['GZRAM_CORPUS_LIST','GZRAM_VARIANT_LIST','GZRAM_HYBRID_SCREEN','GZRAM_ENERGY_FD']:env.pop(name,None)
 fixture=[str(root/'build/astra-v4/benchmark'),str(root/'build/astra-v4')]
 names=subprocess.check_output(fixture+['--list-corpora'],env=env,text=True).splitlines();assert len(names)==20
 directory=out/'corpora';directory.mkdir();hashes={}
 expected=json.loads((root/'build/astra-v4-sizes/metadata.json').read_text())['corpus_sha256']
 for name in names:
  data=subprocess.check_output(fixture+['--dump-corpus='+name],env=env);assert len(data)==128*4096
  digest=hashlib.sha256(data).hexdigest();assert digest==expected[name]
  (directory/(name+'.bin')).write_bytes(data);hashes[name]=digest
 record['corpus_sha256']=hashes
record['status']='built' if result.returncode==0 else 'failed'
(out/'result.json').write_text(json.dumps(record,indent=2)+'\n');assert result.returncode==0
