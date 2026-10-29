import hashlib,json,pathlib,runpy,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');old=root/'build/astra-zram-device-vm-001';out=root/'build/astra-zram-device-vm-001-review';out.mkdir()
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
with (out/'parser-tests.log').open('w') as log:subprocess.run(['python3','gzram/tests/zram-vm-records.py','--serial',str(old/'serial.log')],cwd=root,check=True,stdout=log,stderr=subprocess.STDOUT)
parse=runpy.run_path(str(root/'gzram/tools/zram_vm_records.py'))['parse_device_records'];previous=json.loads((old/'result.json').read_text());parsed=parse((old/'serial.log').read_text())
expected={(str(c),a) for c in [1,2] for a in previous['algorithms']}
assert previous['exit_code']==0 and not previous['experimental_host_module_loaded']
assert previous['before_settings']==previous['after_settings']
assert not parsed['protocol_errors'] and not parsed['failure_tokens'] and parsed['pass_markers']==1
assert len(parsed['records'])==len(expected) and {(r['cycle'],r['algorithm']) for r in parsed['records']}==expected
assert all(int(r['corpora'])==len(previous['corpus_sha256']) and int(r['workers'])==4 and int(r['checks'])>0 for r in parsed['records'])
paths={'kernel':pathlib.Path('/boot/vmlinuz-7.2.11-200.fc44.x86_64'),'module':root/'build/astra-zram-bitdirect-001/zram.ko','client':root/'build/astra-zram-bitdirect-build-001/zram-roundtrip','qemu':root/'build/astra-vm/root/usr/bin/qemu-system-x86_64','busybox':root/'build/astra-vm/root/usr/bin/busybox','bios':root/'build/astra-vm/root/usr/share/seabios/bios-256k.bin'}
for name,path in paths.items():assert sha(path)==previous['hashes'][name],name
for name,digest in previous['corpus_sha256'].items():assert sha(root/'build/astra-zram-corpora-001'/name)==digest,name
record=dict(status='passed after console-protocol parser correction',scope='Acceptance of the existing completed exact-kernel diskless guest run; no repeat VM run, host module load, timing, energy or pressure claim',time=time.time(),original_status=previous['status'],original_result_sha256=sha(old/'result.json'),original_console_sha256=sha(old/'serial.log'),original_runner_sha256=sha(old/'vm-selftest-original.py'),parser_sha256=sha(root/'gzram/tools/zram_vm_records.py'),parser_tests_sha256=sha(root/'gzram/tests/zram-vm-records.py'),console_protocol=parsed,checks_per_run=[int(r['checks']) for r in parsed['records']],total_client_checks=sum(int(r['checks']) for r in parsed['records']),input_hashes_reverified=True,host_settings_preserved=True,reason='One tty completion marker was split by a timestamped kernel capacity-change message. All ten clients completed; the new parser reconstructs records while checking the unmodified raw console for every original warning/failure token. Original false-failure artifacts remain unchanged.')
(out/'result.json').write_text(json.dumps(record,indent=2)+'\n');print(record['status'],record['total_client_checks'])
