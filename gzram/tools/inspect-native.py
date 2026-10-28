#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Print a private, read-only native/recovery inventory as JSON.

Run unprivileged first; root can resolve protected boot metadata later. This
does not arm recovery, load modules, open watchdog devices or change settings.
Raw boot arguments/process paths may be identifying: review before publishing.
"""
import hashlib
import json
import os
from pathlib import Path
import platform
import pwd
import subprocess
import time


def command(argv):
    try:
        result = subprocess.run(argv, capture_output=True, text=True, timeout=15)
        return dict(command=argv, status=result.returncode,
                    stdout=result.stdout.strip(), stderr=result.stderr.strip())
    except (OSError, subprocess.TimeoutExpired) as error:
        return dict(command=argv, error=repr(error))


def read(path, binary=False):
    try:
        data = path.read_bytes()
        return dict(sha256=hashlib.sha256(data).hexdigest(), bytes=len(data),
                    value=None if binary else data.decode().strip())
    except (OSError, UnicodeError) as error:
        return dict(error=repr(error))


def entries(directory):
    try:
        return {str(p): read(p) for p in sorted(directory.iterdir()) if p.suffix == '.conf'}
    except OSError as error:
        return {'error': repr(error)}


uid = os.getuid()
if uid == 0 and os.environ.get('PKEXEC_UID', '').isdigit():
    uid = int(os.environ['PKEXEC_UID'])
account = pwd.getpwuid(uid)
release = platform.release()
lock = Path(account.pw_dir) / '.cache/n100-zram/native-validation.lock'
default = command(['grubby', '--default-kernel'])
default_path = Path(default.get('stdout', ''))
valid_default = (default.get('status') == 0 and
                 str(default_path).startswith('/boot/vmlinuz-') and default_path.is_file())
fixed = ['/sys/block/zram0/comp_algorithm', '/sys/block/zram0/disksize']
for cpu in sorted(Path('/sys/devices/system/cpu').glob('cpu[0-9]*')):
    fixed += [str(cpu / 'cpufreq' / key) for key in
              ['scaling_governor', 'scaling_min_freq', 'scaling_max_freq']]
settings = {name: read(Path(name)) for name in fixed if Path(name).exists()}
settings['/sys/module/zram/notes/.note.gnu.build-id'] = read(Path('/sys/module/zram/notes/.note.gnu.build-id'), True)
locks = command(['lslocks', '--json', '--output', 'PID,COMMAND,PATH'])
if locks.get('status') == 0:
    locks = [item for item in json.loads(locks['stdout'])['locks'] if item.get('path') == str(lock)]
processes = command(['ps', '-eo', 'pid,ppid,stat,etime,args'])
if processes.get('status') == 0:
    processes = [line for line in processes['stdout'].splitlines()
                 if any(word in line for word in ['n100-zram', 'qemu-system', 'swapoff', 'swapon'])]
report = dict(
    time=time.time(), uid=os.getuid(), inspected_account=account.pw_name,
    kernel=release, boot_id=read(Path('/proc/sys/kernel/random/boot_id')),
    scope='Read-only inventory, not proof of recovery; no setting or device mutation',
    current_kernel_image=read(Path('/boot/vmlinuz-' + release), True),
    current_kernel_info=command(['grubby', '--info=/boot/vmlinuz-' + release]),
    default_kernel_read=default, valid_default_kernel_image=valid_default,
    default_kernel_image=read(default_path, True) if valid_default else None,
    boot_entries=entries(Path('/boot/loader/entries')),
    grub_environment=command(['grub2-editenv', '/boot/grub2/grubenv', 'list']),
    command_line=read(Path('/proc/cmdline')),
    runtime_recovery={key: read(Path('/proc/sys/kernel') / key) for key in
                      ['panic', 'panic_on_oops', 'nmi_watchdog', 'hardlockup_panic', 'softlockup_panic']},
    reboot={key: read(Path('/sys/kernel/reboot') / key) for key in ['type', 'mode', 'force']},
    watchdogs={str(p): {key: read(p / key) for key in ['identity', 'state', 'timeout']}
               for p in Path('/sys/class/watchdog').glob('watchdog*')},
    pstore_backend=read(Path('/sys/module/pstore/parameters/backend')),
    pstore_disable=read(Path('/sys/module/efi_pstore/parameters/pstore_disable')),
    selinux=command(['getenforce']), native_lock_path=str(lock), native_lock_owners=locks,
    relevant_processes=processes,
    preserved_settings=settings, swaps=read(Path('/proc/swaps')),
    memory=read(Path('/proc/meminfo')), memory_pressure=read(Path('/proc/pressure/memory')),
    experimental_modules=[line for line in Path('/proc/modules').read_text().splitlines()
                          if line.startswith(('n100_', 'gzram'))],
)
print(json.dumps(report, indent=2))
