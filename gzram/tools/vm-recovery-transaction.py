#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Exercise guest-only temporary sysctl rollback; never alter the host."""
import argparse,fcntl,hashlib,json,os,stat,subprocess
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__)
for x in ('kernel','busybox','qemu','bios','qemu-data','output'):p.add_argument('--'+x,type=Path,required=True)
p.add_argument('--library-path',type=Path)
p.add_argument('--lock',type=Path,default=Path.home()/'.cache/n100-zram/native-validation.lock')
a=p.parse_args()
if os.geteuid()==0:p.error('Run guest launcher unprivileged')
lock=a.lock.open('r+');fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
mem=dict(line.split(':',1) for line in Path('/proc/meminfo').read_text().splitlines());assert int(mem['MemAvailable'].split()[0])>=2*1024**2
assert not a.output.exists();a.output.mkdir(parents=True)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
paths=[Path('/sys/block/zram0/comp_algorithm'),Path('/sys/block/zram0/disksize')]+[Path('/proc/sys/kernel')/x for x in ('panic','panic_on_oops','softlockup_panic','nmi_watchdog','hardlockup_panic')]
before={str(p):p.read_text().strip() for p in paths}
archive=bytearray();inode=0
def add(name,data=b'',mode=stat.S_IFREG|0o644,major=0,minor=0):
 global inode
 inode+=1;name=name.encode()+b'\0';fields=[inode,mode,0,0,1,0,len(data),0,0,major,minor,len(name),0]
 archive.extend(('070701'+''.join(f'{x:08x}' for x in fields)).encode());archive.extend(name);archive.extend(b'\0'*(-len(archive)%4));archive.extend(data);archive.extend(b'\0'*(-len(archive)%4))
for name in ('bin','dev','proc','sys'):add(name,mode=stat.S_IFDIR|0o755)
add('dev/console',mode=stat.S_IFCHR|0o600,major=5,minor=1)
add('bin/busybox',a.busybox.read_bytes(),mode=stat.S_IFREG|0o755)
add('isolated-recovery-guest',b'guest only\n')
helper=Path(__file__).with_name('guest-recovery-transaction.sh');add('transaction',helper.read_bytes(),mode=stat.S_IFREG|0o755)
init='''#!/bin/busybox sh
export PATH=/bin
/bin/busybox --install -s /bin
fail() { echo RECOVERY_VM_FAIL; poweroff -f; while :; do sleep 1; done; }
mount -t proc proc /proc || fail
mount -t sysfs sysfs /sys || fail
mount -t devtmpfs devtmpfs /dev || fail
snapshot() { cat /proc/sys/kernel/panic /proc/sys/kernel/panic_on_oops /proc/sys/kernel/softlockup_panic; }
before=$(snapshot) || fail
/transaction normal || fail
[ "$(snapshot)" = "$before" ] || fail
/transaction inject
code=$?
[ "$code" = 42 ] || fail
[ "$(snapshot)" = "$before" ] || fail
echo RECOVERY_VM_PASS
poweroff -f
'''
add('init',init.encode(),mode=stat.S_IFREG|0o755);add('TRAILER!!!')
initrd=a.output/'initramfs.cpio';initrd.write_bytes(archive)
cmd=[str(a.qemu.resolve()),'-no-user-config','-nodefaults','-machine','q35,accel=kvm','-cpu','host','-smp','2','-m','256','-display','none','-monitor','none','-serial','stdio','-nic','none','-no-reboot','-bios',str(a.bios.resolve()),'-L',str(a.qemu_data.resolve()),'-kernel',str(a.kernel.resolve()),'-initrd',str(initrd.resolve()),'-append','console=ttyS0 rdinit=/init panic=1']
env=dict(os.environ)
if a.library_path:env['LD_LIBRARY_PATH']=str(a.library_path.resolve())
record={'scope':'Diskless isolated guest rollback test only; no host policy, panic, watchdog or pstore recovery claim','command':cmd,'before':before,'hashes':{x:sha(getattr(a,x)) for x in ('kernel','busybox','qemu','bios')},'helper_sha256':sha(helper),'initramfs_sha256':sha(initrd)}
with (a.output/'serial.log').open('w') as out,(a.output/'stderr.log').open('w') as err:
 try:run=subprocess.run(cmd,env=env,stdout=out,stderr=err,timeout=120);record['exit_code']=run.returncode
 except subprocess.TimeoutExpired:record['exit_code']=None;record['error']='guest exceeded 120 seconds'
text=(a.output/'serial.log').read_text().replace('\r','');after={str(p):p.read_text().strip() for p in paths};record['after']=after
markers=['RECOVERY_POLICY_APPLIED','RECOVERY_INJECTED_FAILURE','RECOVERY_RESTORED mode=normal','RECOVERY_RESTORED mode=inject','RECOVERY_VM_PASS']
record['markers']={m:text.count(m) for m in markers};record['status']='passed' if record['exit_code']==0 and before==after and all(text.count(m)==1 for m in markers) and not any(x in text for x in ('RECOVERY_VM_FAIL','RECOVERY_RESTORE_FAILED','Kernel panic','Oops:','BUG:','WARNING:')) else 'failed'
(a.output/'result.json').write_text(json.dumps(record,indent=2)+'\n');print(json.dumps(record));raise SystemExit(0 if record['status']=='passed' else 1)
