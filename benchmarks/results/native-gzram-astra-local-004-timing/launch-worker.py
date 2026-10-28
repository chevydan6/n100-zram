import hashlib,json,os,pathlib,platform,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
assert os.geteuid()==1000
assert json.loads((root/'build/astra-v4-validation/result.json').read_text())['status']=='passed'
snapshot=root/'build/astra-v4/source-checkpoint';provenance=json.loads((snapshot/'source-provenance.json').read_text())
for path,digest in provenance['source_hashes'].items():assert hashlib.sha256((snapshot/path).read_bytes()).hexdigest()==digest,path
variants=['lz4-small-scalar']
for policy in ['wordmixed','bitctz','repeatmergefast','blockpick2','blockpick3','blockpick4','bitmerge','bitdirect']:
 for isa in ['scalar','avx2']:variants.append(f'ghy-{policy}-{isa}-1024')
variants += ['ghy-mixpack-avx2-1024','ghy-select3-avx2-1024','ghy-bitfull-scalar-1024','ghy-wordrepeat-scalar-1024']
assert len(variants)==21
previous=json.loads((root/'build/astra-local-003-preflight.json').read_text())
files={}
for name,entry in previous['files'].items():
 data=pathlib.Path(name).read_bytes();digest=hashlib.sha256(data).hexdigest()
 if '/power_supply/' not in name:assert digest==entry['sha256'],name
 try:value=data.decode().strip()
 except UnicodeDecodeError:value=None
 files[name]=dict(sha256=digest,value=value)
preflight=dict(kernel=platform.release(),target='Local physical Lenovo 14e Intel N100',source_commit=provenance['source_commit'],time=time.time(),boot_id=pathlib.Path('/proc/sys/kernel/random/boot_id').read_text().strip(),files=files,live_swaps=pathlib.Path('/proc/swaps').read_text(),meminfo=pathlib.Path('/proc/meminfo').read_text(),pressure=pathlib.Path('/proc/pressure/memory').read_text(),recovery_policy_observed={name:pathlib.Path('/proc/sys/kernel',name).read_text().strip() for name in ['panic','panic_on_oops','nmi_watchdog','hardlockup_panic','softlockup_panic']},scope_note='Userspace only. No current-kernel recovery claim, native module load or ZRAM change.')
with (root/'build/astra-local-004-timing-preflight.json').open('x') as output:json.dump(preflight,output,indent=2);output.write('\n')
command=['/usr/bin/python3',str(snapshot/'gzram/tools/supervise.py'),'--status',str(root/'build/astra-audit/v4-timing-supervisor.json'),'--timeout','2100','--lock-wait','3600','--','/usr/bin/nice','-n','5','/usr/bin/python3',str(snapshot/'gzram/tools/run-native.py'),'--directory',str(root/'build/astra-v4'),'--output',str(root/'build/astra-local-004-timing'),'--variants',*variants]
with (root/'build/astra-audit/v4-timing-command.json').open('x') as output:json.dump(command,output,indent=2);output.write('\n')
os.execv(command[0],command)
