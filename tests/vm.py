#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Diskless correctness-only kernel smoke test. Never attaches host disks/network."""
import argparse,stat,subprocess,json,hashlib,random,shutil
from pathlib import Path
p=argparse.ArgumentParser()
for name in ['kernel','probe','zram','lz4hc','output']:p.add_argument('--'+name,type=Path,required=True)
a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
mem=dict(line.split(':',1) for line in Path('/proc/meminfo').read_text().splitlines())
if int(mem['MemAvailable'].split()[0])<2*1024**2:raise SystemExit('Less than 2 GiB memory headroom; defer VM')
archive=bytearray();ino=0
def add(name,data=b'',mode=stat.S_IFREG|0o644,rmaj=0,rmin=0):
 global ino
 ino+=1;encoded=name.encode()+b'\0'
 values=[ino,mode,0,0,1,0,len(data),0,0,rmaj,rmin,len(encoded),0]
 archive.extend(('070701'+''.join(f'{v:08x}' for v in values)).encode());archive.extend(encoded)
 archive.extend(b'\0'*((-len(archive))%4));archive.extend(data);archive.extend(b'\0'*((-len(archive))%4))
for name in ['bin','dev','proc','sys','tmp']:add(name,mode=stat.S_IFDIR|0o755)
add('dev/console',mode=stat.S_IFCHR|0o600,rmaj=5,rmin=1)
add('bin/busybox',Path('/usr/bin/busybox').read_bytes(),mode=stat.S_IFREG|0o755)
add('probe.ko',a.probe.read_bytes());add('zram.ko',a.zram.read_bytes());add('lz4hc.ko',a.lz4hc.read_bytes())
rng=random.Random(100);corpus=bytearray()
for i in range(512):
 period=[1,3,7,8,15,16,31,32,33,64,127,4096][i%12]
 pat=bytes(rng.randrange(256) for _ in range(period));corpus.extend((pat*((4096+period-1)//period))[:4096])
add('corpus',corpus)
init='''#!/bin/busybox sh
export PATH=/bin
/bin/busybox --install -s /bin
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev
fail() { echo N100_ZRAM_VM_FAIL; poweroff -f; }
echo KERNEL_RELEASE=$(uname -r)
insmod /probe.ko iterations=128 || fail
rmmod n100_lz4_probe || fail
insmod /lz4hc.ko || fail
insmod /zram.ko num_devices=1 || fail
for algorithm in lz4 lz4-n100; do
 echo "$algorithm" > /sys/block/zram0/comp_algorithm || fail
 echo 4194304 > /sys/block/zram0/disksize || fail
 for pass in 1 2 3 4; do
  dd if=/corpus of=/dev/zram0 bs=4096 count=512 conv=fsync 2>/dev/null || fail
  dd if=/dev/zram0 of=/tmp/readback bs=4096 count=512 2>/dev/null || fail
  cmp /corpus /tmp/readback || fail
 done
 echo ALGORITHM=$algorithm
 cat /sys/block/zram0/mm_stat
 echo 1 > /sys/block/zram0/reset || fail
done
echo N100_ZRAM_VM_PASS
poweroff -f
'''
add('init',init.encode(),mode=stat.S_IFREG|0o755);add('TRAILER!!!')
initramfs=a.output/'initramfs.cpio';initramfs.write_bytes(archive)
argv=['qemu-system-x86_64','-no-user-config','-nodefaults','-machine','q35,accel=kvm','-cpu','host','-smp','1','-m','256','-display','none','-monitor','none','-serial','stdio','-nic','none','-no-reboot','-kernel',str(a.kernel),'-initrd',str(initramfs),'-append','console=ttyS0 rdinit=/init panic=1']
result=subprocess.run(argv,capture_output=True,text=True,timeout=60)
(a.output/'serial.log').write_text(result.stdout);(a.output/'stderr.log').write_text(result.stderr)
passed=result.returncode==0 and 'N100_ZRAM_VM_PASS' in result.stdout and 'n100-lz4-probe: simd=1' in result.stdout and not any(s in result.stdout for s in ['N100_ZRAM_VM_FAIL','Kernel panic','Oops:','BUG: '])
record={'status':'passed' if passed else 'failed','scope':'diskless VM correctness only; no native N100 performance or recovery claim','exit_code':result.returncode,'inputs':{name:hashlib.sha256(getattr(a,name).read_bytes()).hexdigest() for name in ['kernel','probe','zram','lz4hc']},'initramfs_sha256':hashlib.sha256(archive).hexdigest(),'disks_attached':False,'network_attached':False}
(a.output/'result.json').write_text(json.dumps(record,indent=2)+'\n');print(json.dumps(record));raise SystemExit(0 if passed else 1)
