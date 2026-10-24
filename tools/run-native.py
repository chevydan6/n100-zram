#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded, resumable native validation/benchmark job; no privilege needed."""
from pathlib import Path
import subprocess, json, time, hashlib, platform, sys, threading
root=Path(__file__).resolve().parents[1]
results=root/'build/run';results.mkdir(parents=True,exist_ok=True)
checkpoint=results/'checkpoint.json'
state=json.loads(checkpoint.read_text()) if checkpoint.exists() else {'completed':[]}
def save(**values):
    state.update(values);tmp=checkpoint.with_suffix('.tmp');tmp.write_text(json.dumps(state,indent=2)+'\n');tmp.replace(checkpoint)
def run(args,log):
    with (results/log).open('w') as f: subprocess.run(args,cwd=root,stdout=f,stderr=subprocess.STDOUT,check=True)
# Refuse silently resuming benchmark results against changed source.
fingerprint=hashlib.sha256()
for d in ['tools','tests','benchmarks','src','include']:
    for p in sorted((root/d).rglob('*')):
        if p.is_file() and '__pycache__' not in str(p) and 'results' not in p.parts:
            fingerprint.update(str(p.relative_to(root)).encode());fingerprint.update(p.read_bytes())
revision=fingerprint.hexdigest()
if state.get('revision',revision)!=revision: raise SystemExit('Source changed: archive build/run before starting another experiment')
save(revision=revision,status='running',started=time.time())
stop=threading.Event()
def sample():
    with (results/'telemetry.jsonl').open('a',buffering=1) as f:
        while not stop.is_set():
            record={'time':time.time(),'load':Path('/proc/loadavg').read_text().strip()}
            for pattern in ['/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/class/thermal/thermal_zone*/temp']:
                import glob
                for name in glob.glob(pattern):
                    try:record[name]=Path(name).read_text().strip()
                    except OSError:pass
            f.write(json.dumps(record)+'\n');stop.wait(1)
try:
    if 'validation' not in state['completed']:
        run(['python3','tools/build.py'],'build.log')
        run(['python3','tests/check.py'],'correctness.log')
        run(['python3','tests/guard.py'],'guard.log')
        run(['gcc','-O2','-Wall','-Wextra','benchmarks/native.c','-ldl','-o','build/native'],'compile-benchmark.log')
        state['completed'].append('validation');save()
    metadata={'uname':platform.uname()._asdict(),'cpuinfo':Path('/proc/cpuinfo').read_text(),'bash_sha256':hashlib.sha256(Path('/usr/bin/bash').read_bytes()).hexdigest(),'compiler':subprocess.check_output(['gcc','--version'],text=True)}
    (results/'environment-private.json').write_text(json.dumps(metadata,indent=2))
    sampler=threading.Thread(target=sample,daemon=True);sampler.start()
    for session in range(3):
        label=f'session-{session}'
        if label in state['completed']:continue
        save(current=label)
        with (results/(label+'.csv.tmp')).open('w') as output,(results/(label+'.log')).open('w') as log:
            subprocess.run(['./build/native','build'],cwd=root,stdout=output,stderr=log,check=True)
        (results/(label+'.csv.tmp')).replace(results/(label+'.csv'))
        state['completed'].append(label);save()
        # A brief gap between sessions, without altering system power policy.
        if session<2:time.sleep(5)
    save(status='complete',finished=time.time(),current=None)
except BaseException as error:
    save(status='failed',error=repr(error),finished=time.time());raise
finally:stop.set()
