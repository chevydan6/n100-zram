#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Restore this lab's saved boot entry and recovery policy after inspection."""
from pathlib import Path
import argparse,hashlib,json,os,shutil,subprocess
p=argparse.ArgumentParser();p.add_argument('--backup',type=Path,required=True);a=p.parse_args()
if os.geteuid()!=0:raise SystemExit('Administrator access required')
record=json.loads((a.backup/'before.json').read_text())
entry=Path(record['entry_path']);assert entry.resolve().parent==Path('/boot/loader/entries').resolve()
backup=a.backup/'stock-entry.conf'
assert hashlib.sha256(backup.read_bytes()).hexdigest()==record['entry_sha256']
assert hashlib.sha256(Path(record['default_kernel']).read_bytes()).hexdigest()==record['kernel_sha256']
config=Path('/etc/sysctl.d/99-n100-zram-lab.conf')
expected='# N100 experimental ZRAM crash recovery; see lab recovery backup.\n'+''.join(f'kernel.{key} = {value}\n' for key,value in record['target_policy'].items())
if config.exists():assert config.read_text()==expected,'Recovery policy changed since preparation; inspect it manually'
shutil.copy2(backup,entry)
if config.exists():config.unlink()
for key,value in record['runtime_policy_before'].items():
 if Path('/proc/sys/kernel',key).exists():subprocess.run(['sysctl','-w',f'kernel.{key}={value}'],check=True)
os.sync()
print('Saved stock boot entry and prior runtime policy restored.')
print('Current boot default:',subprocess.check_output(['grubby','--default-kernel'],text=True).strip())
