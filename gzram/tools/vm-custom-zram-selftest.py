#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded diskless-guest ZRAM device correctness, never host swap or timing."""
import argparse
import fcntl
import hashlib
import json
import lzma
import os
from pathlib import Path
import re
import stat
import subprocess
from zram_vm_records import parse_device_records

p = argparse.ArgumentParser(description=__doc__)
for name in ['kernel', 'module', 'client', 'corpora-directory', 'qemu', 'busybox', 'bios', 'qemu-data', 'output']:
    p.add_argument('--' + name, type=Path, required=True)
p.add_argument('--library-path', type=Path)
p.add_argument('--module-root', type=Path, required=True)
p.add_argument('--algorithms', nargs='+', default=['lzo-rle', 'lz4', 'zstd', 'lz4-ghy', 'ghy-bitdirect'])
p.add_argument('--guest-avx2', action='store_true', help='Expose host AVX2 in the isolated correctness guest')
p.add_argument('--require-btf', action='store_true', help='Require runtime kernel BTF in the guest')
p.add_argument('--lock', type=Path, default=Path.home() / '.cache/n100-zram/native-validation.lock')
a = p.parse_args()
if os.geteuid() == 0: p.error('Run this isolated guest launcher unprivileged')
assert 2 <= len(a.algorithms) <= 6 and len(a.algorithms) == len(set(a.algorithms))
assert ({'ghy-bitdirect', 'lz4-ghy'} <= set(a.algorithms) or
        {'lz4-small', 'lz4-control', 'lz4'} <= set(a.algorithms))
assert all(re.fullmatch(r'[a-z0-9-]+', name) for name in a.algorithms)
lock = a.lock.open('r+')
try: fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
except BlockingIOError: raise SystemExit('Native validation lock is held; no VM started')
mem = dict(line.split(':', 1) for line in Path('/proc/meminfo').read_text().splitlines())
assert int(mem['MemAvailable'].split()[0]) >= 2 * 1024**2, 'Defer guest: less than 2 GiB available'
assert not a.output.exists()
a.output.mkdir(parents=True)
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
def info(field, path):
    return subprocess.check_output(['modinfo', '-F', field, str(path)], text=True).strip()
release = info('vermagic', a.module).split()[0]
assert info('name', a.module) == 'zram' and a.module.name == 'zram.ko'
assert a.kernel.name == 'vmlinuz-' + release
settings = [Path('/sys/block/zram0/comp_algorithm'), Path('/sys/block/zram0/disksize'),
            Path('/sys/module/zram/notes/.note.gnu.build-id')]
settings += sorted(Path('/sys/devices/system/cpu').glob('cpu[0-9]*/cpufreq/scaling_*freq'))
settings += sorted(Path('/sys/devices/system/cpu').glob('cpu[0-9]*/cpufreq/scaling_governor'))
# Current frequency is transient; only policy limits belong in preservation checks.
settings = [f for f in settings if f.name != 'scaling_cur_freq']
before = {str(f): sha(f) for f in settings}
assert not any(line.startswith('n100_gzram') for line in Path('/proc/modules').read_text().splitlines()), 'Inspect existing experimental host modules first'
archive = bytearray(); inode = 0
def add(name, data=b'', mode=stat.S_IFREG | 0o644, rmaj=0, rmin=0):
    global inode
    inode += 1; encoded = name.encode() + b'\0'
    fields = [inode, mode, 0, 0, 1, 0, len(data), 0, 0, rmaj, rmin, len(encoded), 0]
    archive.extend(('070701' + ''.join(f'{v:08x}' for v in fields)).encode())
    archive.extend(encoded); archive.extend(b'\0' * (-len(archive) % 4))
    archive.extend(data); archive.extend(b'\0' * (-len(archive) % 4))
for name in ['bin', 'dev', 'proc', 'sys', 'modules', 'corpora']:
    add(name, mode=stat.S_IFDIR | 0o755)
add('dev/console', mode=stat.S_IFCHR | 0o600, rmaj=5, rmin=1)
add('bin/busybox', a.busybox.read_bytes(), mode=stat.S_IFREG | 0o755)
add('zram-client', a.client.read_bytes(), mode=stat.S_IFREG | 0o755)
add('gzram-diskless-guest', b'isolated correctness guest; no disks or network\n')
# Only read installed dependencies; load them exclusively inside the guest.
# Recursion preserves dependency order and records both packed and unpacked bytes.
dependencies = {}; visiting = set()
def dependency(name):
    assert re.fullmatch(r'[A-Za-z0-9_]+', name), name
    if name in dependencies: return
    assert name not in visiting, 'Module dependency cycle'
    visiting.add(name)
    path = subprocess.check_output(['modinfo', '-b', str(a.module_root.resolve()), '-k', release, '-n', name], text=True).strip()
    if path == '(builtin)': visiting.remove(name); return
    path = Path(path)
    assert info('vermagic', path).split()[0] == release
    for child in filter(None, info('depends', path).split(',')): dependency(child)
    data = path.read_bytes()
    if path.suffix == '.xz': data = lzma.decompress(data)
    elif path.suffix != '.ko': raise AssertionError('Unsupported module compression: ' + str(path))
    add('modules/' + name + '.ko', data)
    dependencies[name] = dict(path=str(path), sha256=sha(path), unpacked_sha256=hashlib.sha256(data).hexdigest())
    visiting.remove(name)
for name in filter(None, info('depends', a.module).split(',')): dependency(name)
add('zram.ko', a.module.read_bytes())
corpora = {}
for path in sorted(a.corpora_directory.glob('*.bin')):
    assert re.fullmatch(r'[A-Za-z0-9_-]+\.bin', path.name)
    data = path.read_bytes(); assert len(data) == 128 * 4096
    add('corpora/' + path.name, data); corpora[path.name] = sha(path)
