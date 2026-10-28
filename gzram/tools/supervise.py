#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bound an experiment after authentication, preserving failed-run evidence.

Run systemd-inhibit BEFORE with-rapl.py, then this tool AFTER with-rapl.py.
The supplied run-native.py command still owns the exclusive native lock. This
wrapper waits for availability, but never bypasses the runner's atomic lock
acquisition. A competing acquisition can therefore cause a safe launch failure.
No root execution, resume inference, output cleanup, or setting changes.
"""
import argparse
import fcntl
import json
import os
from pathlib import Path
import signal
import subprocess
import time


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--status', type=Path, required=True)
    parser.add_argument('--timeout', type=float, required=True)
    parser.add_argument('--lock-wait', type=float, default=600)
    parser.add_argument('command', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    command = args.command[1:] if args.command[:1] == ['--'] else args.command
    if os.geteuid() == 0:
        parser.error('Run after permanently dropping root privileges')
    if not command or not os.path.isabs(command[0]):
        parser.error('Supply an absolute executable after --')
    if not (0 < args.timeout < float('inf') and 0 <= args.lock_wait < float('inf')):
        parser.error('Timeout must be positive and lock wait nonnegative and finite')
    # Exclusive creation protects previous failure records as well as successes.
    with args.status.open('x') as output:
        json.dump({'status': 'initializing'}, output)
    record = dict(command=command, uid=os.getuid(), started=time.time(),
                  timeout_seconds=args.timeout, lock_wait_seconds=args.lock_wait)
    child = None

    def save(status, **extra):
        record.update(status=status, **extra)
        temporary = args.status.with_name(args.status.name + '.tmp')
        temporary.write_text(json.dumps(record, indent=2) + '\n')
        temporary.replace(args.status)

    def interrupted(number, frame):
        raise InterruptedError('Supervisor signal ' + str(number))

    def stop_group():
        # Always address the entire group, even if its original leader exited.
        try:
            os.killpg(child.pid, signal.SIGTERM)
        except ProcessLookupError:
            return
        try:
            child.wait(timeout=5)
        except subprocess.TimeoutExpired:
            pass
        try:
            os.killpg(child.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        child.wait()

    for number in (signal.SIGTERM, signal.SIGINT):
        signal.signal(number, interrupted)
    try:
        inherited = ()
        if 'GZRAM_ENERGY_FD' in os.environ:
            fd = int(os.environ['GZRAM_ENERGY_FD'])
            if fcntl.fcntl(fd, fcntl.F_GETFL) & os.O_ACCMODE != os.O_RDONLY:
                raise ValueError('Energy descriptor must be read-only')
            os.pread(fd, 64, 0)  # Fail before starting a long experiment.
            inherited = (fd,)
        save('waiting for native lock', energy_descriptor_inherited=bool(inherited))
        path = Path.home() / '.cache/n100-zram/native-validation.lock'
        # Existing lock only; do not invent a second lock location or inode.
        with path.open('r+') as lock:
            deadline = time.monotonic() + args.lock_wait
            while True:
                try:
                    fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
                    break
                except BlockingIOError:
                    remaining = deadline - time.monotonic()
                    if remaining <= 0:
                        raise TimeoutError('Native lock remained occupied; no child launched')
                    time.sleep(min(1, remaining))
        save('running', measurement_started=time.time())
        child = subprocess.Popen(command, pass_fds=inherited, start_new_session=True)
        code = child.wait(timeout=args.timeout)
        if code:
            raise RuntimeError('Experiment exited ' + str(code))
        save('complete', finished=time.time(), returncode=code)
    except BaseException as error:
        # Subsequent termination requests must not interrupt child cleanup.
        for number in (signal.SIGTERM, signal.SIGINT):
            signal.signal(number, signal.SIG_IGN)
        if child is not None:
            stop_group()
        save('failed', finished=time.time(), error=repr(error))
        raise


if __name__ == '__main__':
    main()
