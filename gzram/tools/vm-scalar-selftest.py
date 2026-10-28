#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Run the scalar component self-test in a bounded, diskless KVM guest.

Correctness only. No native module loading, ZRAM changes, disk/network devices,
or performance conclusions. Serialize with native measurements on the N100.
"""
import argparse
import fcntl
import hashlib
import json
import os
import re
import stat
import subprocess
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
for name in ['kernel', 'module', 'qemu', 'busybox', 'bios', 'qemu-data', 'output']:
    p.add_argument('--' + name, type=Path, required=True)
p.add_argument('--library-path', type=Path)
p.add_argument('--kind', choices=['scalar','hybrid','probe'], default='scalar')
p.add_argument('--probe-client', type=Path)
p.add_argument('--corpora-directory', type=Path)
p.add_argument('--guest-avx2', action='store_true')
p.add_argument('--probe-measurement-client', action='store_true')
p.add_argument('--probe-fpu-control', action='store_true')
p.add_argument('--lock', type=Path, default=Path.home() / '.cache/n100-zram/native-validation.lock')
a = p.parse_args()
if a.kind == 'probe' and (not a.probe_client or not a.corpora_directory):
    p.error('Probe validation requires --probe-client and --corpora-directory')
if a.kind != 'probe' and (a.guest_avx2 or a.probe_measurement_client):
    p.error('Probe client options require --kind probe')
if a.probe_fpu_control and not a.probe_measurement_client:
    p.error('FPU measurement control requires --probe-measurement-client')
a.lock.parent.mkdir(parents=True, exist_ok=True)
lock = a.lock.open('a+')
try:
    fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
except BlockingIOError:
    raise SystemExit('Native validation lock is held; no VM started')
meminfo = dict(line.split(':', 1) for line in Path('/proc/meminfo').read_text().splitlines())
if int(meminfo['MemAvailable'].split()[0]) < 2 * 1024**2:
    raise SystemExit('Less than 2 GiB available memory; defer the 256 MiB guest')
assert not a.output.exists()
a.output.mkdir(parents=True)
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
module_name = 'n100_gzram_hybrid_probe' if a.kind == 'probe' else 'n100_gzram_' + a.kind + '_selftest'
assert a.module.name == module_name + '.ko'
marker = 'GZRAM_' + a.kind.upper()
release = subprocess.check_output(['modinfo', '-F', 'vermagic', str(a.module)], text=True).split()[0]
assert re.fullmatch(r'[A-Za-z0-9_.+-]+', release)
archive = bytearray()
ino = 0

def add(name, data=b'', mode=stat.S_IFREG | 0o644, rmaj=0, rmin=0):
    global ino
    ino += 1
    encoded = name.encode() + b'\0'
    values = [ino, mode, 0, 0, 1, 0, len(data), 0, 0, rmaj, rmin, len(encoded), 0]
    archive.extend(('070701' + ''.join(f'{v:08x}' for v in values)).encode())
    archive.extend(encoded)
    archive.extend(b'\0' * (-len(archive) % 4))
    archive.extend(data)
    archive.extend(b'\0' * (-len(archive) % 4))

for name in ['bin', 'dev', 'proc', 'sys']:
    add(name, mode=stat.S_IFDIR | 0o755)
add('dev/console', mode=stat.S_IFCHR | 0o600, rmaj=5, rmin=1)
add('bin/busybox', a.busybox.read_bytes(), mode=stat.S_IFREG | 0o755)
add('selftest.ko', a.module.read_bytes())
probe_hashes = {}
if a.kind == 'probe':
    add('probe-client', a.probe_client.read_bytes(), mode=stat.S_IFREG | 0o755)
    add('corpora', mode=stat.S_IFDIR | 0o755)
    for corpus in sorted(a.corpora_directory.glob('*.bin')):
        assert re.fullmatch(r'[A-Za-z0-9_-]+\.bin', corpus.name)
        data = corpus.read_bytes()
        assert len(data) == 128 * 4096
        add('corpora/' + corpus.name, data)
        probe_hashes[corpus.name] = sha(corpus)
    assert probe_hashes
init = '''#!/bin/busybox sh
export PATH=/bin
/bin/busybox --install -s /bin
fail() { echo GZRAM_SCALAR_VM_FAIL; poweroff -f; while :; do sleep 1; done; }
mount -t proc proc /proc || fail
mount -t sysfs sysfs /sys || fail
mount -t devtmpfs devtmpfs /dev || fail
[ "$(uname -r)" = "RELEASE" ] || fail
echo GUEST_KERNEL=$(uname -r)
for pass in 1 2; do
 insmod /selftest.ko || fail
 rmmod n100_gzram_scalar_selftest || fail
done
echo GZRAM_SCALAR_VM_PASS
poweroff -f
'''.replace('RELEASE', release).replace('n100_gzram_scalar_selftest', module_name).replace('GZRAM_SCALAR', marker)
if a.kind == 'probe':
    init = init.replace(' insmod /selftest.ko || fail',
                        ' insmod /selftest.ko || fail\n /probe-client /corpora/*.bin || fail')
    if a.probe_measurement_client:
        init = init.replace(' /probe-client /corpora/*.bin || fail',
                            ' /probe-client /corpora/*.bin || fail\n'
                            ' /probe-client --measure /corpora/*.bin\n'
                            ' [ "$?" -eq 3 ] || fail\n'
                            ' echo GHY_NATIVE_TIMING_REFUSED')
        if a.probe_fpu_control:
            init = init.replace('/probe-client ', '/probe-client --fpu-control ')
add('init', init.encode(), mode=stat.S_IFREG | 0o755)
add('TRAILER!!!')
initramfs = a.output / 'initramfs.cpio'
initramfs.write_bytes(archive)
command = [str(a.qemu.resolve()), '-no-user-config', '-nodefaults',
           '-machine', 'q35,accel=kvm', '-cpu', 'host' if a.guest_avx2 else 'host,-avx2', '-smp', '2', '-m', '256',
           '-display', 'none', '-monitor', 'none', '-serial', 'stdio', '-nic', 'none',
           '-no-reboot', '-bios', str(a.bios.resolve()), '-L', str(a.qemu_data.resolve()),
           '-kernel', str(a.kernel.resolve()), '-initrd', str(initramfs.resolve()),
           '-append', 'console=ttyS0 rdinit=/init panic=1']
env = dict(os.environ)
if a.library_path:
    env['LD_LIBRARY_PATH'] = str(a.library_path.resolve())
record = dict(scope='Diskless VM ' + ('scalar GZR1' if a.kind == 'scalar' else 'scalar GHY1 workspace') + ' correctness only; no native performance, recovery or ZRAM result',
              command=command, kernel_release=release, host_mem_available_kib=int(meminfo['MemAvailable'].split()[0]),
              disks_attached=False, network_attached=False, guest_memory_mib=256, guest_cpus=2,
              hashes={name: sha(getattr(a, name)) for name in ['kernel', 'module', 'qemu', 'busybox', 'bios']},
              initramfs_sha256=sha(initramfs))
if a.kind == 'probe':
    record['scope'] = 'Diskless scalar GHY1 syscall-interface correctness only; no native timing, SIMD state, recovery or ZRAM result'
    record['probe_client_sha256'] = sha(a.probe_client)
    record['corpus_sha256'] = probe_hashes
    record['guest_avx2_exposed'] = a.guest_avx2
    record['measurement_refusal_required'] = a.probe_measurement_client
    record['fpu_control_required'] = a.probe_fpu_control
with (a.output / 'serial.log').open('w') as serial, (a.output / 'stderr.log').open('w') as error:
    try:
        result = subprocess.run(command, env=env, stdout=serial, stderr=error, timeout=180)
        record['exit_code'] = result.returncode
    except subprocess.TimeoutExpired:
        record['exit_code'] = None
        record['error'] = 'Guest exceeded 180-second correctness deadline and was killed'
text = (a.output / 'serial.log').read_text()
record['worker_results'] = re.findall(marker + r'_SELFTEST_PASS workers=(\d+) checks=(\d+)', text)
checks_passed = len(record['worker_results']) == 2 and all(int(w) == 4 and int(c) > 0 for w, c in record['worker_results'])
if a.kind == 'probe':
    record['client_results'] = re.findall(r'GHY_PROBE_CLIENT_PASS corpora=(\d+) checks=(\d+)', text)
    checks_passed = len(record['client_results']) == 2 and all(int(n) == len(probe_hashes) and int(c) > 0 for n, c in record['client_results'])
    if a.probe_measurement_client:
        checks_passed = checks_passed and text.count('GHY_NATIVE_TIMING_REFUSED') == 2
        if a.guest_avx2:
            checks_passed = checks_passed and text.count('vector_state_checked=1') == 2
        if a.probe_fpu_control:
            checks_passed = checks_passed and text.count('fpu_control=1') == 2
record['status'] = 'passed' if (record['exit_code'] == 0 and marker + '_VM_PASS' in text
    and checks_passed
    and not any(word in text for word in [marker + '_VM_FAIL', 'Kernel panic', 'Oops:', 'BUG:', 'WARNING:'])) else 'failed'
(a.output / 'result.json').write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps(record))
raise SystemExit(0 if record['status'] == 'passed' else 1)