assert 1 <= len(corpora) <= 64
init = '''#!/bin/busybox sh
export PATH=/bin
/bin/busybox --install -s /bin
fail() { echo GZRAM_DEVICE_VM_FAIL; poweroff -f; while :; do sleep 1; done; }
mount -t proc proc /proc || fail
mount -t sysfs sysfs /sys || fail
mount -t devtmpfs devtmpfs /dev || fail
[ "$(uname -r)" = "RELEASE" ] || fail
DEPENDENCIES
for pass in 1 2; do
 insmod /zram.ko num_devices=1 || fail
 for algorithm in ALGORITHMS; do
  echo "$algorithm" > /sys/block/zram0/comp_algorithm || fail
  echo 67108864 > /sys/block/zram0/disksize || fail
  echo GZRAM_DEVICE_BEGIN pass=$pass algorithm=$algorithm
  /zram-client /dev/zram0 /corpora/*.bin || fail
  echo GZRAM_DEVICE_STATS
  cat /sys/block/zram0/mm_stat || fail
  cat /sys/block/zram0/io_stat || fail
  echo 1 > /sys/block/zram0/reset || fail
  [ "$(cat /sys/block/zram0/disksize)" = 0 ] || fail
  echo GZRAM_DEVICE_END pass=$pass algorithm=$algorithm
 done
 rmmod zram || fail
 [ ! -e /sys/block/zram0 ] || fail
done
echo GZRAM_DEVICE_VM_PASS
poweroff -f
'''.replace('RELEASE', release).replace('ALGORITHMS', ' '.join(a.algorithms))
if a.require_btf:
    init = init.replace('DEPENDENCIES', '[ -s /sys/kernel/btf/vmlinux ] || fail\necho GZRAM_RUNTIME_BTF_PRESENT\nDEPENDENCIES')
init = init.replace('DEPENDENCIES', '\n'.join('insmod /modules/' + name + '.ko || fail' for name in dependencies))
add('init', init.encode(), mode=stat.S_IFREG | 0o755); add('TRAILER!!!')
initramfs = a.output / 'initramfs.cpio'; initramfs.write_bytes(archive)
command = [str(a.qemu.resolve()), '-no-user-config', '-nodefaults', '-machine', 'q35,accel=kvm',
           '-cpu', 'host' if a.guest_avx2 else 'host,-avx2', '-smp', '2', '-m', '256', '-display', 'none', '-monitor', 'none',
           '-serial', 'stdio', '-nic', 'none', '-no-reboot', '-bios', str(a.bios.resolve()),
           '-L', str(a.qemu_data.resolve()), '-kernel', str(a.kernel.resolve()),
           '-initrd', str(initramfs.resolve()), '-append', 'console=ttyS0 rdinit=/init panic=1']
env = dict(os.environ)
if a.library_path: env['LD_LIBRARY_PATH'] = str(a.library_path.resolve())
record = dict(scope='Isolated guest ZRAM device correctness; no native timing, energy, pressure, recovery or production claim',
              command=command, kernel_release=release, guest_memory_mib=256, guest_cpus=2,
              host_uid=os.getuid(), host_mem_available_kib=int(mem['MemAvailable'].split()[0]),
              disks_attached=False, network_attached=False, dependencies=dependencies,
              algorithms=a.algorithms, corpus_sha256=corpora, before_settings=before,
              hashes={name: sha(getattr(a,name)) for name in ['kernel','module','client','qemu','busybox','bios']},
              initramfs_sha256=sha(initramfs))
with (a.output / 'serial.log').open('w') as serial, (a.output / 'stderr.log').open('w') as error:
    try:
        result = subprocess.run(command, env=env, stdout=serial, stderr=error, timeout=180)
        record['exit_code'] = result.returncode
    except subprocess.TimeoutExpired:
        record.update(exit_code=None, error='Guest exceeded 180-second deadline and was killed')
text = (a.output / 'serial.log').read_text()
parsed = parse_device_records(text)
results = [(r['corpora'], r['workers'], r['checks']) for r in parsed['records']]
record['runtime_btf_required'] = a.require_btf
record['runtime_btf_present_marker'] = 'GZRAM_RUNTIME_BTF_PRESENT' in text
record['console_protocol'] = parsed
record['launcher_sha256'] = sha(Path(__file__))
record['parser_sha256'] = sha(Path(__file__).with_name('zram_vm_records.py'))
record['client_results'] = results
record['after_settings'] = {str(f): sha(f) for f in settings}
# Other unrelated modules may legitimately change; the stock ZRAM identity is
# checked directly by its preserved build-note hash above.
record['experimental_host_module_loaded'] = any(line.startswith('n100_gzram') for line in Path('/proc/modules').read_text().splitlines())
expected = {(str(cycle), algorithm) for cycle in [1,2] for algorithm in a.algorithms}
ends = [(r['cycle'], r['algorithm']) for r in parsed['records']]
passed = ((not a.require_btf or record['runtime_btf_present_marker']) and record['exit_code'] == 0 and parsed['pass_markers'] == 1 and not parsed['protocol_errors'] and len(results)==len(expected)
          and len(ends)==len(expected) and set(ends)==expected
          and all(int(n)==len(corpora) and int(w)==4 and int(c)>0 for n,w,c in results)
          and before==record['after_settings'] and not record['experimental_host_module_loaded']
          and not parsed['failure_tokens'])
record['status'] = 'passed' if passed else 'failed'
(a.output / 'result.json').write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(record))
raise SystemExit(0 if passed else 1)
