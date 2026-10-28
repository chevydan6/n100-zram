#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Exercise launcher failures without touching the native lock or RAPL.

Path.home is replaced only inside each fixture process; HOME is unchanged.
No benchmark is launched. The private fixture lock models the existing lock.
"""
import argparse
import fcntl
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import tempfile
import time

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--output', type=Path, required=True)
a = p.parse_args()
assert not a.output.exists()
a.output.mkdir(parents=True)
tool = Path(__file__).resolve().parents[1] / 'tools/supervise.py'
results = []
with tempfile.TemporaryDirectory() as temporary:
    home = Path(temporary)
    lock = home / '.cache/n100-zram/native-validation.lock'
    lock.parent.mkdir(parents=True)
    lock.touch()
    bootstrap = ('import pathlib,runpy,sys; fixture=pathlib.Path(sys.argv.pop(1)); '
                 'pathlib.Path.home=classmethod(lambda cls:fixture); '
                 'runpy.run_path(sys.argv.pop(1),run_name="__main__")')

    def launch(name, code, timeout=2, wait=0.1, energy=False):
        status = a.output / (name + '.json')
        command = [sys.executable, '-c', bootstrap, str(home), str(tool),
                   '--status', str(status), '--timeout', str(timeout),
                   '--lock-wait', str(wait), '--', sys.executable, '-c', code]
        env = dict(os.environ)
        env.pop('GZRAM_ENERGY_FD', None)
        descriptors = ()
        fd = None
        if energy:
            counter = home / 'counter'; counter.write_text('12345\n')
            fd = os.open(counter, os.O_RDONLY)
            env['GZRAM_ENERGY_FD'] = str(fd); descriptors = (fd,)
        log = (a.output / (name + '.log')).open('w')
        child = subprocess.Popen(command, env=env, pass_fds=descriptors,
                                 stdout=log, stderr=subprocess.STDOUT)
        if fd is not None: os.close(fd)
        log.close()
        return child, status, command

    def finish(name, job, expected):
        child, status, command = job
        code = child.wait(timeout=15)
        record = json.loads(status.read_text())
        assert record['status'] == expected, record
        assert (code == 0) == (expected == 'complete'), code
        results.append(dict(case=name, status='passed', supervisor=record))
        return record

    finish('success', launch('success', 'pass'), 'complete')
    finish('failure', launch('failure', 'raise SystemExit(7)'), 'failed')
    finish('readonly-fd', launch('readonly-fd',
           'import os; assert os.pread(int(os.environ["GZRAM_ENERGY_FD"]),64,0)==b"12345\\n"', energy=True), 'complete')
    with lock.open('r+') as held:
        fcntl.flock(held, fcntl.LOCK_EX | fcntl.LOCK_NB)
        record = finish('occupied-lock', launch('occupied-lock', 'raise Exception("must not execute")'), 'failed')
        assert 'no child launched' in record['error']

    for name, terminate in [('timeout-group', False), ('signal-group', True)]:
        marker = home / (name + '.pid')
        descendant = ('import os,signal,time,pathlib; signal.signal(signal.SIGTERM,signal.SIG_IGN); '
                      f'pathlib.Path({str(marker)!r}).write_text(str(os.getpid())); time.sleep(60)')
        code = f'import subprocess,sys,time; subprocess.Popen([sys.executable,"-c",{descendant!r}]); time.sleep(60)'
        job = launch(name, code, timeout=2 if not terminate else 10)
        deadline = time.monotonic() + 5
        while not marker.exists():
            assert time.monotonic() < deadline
            time.sleep(.02)
        if terminate: job[0].send_signal(signal.SIGTERM)
        finish(name, job, 'failed')
        pid = int(marker.read_text())
        deadline = time.monotonic() + 2
        while True:
            try: state = Path(f'/proc/{pid}/stat').read_text().split(') ')[1].split()[0]
            except FileNotFoundError: break
            if state == 'Z': break
            assert time.monotonic() < deadline, 'Descendant survived process-group cleanup'
            time.sleep(.02)
    job = launch('preserved-status', 'pass')
    finish('preserved-status', job, 'complete')
    before = job[1].read_bytes()
    repeated = subprocess.run(job[2], capture_output=True, timeout=5)
    assert repeated.returncode != 0 and job[1].read_bytes() == before
    results.append(dict(case='status-reuse-rejected', status='passed'))
(a.output / 'result.json').write_text(json.dumps(dict(status='passed', cases=results), indent=2) + '\n')
print(f'{len(results)} supervisor cases passed; no native lock or RAPL changes')
