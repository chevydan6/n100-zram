import fcntl,hashlib,json,os,pathlib,subprocess,time
r=pathlib.Path('/home/dan/n100-zram');os.chdir(r);status=r/'build/astra-audit/lz4-scalar-timing-002.json'
def save(s,**k):status.write_text(json.dumps(dict(status=s,time=time.time(),**k),indent=2)+'\n')
try:
 save('waiting for sanitizer validation');p=r/'build/lz4-scalar-sanitizer-001/result.json';deadline=time.monotonic()+3600
 while not p.exists():
  if time.monotonic()>deadline:raise TimeoutError('sanitizer validation pending')
  time.sleep(5)
 assert json.loads(p.read_text())['status']=='passed'
 if pathlib.Path('/sys/class/power_supply/AC/online').read_text().strip()=='0':assert int(pathlib.Path('/sys/class/power_supply/BAT0/capacity').read_text())>=20
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX);d=r/'build/lz4-scalar-table-001';binary=d/'native';assert binary.exists()
  command=['gcc','-O2','-g','-Wall','-Wextra','-Werror','benchmarks/native.c','-ldl','-o',str(binary)]
  # Reuse the completed first build; the prior launcher failed before measurement.
  assert binary.stat().st_size > 0
  metadata=dict(command=command,source_sha256=hashlib.sha256((r/'benchmarks/native.c').read_bytes()).hexdigest(),binary_sha256=hashlib.sha256(binary.read_bytes()).hexdigest(),machine=dict(zip(["sysname","nodename","release","version","machine"],os.uname())),battery_percent=pathlib.Path('/sys/class/power_supply/BAT0/capacity').read_text().strip(),ac_online=pathlib.Path('/sys/class/power_supply/AC/online').read_text().strip(),scope='Matched table14 controls, legacy fixed task order; no package energy, thread CPU or native ZRAM claim')
  (d/'native-build.json').write_text(json.dumps(metadata,indent=2)+'\n');save('running matched physical userspace screening',metadata=metadata)
  subprocess.run(['python3','tools/run-small-table-user.py','--directory',str(d),'--output','build/lz4-scalar-timing-002','--matched'],check=True,timeout=5400)
  save('auditing and summarizing')
  subprocess.run(['python3','tools/summarize-small-table-user.py','--input','build/lz4-scalar-timing-002','--output','benchmarks/results/native-lz4-scalar-timing-002'],check=True,timeout=900)
 save('complete; interpretation and commit pending')
except BaseException as e:save('failed; preserve artifacts',error=repr(e));raise
