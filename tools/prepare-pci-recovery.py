#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Back up stock boot entries and use the observed working PCI restart route."""
import argparse,json,shlex,shutil,subprocess,os,hashlib
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);p.add_argument('--kernels',nargs='+',required=True);a=p.parse_args()
if os.geteuid()!=0:raise SystemExit('Root required')
if a.output.exists():raise SystemExit('Existing recovery evidence must be preserved')
a.output.mkdir(parents=True);records=[]
def out(args):return subprocess.check_output(args,text=True).strip()
for kernel in a.kernels:
 assert kernel.startswith('/boot/vmlinuz-') and Path(kernel).is_file()
 info=out(['grubby','--info='+kernel]);entry_id=next(shlex.split(line.split('=',1)[1])[0] for line in info.splitlines() if line.startswith('id='))
 assert '/' not in entry_id
 entry=Path('/boot/loader/entries')/(entry_id+'.conf')
 shutil.copy2(entry,a.output/entry.name)
 records.append({'kernel':kernel,'kernel_sha256':hashlib.sha256(Path(kernel).read_bytes()).hexdigest(),'entry':str(entry),'backup':entry.name,'entry_sha256':hashlib.sha256(entry.read_bytes()).hexdigest()})
record={'entries':records,'saved_default':out(['grubby','--default-kernel']),'reboot_type_before':Path('/sys/kernel/reboot/type').read_text().strip()}
(a.output/'before.json').write_text(json.dumps(record,indent=2)+'\n')
for kernel in a.kernels:
 subprocess.run(['grubby','--update-kernel='+kernel,'--args=reboot=pci panic=10 nmi_watchdog=1 efi_pstore.pstore_disable=0 pstore.kmsg_bytes=8192'],check=True)
Path('/sys/kernel/reboot/type').write_text('pci')
for key,value in [('panic',10),('panic_on_oops',1),('nmi_watchdog',1),('hardlockup_panic',1),('softlockup_panic',1)]:
 subprocess.run(['sysctl','-w',f'kernel.{key}={value}'],check=True)
Path('/sys/module/efi_pstore/parameters/pstore_disable').write_text('N')
assert Path('/sys/module/pstore/parameters/backend').read_text().strip()=='efi_pstore'
assert out(['grubby','--default-kernel'])==record['saved_default']
subprocess.run(['journalctl','--flush'],check=True);os.sync()
print('Stock entries backed up; PCI/panic/pstore settings prepared; default preserved.')
