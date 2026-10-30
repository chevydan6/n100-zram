import hashlib,json,pathlib,subprocess,sys,time
r=pathlib.Path('/home/dan/n100-zram');sys.path.insert(0,str(r/'gzram/tools'))
from coexist_vm_records import parse_coexist_markers
from zram_vm_records import parse_device_records
out=r/'build/terra-coexist-review-003';out.mkdir();sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
try:
 test=subprocess.run(['python3','gzram/tests/coexist-vm-records.py'],cwd=r,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,check=True);(out/'parser-tests.log').write_text(test.stdout)
 vm=r/'build/astra-vm/root';paths=dict(kernel=pathlib.Path('/boot/vmlinuz-7.2.11-200.fc44.x86_64'),module=r/'build/terra-coexist-zram-001/n100_zram.ko',stock_module=pathlib.Path(subprocess.check_output(['modinfo','-n','zram'],text=True).strip()),client=r/'build/terra-coexist-gate-001/client',qemu=vm/'usr/bin/qemu-system-x86_64',busybox=vm/'usr/bin/busybox',bios=vm/'usr/share/seabios/bios-256k.bin')
 results={};algs=['ghy-bitdirect','ghy-simd','lz4-ghy','lz4','zstd'];expected={(str(c),a) for c in [1,2] for a in algs}
 for mode in ['fallback','avx2']:
  source=r/('build/terra-coexist-vm-002-'+mode);record=json.loads((source/'result.json').read_text());raw=(source/'serial.log').read_text();general=parse_device_records(raw);coexist=parse_coexist_markers(raw,algs)
  for name,path in paths.items():assert sha(path)==record['hashes'][name],(mode,name)
  for name,digest in record['corpus_sha256'].items():assert sha(r/'build/astra-zram-corpora-001'/name)==digest,(mode,name)
  assert record['exit_code']==0 and record['before_settings']==record['after_settings'] and not record['experimental_host_module_loaded']
  assert general['pass_markers']==1 and not general['protocol_errors'] and not general['failure_tokens']
  assert len(general['records'])==10 and {(x['cycle'],x['algorithm']) for x in general['records']}==expected
  assert all(int(x['corpora'])==26 and int(x['workers'])==4 and int(x['checks'])==24197 for x in general['records'])
  assert not coexist['errors'] and set(coexist['completed'])==expected and len(coexist['completed'])==10 and coexist['unloads']==2
  results[mode]=dict(original_status=record['status'],original_result_sha256=sha(source/'result.json'),serial_sha256=sha(source/'serial.log'),console_protocol=general,coexist_markers=coexist,scope='Reanalysis of preserved run; no native measurement or direct SIMD path counter')
 (out/'result.json').write_text(json.dumps(dict(status='passed after strict coexistence marker reconstruction',results=results,parser_sha256=sha(r/'gzram/tools/coexist_vm_records.py'),tests_sha256=sha(r/'gzram/tests/coexist-vm-records.py'),time=time.time()),indent=2)+'\n')
 print('Both original guests pass strict reanalysis; raw failure remains preserved')
except BaseException as e:(out/'result.json').write_text(json.dumps(dict(status='failed',error=repr(e)),indent=2)+'\n');raise
