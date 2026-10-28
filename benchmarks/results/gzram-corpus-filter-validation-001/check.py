import fcntl,hashlib,json,os,pathlib,subprocess
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
lock=(pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('a+');fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
out=root/'build/astra-v3-long';command=[str(out/'benchmark'),str(out)];env=dict(os.environ);env.pop('GZRAM_CORPUS_LIST',None);env.pop('GZRAM_VARIANT_LIST',None)
corpora=subprocess.check_output(command+['--list-corpora'],env=env,text=True).splitlines();assert len(corpora)==20
assert subprocess.check_output(command+['--calls-per-batch'],env=env,text=True).strip()=='131072'
for corpus in corpora:
 a=subprocess.check_output(command+['--dump-corpus='+corpus],env=env)
 b=subprocess.check_output(['build/astra-v3/benchmark','build/astra-v3','--dump-corpus='+corpus],env=env)
 assert a==b,corpus
selected=dict(env,GZRAM_CORPUS_LIST='repeat16,repeat32',GZRAM_VARIANT_LIST='lz4-small-scalar,ghy-repeatmergefast-avx2-1024')
assert set(subprocess.check_output(command+['--list-corpora'],env=selected,text=True).splitlines())=={'repeat16','repeat32'}
with (out/'selection-validation.log').open('w') as log:subprocess.run(command+['--validate-only'],env=selected,stdout=log,stderr=subprocess.STDOUT,check=True)
invalid=subprocess.run(command+['--list-corpora'],env=dict(env,GZRAM_CORPUS_LIST='unknown'),capture_output=True,text=True);assert invalid.returncode==2
(out/'selection-check.json').write_text(json.dumps(dict(status='passed',all_corpora_preserved=20,selected_corpora=['repeat16','repeat32'],selected_variants=2,selected_roundtrips=512,unknown_selection_rejected=True,binary_sha256=hashlib.sha256((out/'benchmark').read_bytes()).hexdigest(),source_sha256=hashlib.sha256((root/'gzram/bench.c').read_bytes()).hexdigest(),calls_per_batch=131072),indent=2)+'\n')
(out/'benchmark-build.json').write_text(json.dumps(dict(command=['gcc','-O2','-g','-Wall','-Wextra','-Werror','-DOPS=131072','gzram/bench.c','-ldl','-o',str(out/'benchmark')],source_sha256=hashlib.sha256((root/'gzram/bench.c').read_bytes()).hexdigest(),binary_sha256=hashlib.sha256((out/'benchmark').read_bytes()).hexdigest(),calls_per_batch=131072),indent=2)+'\n')
