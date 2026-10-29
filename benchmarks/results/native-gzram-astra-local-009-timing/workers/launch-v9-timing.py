import hashlib,json,os,pathlib,platform,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
assert os.geteuid()==1000
if pathlib.Path('/sys/class/power_supply/AC/online').read_text().strip()=='0':
 assert int(pathlib.Path('/sys/class/power_supply/BAT0/capacity').read_text())>=20,'Battery below 20%; preserve the prepared cohort and connect power before launching'
assert json.loads((root/'build/astra-v9-validation-002/result.json').read_text())['status']=='passed'
snapshot=root/'build/astra-v9/source-checkpoint';provenance=json.loads((snapshot/'source-provenance.json').read_text())
for path,digest in provenance['source_hashes'].items():assert hashlib.sha256((snapshot/path).read_bytes()).hexdigest()==digest,path
assert json.loads((root/'build/astra-v9-isolated-validation/result.json').read_text())['status']=='passed'
variants=json.loads((root/'build/astra-v9-isolated-validation/result.json').read_text())['variants']
for policy in ['bitdirect','bitdirectbounded','bitdirectblock2avxbits4bounded','bitdirectblock3avxbits4bounded']:
 variants.append(f'ghy-{policy}shared-avx2-1024')
variants.append('ghy-bitdirectshared-scalar-1024')
assert len(variants)==16
previous=json.loads((root/'build/astra-local-003-preflight.json').read_text())
files={}
for name,entry in previous['files'].items():
 data=pathlib.Path(name).read_bytes();digest=hashlib.sha256(data).hexdigest()
 # Fresh live snapshot: settings may differ from any historical cohort.
 try:value=data.decode().strip()
 except UnicodeDecodeError:value=None
 files[name]=dict(sha256=digest,value=value)
preflight=dict(kernel=platform.release(),target='Local physical Lenovo 14e Intel N100',source_commit=provenance['source_commit'],time=time.time(),boot_id=pathlib.Path('/proc/sys/kernel/random/boot_id').read_text().strip(),files=files,live_swaps=pathlib.Path('/proc/swaps').read_text(),meminfo=pathlib.Path('/proc/meminfo').read_text(),pressure=pathlib.Path('/proc/pressure/memory').read_text(),recovery_policy_observed={name:pathlib.Path('/proc/sys/kernel',name).read_text().strip() for name in ['panic','panic_on_oops','nmi_watchdog','hardlockup_panic','softlockup_panic']},scope_note='Userspace only. No current-kernel recovery claim, native module load or ZRAM change.')
preflight['process_snapshot']=subprocess.check_output(['ps','-eo','pid,comm,pcpu,pmem','--sort=-pcpu'],text=True)
with (root/'build/astra-local-009-timing-preflight.json').open('x') as output:json.dump(preflight,output,indent=2);output.write('\n')
command=['/usr/bin/python3',str(snapshot/'gzram/tools/supervise.py'),'--status',str(root/'build/astra-audit/v9-timing-supervisor.json'),'--timeout','5400','--lock-wait','7200','--','/usr/bin/nice','-n','5','/usr/bin/python3',str(snapshot/'gzram/tools/run-native.py'),'--directory',str(root/'build/astra-v9-isolated-aliases'),'--output',str(root/'build/astra-local-009-timing'),'--variants',*variants]
with (root/'build/astra-audit/v9-timing-command.json').open('x') as output:json.dump(command,output,indent=2);output.write('\n')
os.execv(command[0],command)
