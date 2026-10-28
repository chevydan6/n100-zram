import fcntl,json,os,pathlib,subprocess,time
root=pathlib.Path('/home/dan/n100-zram');os.chdir(root)
fd=int(os.environ['GZRAM_ENERGY_FD']);assert os.geteuid()==1000
assert fcntl.fcntl(fd,fcntl.F_GETFL)&os.O_ACCMODE==os.O_RDONLY
assert os.readlink(f'/proc/self/fd/{fd}')==os.path.realpath('/sys/class/powercap/intel-rapl:0/energy_uj')
status=root/'build/astra-audit/v3-energy-standby.json'
def save(**s):
 s.update(uid=os.getuid(),energy_counter_read_only=True)
 status.write_text(json.dumps(s,indent=2)+'\n')
start=time.monotonic();save(status='waiting for original runner',original_pid=10217,started=time.time())
try:
 while True:
  path=pathlib.Path('/proc/10217/stat')
  if not path.exists():break
  stat=path.read_text();state=stat[stat.rfind(')')+2:].split()[0]
  if state=='Z':break
  if time.monotonic()-start>3600:raise TimeoutError('Original runner still active; no replacement started')
  time.sleep(1)
 checkpoint=root/'build/astra-local-003/checkpoint.json';state=json.loads(checkpoint.read_text())
 if state['status']!='complete':
  save(status='resuming incomplete cohort after original runner exited',completed=state['completed'],started=time.time())
  command=['/usr/bin/nice','-n','5','/usr/bin/python3',str(root/'build/astra-v3/source-checkpoint/gzram/tools/run-native.py'),'--directory',str(root/'build/astra-v3'),'--output',str(root/'build/astra-local-003'),'--resume','--variants',*state['inputs']['variant_names']]
  subprocess.run(command,pass_fds=(fd,),check=True,timeout=2100)
 state=json.loads(checkpoint.read_text());assert state['status']=='complete'
 save(status='complete',completed=state['completed'],finished=time.time())
except BaseException as error:
 save(status='failed',error=repr(error),finished=time.time());raise
