#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Open one read-only RAPL counter, drop privilege, then execute a user command.

For example: pkexec /usr/bin/python3 /absolute/path/with-rapl.py -- COMMAND ...
No sysfs permissions, power settings, capabilities or swap settings are changed.
The child must explicitly preserve GZRAM_ENERGY_FD when spawning its benchmark.
"""
import argparse
import fcntl
import os
import pwd

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('command', nargs=argparse.REMAINDER)
args = parser.parse_args()
command = args.command
if command[:1] == ['--']:
    command = command[1:]
if not command or not os.path.isabs(command[0]):
    parser.error('Supply an absolute executable path after --')
uid = os.getuid()
if os.geteuid() == 0:
    if not os.environ.get('PKEXEC_UID', '').isdigit():
        parser.error('Root invocation requires the authenticating PKEXEC_UID')
    uid = int(os.environ['PKEXEC_UID'])
    if uid < 1000:
        parser.error('The benchmark must run as an ordinary user')
account = pwd.getpwuid(uid)
fd = os.open('/sys/class/powercap/intel-rapl:0/energy_uj', os.O_RDONLY | os.O_CLOEXEC)
# Avoid standard descriptors even if the launcher had one of them closed.
if fd < 3:
    copied = fcntl.fcntl(fd, fcntl.F_DUPFD_CLOEXEC, 3)
    os.close(fd)
    fd = copied
if os.geteuid() == 0:
    os.initgroups(account.pw_name, account.pw_gid)
    os.setresgid(account.pw_gid, account.pw_gid, account.pw_gid)
    os.setresuid(uid, uid, uid)
assert os.getresuid() == (uid, uid, uid) and uid != 0
assert os.getresgid() == (account.pw_gid,) * 3
assert int(next(line.split()[1] for line in open('/proc/self/status')
                if line.startswith('CapEff:')), 16) == 0
os.set_inheritable(fd, True)
env = dict(os.environ, HOME=account.pw_dir, USER=account.pw_name,
           LOGNAME=account.pw_name, GZRAM_ENERGY_FD=str(fd))
env.pop('PKEXEC_UID', None)
os.execve(command[0], command, env)
