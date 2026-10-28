import fcntl,hashlib,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
fd=int(os.environ['GZRAM_ENERGY_FD']);assert os.geteuid()==1000
assert fcntl.fcntl(fd,fcntl.F_GETFL)&os.O_ACCMODE==os.O_RDONLY
assert os.readlink(f'/proc/self/fd/{fd}')==os.path.realpath('/sys/class/powercap/intel-rapl:0/energy_uj')
validation=root/'build/astra-v3-validation';assert json.loads((validation/'result.json').read_text())['status']=='passed'
snapshot=root/'build/astra-v3/source-checkpoint'
provenance=json.loads((snapshot/'source-provenance.json').read_text())
for path,expected in provenance['source_hashes'].items():assert hashlib.sha256((snapshot/path).read_bytes()).hexdigest()==expected,path
variants=['lz4-small-scalar']
for policy in ['wordmixed','ctzunpack','bitpack','mixpack','ctzfull','bitctz','bitfull','repeatmerge','repeatmergefast']:
 for isa in ['scalar','avx2']:variants.append(f'ghy-{policy}-{isa}-1024')
variants += [f'ghy-select{cutoff}-avx2-1024' for cutoff in [2,3,4]]
assert len(variants)==22
status=root/'build/astra-audit/v3-supervisor.json'
def save(**s):
 s.update(uid=os.getuid(),energy_counter_read_only=True,variants=variants,source_commit=provenance['source_commit'])
 status.write_text(json.dumps(s,indent=2)+'\n')
save(status='waiting for exclusive validation lock',started=time.time())
with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('a+') as lock:
 deadline=time.monotonic()+3600
 while True:
  try:fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);break
  except BlockingIOError:
   if time.monotonic()>deadline:raise TimeoutError('Other validation still owns native lock')
   time.sleep(1)
save(status='running',started=time.time())
command=['/usr/bin/nice','-n','5','/usr/bin/python3',str(snapshot/'gzram/tools/run-native.py'),'--directory',str(root/'build/astra-v3'),'--output',str(root/'build/astra-local-003'),'--variants',*variants]
try:
 result=subprocess.run(command,pass_fds=(fd,),timeout=3600)
 save(status='complete' if result.returncode==0 else 'failed',exit_code=result.returncode,finished=time.time())
 raise SystemExit(result.returncode)
except Exception as error:
 save(status='failed',error=repr(error),finished=time.time());raise
