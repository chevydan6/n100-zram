#!/usr/bin/env python3
"""Recheck preserved guest logs after fixing printk-interleaved allocation markers."""
import hashlib,importlib.util,json,pathlib
root=pathlib.Path(__file__).resolve().parents[3];guest=root/'build/terra-vm-zram-corpus-allocation-001/guest';s=json.loads((guest/'result.json').read_text());text=(guest/'serial.log').read_text();sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def load(name,file):
 spec=importlib.util.spec_from_file_location(name,root/'gzram/tools'/file);mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod);return mod
protocol=load('dev','zram_vm_records.py').parse_device_records(text);coexist=load('co','coexist_vm_records.py').parse_coexist_markers(text,s['algorithms']);alloc=load('alloc','zram_allocation_records.py').parse_allocation_records(text,s['algorithms'],s['corpus_sha256']);expected={(str(i),x) for i in (1,2) for x in s['algorithms']}
assert s['status']=='failed' and s['exit_code']==0 and not s['disks_attached'] and not s['network_attached']
assert protocol['pass_markers']==1 and not protocol['protocol_errors'] and not protocol['failure_tokens'] and len(protocol['records'])==len(expected)
assert {(x['cycle'],x['algorithm']) for x in protocol['records']}==expected and all(int(x['corpora'])==len(s['corpus_sha256']) and int(x['workers'])==4 and int(x['checks'])>0 for x in protocol['records'])
assert not coexist['errors'] and set(coexist['completed'])==expected and coexist['unloads']==2
assert not alloc['errors'] and len(alloc['records'])==2*len(s['algorithms'])*len(s['corpus_sha256'])
assert s['before_settings']==s['after_settings'] and not s['experimental_host_module_loaded']
for key in ('kernel','module','stock_module','client','qemu','busybox','bios'):
 path=pathlib.Path(s['command'][s['command'].index('-kernel')+1]) if key=='kernel' else None
 if key=='module':path=root/'build/terra-coexist-zram-001/n100_zram.ko'
 if key=='stock_module':path=pathlib.Path('/lib/modules/7.2.11-200.fc44.x86_64/kernel/drivers/block/zram/zram.ko.xz')
 if key=='client':path=root/'build/terra-coexist-gate-001/client'
 if key=='qemu':path=root/'build/astra-vm/root/usr/bin/qemu-system-x86_64'
 if key=='busybox':path=root/'build/astra-vm/root/usr/bin/busybox'
 if key=='bios':path=root/'build/astra-vm/root/usr/share/seabios/bios-256k.bin'
 assert sha(path)==s['hashes'][key],key
for corpus,digest in s['corpus_sha256'].items():assert sha(root/'build/astra-zram-corpora-001'/corpus)==digest,corpus
print(json.dumps(dict(status='passed',scope='Reanalysis of preserved guest log; no native or statistical performance claim',original_status=s['status'],original_result_sha256=sha(guest/'result.json'),original_serial_sha256=sha(guest/'serial.log'),allocation_parser_sha256=sha(root/'gzram/tools/zram_allocation_records.py'),records=alloc['records']),indent=2))
