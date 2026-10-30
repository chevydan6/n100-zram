#!/usr/bin/env python3
"""Select the verified BTF entry once; never reboot or change the saved default.

Run as root under the native validation lock, only when the user is ready.
"""
import hashlib
import os
from pathlib import Path
import subprocess

if os.geteuid() != 0:
    raise SystemExit('Requires root')
normal = '/boot/vmlinuz-7.2.11-200.fc44.x86_64'
entry = 'aeb3aaea811340878e653417f0ea7836-7.2.11-n100-gzram-btf'
saved = 'aeb3aaea811340878e653417f0ea7836-7.2.11-200.fc44.x86_64'
files = {
    '/boot/vmlinuz-7.2.11-n100-gzram-btf': 'fb9e8cce4a00984945c8b39cc0333b54da61f3b0a8b95f029de9f15a4b0d31ee',
    '/boot/initramfs-7.2.11-n100-gzram-btf.img': '28328846514fffaeb09e388a54600ed981dd53dba01c1102b517ab5d4bac4d6a',
    '/usr/lib/modules/7.2.11-n100-gzram-btf/kernel/drivers/block/zram/zram.ko': '62e3e2a72484a6d5557e22b9238ddd9f717e45798a3fac969a55782d46467a03',
}
def read(*args):
    return subprocess.check_output(args, text=True).strip()
def env():
    return dict(line.split('=', 1) for line in read('grub2-editenv', '/boot/grub2/grubenv', 'list').splitlines() if '=' in line)
if read('uname', '-r') != '7.2.11-200.fc44.x86_64' or read('grubby', '--default-kernel') != normal:
    raise SystemExit('Normal running or default kernel differs')
for name, expected in files.items():
    if hashlib.sha256(Path(name).read_bytes()).hexdigest() != expected:
        raise SystemExit('Artifact hash mismatch: ' + name)
if read('restorecon', '-nRv', '/usr/lib/modules/7.2.11-n100-gzram-btf'):
    raise SystemExit('Experimental module labels need correction')
info = read('grubby', '--info=/boot/vmlinuz-7.2.11-n100-gzram-btf')
if 'id="' + entry + '"' not in info or '/boot/initramfs-7.2.11-n100-gzram-btf.img' not in info:
    raise SystemExit('Boot entry differs from verified target')
before = env()
if before.get('saved_entry') != saved or before.get('next_entry', ''):
    raise SystemExit('Unexpected saved or pending boot entry')
try:
    subprocess.run(['grub2-reboot', entry], check=True)
    after = env()
    if after.get('saved_entry') != saved or after.get('next_entry') != entry:
        raise RuntimeError('One-time selection did not verify')
except BaseException:
    subprocess.run(['grub2-editenv', '/boot/grub2/grubenv', 'unset', 'next_entry'], check=False)
    raise
print('Verified one-time BTF entry; saved Fedora default unchanged. No reboot initiated.')
