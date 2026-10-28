import hashlib,json,pathlib,shutil,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');source=root/'build/astra-local-003-energy-retry'
assert json.loads((source/'checkpoint.json').read_text())['status']=='complete'
logdir=root/'build/astra-v3-energy-analysis';logdir.mkdir();steps=[]
def run(label,command):
 start=time.time()
 with (logdir/(label+'.log')).open('w') as log:r=subprocess.run(command,cwd=root,stdout=log,stderr=subprocess.STDOUT,timeout=600)
 steps.append(dict(label=label,command=list(map(str,command)),status=r.returncode,elapsed_seconds=time.time()-start));(logdir/'steps.json').write_text(json.dumps(steps,indent=2)+'\n');assert r.returncode==0,label
try:
 audit=logdir/'audit.json';dest=root/'benchmarks/results/native-gzram-astra-local-003-energy'
 run('audit',['python3','gzram/tools/audit-native.py','--input',str(source),'--directory','build/astra-v3','--preflight','build/astra-local-003-preflight.json','--output',str(audit)])
 assert json.loads(audit.read_text())['package_energy_available_rows']==23760
 run('summary',['python3','gzram/tools/summarize-native.py','--input',str(source),'--output',str(dest)])
 run('paired',['python3','gzram/tools/analyze-paired.py','--input',str(source),'--output',str(logdir/'paired'),'--controls','wordmixed','ctzunpack','bitpack','mixpack','bitctz','repeatmerge'])
 for name in ['paired.json','paired.md']:shutil.copy2(logdir/'paired'/name,dest/name)
 shutil.copy2(audit,dest/'audit.json')
 shutil.copy2(root/'build/astra-v3/source-checkpoint/source-provenance.json',dest/'source-provenance.json')
 shutil.copy2(root/'build/astra-v3/benchmark-build.json',dest/'benchmark-build.json')
 (logdir/'result.json').write_text(json.dumps(dict(status='passed',scope='All raw rows and direct contrasts retained; interpretation pending',output=str(dest)),indent=2)+'\n')
except BaseException as error:
 (logdir/'result.json').write_text(json.dumps(dict(status='failed',error=repr(error)),indent=2)+'\n');raise
