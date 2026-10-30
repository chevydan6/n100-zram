#!/usr/bin/env python3
"""Aggregate resident pages of a fresh, owned synthetic SQLite application."""
import argparse,ctypes as C,fcntl,hashlib,importlib.util,json,os,pathlib,random,subprocess,sys,time
ROOT=pathlib.Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('owned_compile',ROOT/'benchmarks/sample-owned-compile.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
def child_maps(pid,parent):
 p=pathlib.Path('/proc')/str(pid);lines=(p/'status').read_text().splitlines()
 if int(next(x.split()[1] for x in lines if x.startswith('PPid:')))!=parent: return []
 if next(x.split(':',1)[1].strip() for x in lines if x.startswith('Name:')) not in ('python3','python3.14'):return []
 out=[]
 for line in (p/'maps').read_text().splitlines():
  f=line.split(maxsplit=5)
  if len(f)<5 or f[1][0]!='r' or f[1][3]!='p':continue
  name=f[5] if len(f)>5 else '';kind='anonymous_private' if not name or name in ('[heap]','[stack]') else ('file_executable' if 'x' in f[1] and name.startswith('/') else None)
  if kind:
   a,b=(int(x,16) for x in f[0].split('-'))
   if b-a>=m.PAGE:out.append((a,(b-a)//m.PAGE,kind))
 return out
p=argparse.ArgumentParser();p.add_argument('--output',type=pathlib.Path,required=True);p.add_argument('--seed',type=int,default=430);a=p.parse_args()
if a.output.exists():p.error('output exists')
if m.available_kib()<2*1024**2:p.error('need 2 GiB available')
if os.sysconf('SC_PAGE_SIZE')!=m.PAGE:p.error('4 KiB pages required')
paths=[ROOT/'benchmarks/owned-sqlite-workload.py',ROOT/'benchmarks/sample-owned-sqlite.py',ROOT/'benchmarks/sample-owned-compile.py',ROOT/'build/astra-v9/libgzram-hybrid-bitdirectblock2avxbits4bounded.so']+[ROOT/f'build/lz4-scalar-table-001/table{x}-scalar.so' for x in (14,13,12)]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();before={str(p.relative_to(ROOT)):sha(p) for p in paths};a.output.mkdir(parents=True);out=a.output/'result.json'
state={'status':'running','scope':'Owned synthetic SQLite workload, aggregate present resident pages only; not reclaim distribution, allocator use, timing or energy','seed':a.seed,'kernel':os.uname().release,'sources_and_binaries_sha256':before,'classes':{k:{'pages':0,'same_word':0,'codecs':{}} for k in ('anonymous_private','file_executable')},'eligible_reads':{'anonymous_private':0,'file_executable':0},'failures':0}
def save():out.write_text(json.dumps(state,indent=2)+'\n')
child=None
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);codecs=m.Codecs(ROOT/'build/lz4-scalar-table-001',paths[3]);rng=random.Random(a.seed);res={k:[] for k in state['classes']};seen=set();buf=C.create_string_buffer(m.PAGE)
  child=subprocess.Popen(['/usr/bin/python3',str(paths[0])],env={'PATH':'/usr/bin:/bin','LANG':'C','LC_ALL':'C'},stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,start_new_session=True);deadline=time.monotonic()+60;save()
  while child.poll() is None and time.monotonic()<deadline:
   if m.available_kib()<1536*1024:raise RuntimeError('memory headroom below 1.5 GiB')
   mappings=child_maps(child.pid,os.getpid())
   if mappings:
    with open(f'/proc/{child.pid}/pagemap','rb',buffering=0) as f:
     for kind in state['classes']:
      pool=[x for x in mappings if x[2]==kind]
      if not pool:continue
      for _ in range(16):
       start,count,_=rng.choices(pool,weights=[v[1] for v in pool],k=1)[0];addr=start+rng.randrange(count)*m.PAGE
       if addr in seen:continue
       if m.sample_page(child.pid,addr,f.fileno(),buf)!='read':state['failures']+=1;continue
       seen.add(addr);state['eligible_reads'][kind]+=1;value=codecs.classify(buf);bank=res[kind]
       if len(bank)<128:bank.append(value)
       else:
        i=rng.randrange(state['eligible_reads'][kind])
        if i<128:bank[i]=value
   time.sleep(.2)
  if child.poll() is None:raise RuntimeError('workload timeout')
  if child.returncode:raise RuntimeError('workload failed')
  for kind,bank in res.items():
   for x in bank:m.add_sample(state['classes'][kind],x)
  if not state['classes']['anonymous_private']['pages']:raise RuntimeError('no anonymous pages')
  if before!={str(p.relative_to(ROOT)):sha(p) for p in paths}:raise RuntimeError('source or binary changed')
  state['status']='passed';save()
except BaseException as e:state.update(status='failed',error=repr(e));save();raise
finally:
 if child and child.poll() is None:
  child.terminate()
  try:child.wait(timeout=5)
  except subprocess.TimeoutExpired:child.kill();child.wait()
