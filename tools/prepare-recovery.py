#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Back up the current stock boot entry and enable bounded test-crash recovery."""
from pathlib import Path
import argparse,os,platform,subprocess,json,hashlib,shutil,shlex
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args()
if os.geteuid()!=0:raise SystemExit('Administrator access required')
if a.output.exists():raise SystemExit('Refuse to overwrite prior recovery evidence')
release=platform.release();kernel='/boot/vmlinuz-'+release
def command(args):return subprocess.check_output(args,text=True).strip()
assert command(['grubby','--default-kernel'])==kernel,'Running kernel is not the default; inspect before changing recovery policy'
info=command(['grubby','--info='+kernel]);entry_id=next(shlex.split(x.split('=',1)[1])[0] for x in info.splitlines() if x.startswith('id='))
assert '/' not in entry_id
entry=Path('/boot/loader/entries')/(entry_id+'.conf');assert entry.is_file()
a.output.mkdir(parents=True)
shutil.copy2(entry,a.output/'stock-entry.conf');shutil.copy2('/boot/grub2/grubenv',a.output/'grubenv')
policy={'panic':10,'panic_on_oops':1,'nmi_watchdog':1,'hardlockup_panic':1,'softlockup_panic':1}
original={key:Path('/proc/sys/kernel',key).read_text().strip() for key in policy}
config=Path('/etc/sysctl.d/99-n100-zram-lab.conf')
assert not config.exists(),'Existing recovery policy must be inspected rather than overwritten'
record={'default_kernel':kernel,'release':release,'kernel_sha256':hashlib.sha256(Path(kernel).read_bytes()).hexdigest(),'entry_path':str(entry),'entry_sha256':hashlib.sha256(entry.read_bytes()).hexdigest(),'runtime_policy_before':original,'target_policy':policy,'note':'NMI watchdog had already been enabled during this lab session; initial inspection reported 0.'}
(a.output/'before.json').write_text(json.dumps(record,indent=2)+'\n')
config.write_text('# N100 experimental ZRAM crash recovery; see lab recovery backup.\n'+''.join(f'kernel.{key} = {value}\n' for key,value in policy.items()))
for key,value in policy.items():subprocess.run(['sysctl','-w',f'kernel.{key}={value}'],check=True)
subprocess.run(['grubby','--update-kernel='+kernel,'--args=panic=10 nmi_watchdog=1 efi_pstore.pstore_disable=0 pstore.kmsg_bytes=8192'],check=True)
assert command(['grubby','--default-kernel'])==kernel
subprocess.run(['journalctl','--flush'],check=True);os.sync()
(a.output/'prepared.json').write_text(json.dumps({'status':'prepared','recovery_tested':False,'default_kernel':kernel,'boot_entry_backup':str(a.output/'stock-entry.conf')},indent=2)+'\n')
print('Recovery settings prepared; a successful reboot/crash test is still required.')
