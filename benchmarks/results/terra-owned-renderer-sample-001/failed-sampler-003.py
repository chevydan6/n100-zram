#!/usr/bin/env python3
"""Aggregate resident pages of a fresh, owned headless browser process using generated local content."""
import argparse,ctypes as C,fcntl,hashlib,importlib.util,json,os,pathlib,random,subprocess,sys,time,tempfile,signal
ROOT=pathlib.Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('owned_compile',ROOT/'benchmarks/sample-owned-compile.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
def child_maps(pid,parent):
 p=pathlib.Path('/proc')/str(pid);lines=(p/'status').read_text().splitlines()
 if int(next(x.split()[1] for x in lines if x.startswith('PPid:')))!=parent: return []
 if next(x.split(':',1)[1].strip() for x in lines if x.startswith('Name:')) not in ('chromium-browse','chromium-browser'):return []
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
paths=[ROOT/'benchmarks/owned-browser-workload.html',ROOT/'benchmarks/sample-owned-renderer.py',ROOT/'benchmarks/sample-owned-compile.py',ROOT/'build/astra-v9/libgzram-hybrid-bitdirectblock2avxbits4bounded.so']+[ROOT/f'build/lz4-scalar-table-001/table{x}-scalar.so' for x in (14,13,12)]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();before={str(p.relative_to(ROOT)):sha(p) for p in paths};a.output.mkdir(parents=True);out=a.output/'result.json'
state={'status':'running','scope':'Owned Chromium renderer descendants of a fresh browser, generated local content and temporary profile; aggregate resident pages only, no reclaim/energy claim','seed':a.seed,'kernel':os.uname().release,'sources_and_binaries_sha256':before,'classes':{k:{'pages':0,'same_word':0,'codecs':{}} for k in ('anonymous_private','file_executable')},'eligible_reads':{'anonymous_private':0,'file_executable':0},'failures':0,'renderer_candidates':0,'renderer_map_denials':0,'descendants_seen':0,'renderer_type_seen':0,'profile_matches':0}
def save():out.write_text(json.dumps(state,indent=2)+'\n')
child=None
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);codecs=m.Codecs(ROOT/'build/lz4-scalar-table-001',paths[3]);rng=random.Random(a.seed);res={k:[] for k in state['classes']};seen=set();buf=C.create_string_buffer(m.PAGE)
  tmp=tempfile.TemporaryDirectory(prefix='n100-browser-sample-');profile=pathlib.Path(tmp.name);cmd=['/usr/lib64/chromium-browser/chromium-browser','--headless','--disable-gpu','--no-first-run','--no-default-browser-check','--disable-background-networking','--disable-component-update','--disable-sync','--disable-extensions','--disable-breakpad','--host-resolver-rules=MAP * ~NOTFOUND','--user-data-dir='+str(profile/'profile'),paths[0].as_uri()];child=subprocess.Popen(cmd,env={'PATH':'/usr/bin:/bin','LANG':'C','LC_ALL':'C','XDG_CACHE_HOME':str(profile/'cache'),'XDG_CONFIG_HOME':str(profile/'config')},stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,start_new_session=True);deadline=time.monotonic()+35;save()
  while child.poll() is None and time.monotonic()<deadline:
   if m.available_kib()<1536*1024:raise RuntimeError('memory headroom below 1.5 GiB')
   # Traverse only children of the launched browser. Recheck immediate parent,
   # renderer type and the fresh profile before reading any mapping.
   candidates=[];frontier=[child.pid]
   while frontier:
    parent=frontier.pop()
    descendants=[]
    try:
     for task in (pathlib.Path('/proc')/str(parent)/'task').iterdir():
      try:descendants.extend((task/'children').read_text().split())
      except OSError:continue
    except OSError:continue
    for token in descendants:
     pid=int(token);frontier.append(pid);state['descendants_seen']+=1
     try:
      cmdline=(pathlib.Path('/proc')/str(pid)/'cmdline').read_bytes().split(b'\0')
      if b'--type=renderer' in cmdline:
       state['renderer_type_seen']+=1
       if ('--user-data-dir='+str(profile/'profile')).encode() in cmdline:state['profile_matches']+=1;candidates.append((pid,parent))
     except OSError:continue
   state['renderer_candidates']+=len(candidates)
   rng.shuffle(candidates)
   for pid,parent in candidates:
    try:
     mappings=child_maps(pid,parent)
     if not mappings:continue
     with open(f'/proc/{pid}/pagemap','rb',buffering=0) as f:
      for kind in state['classes']:
       pool=[x for x in mappings if x[2]==kind]
       if not pool:continue
       for _ in range(8):
        start,count,_=rng.choices(pool,weights=[v[1] for v in pool],k=1)[0];addr=start+rng.randrange(count)*m.PAGE;key=(pid,addr)
        if key in seen:continue
        if m.sample_page(pid,addr,f.fileno(),buf)!='read':state['failures']+=1;continue
        seen.add(key);state['eligible_reads'][kind]+=1;value=codecs.classify(buf);bank=res[kind]
        if len(bank)<128:bank.append(value)
        else:
         i=rng.randrange(state['eligible_reads'][kind])
         if i<128:bank[i]=value
    except (OSError,StopIteration,ProcessLookupError):state['renderer_map_denials']+=1
   time.sleep(.2)
  if child.poll() is not None:raise RuntimeError('browser exited before sampling completed: '+str(child.returncode))
  os.killpg(child.pid,signal.SIGTERM);child.wait(timeout=10)
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
  except subprocess.TimeoutExpired:os.killpg(child.pid,signal.SIGKILL);child.wait()
 if 'tmp' in globals():tmp.cleanup()
