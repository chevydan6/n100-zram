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
def measure_pages(samples,codecs,candidate,rng):
 """Randomize eight userspace codec operations per page; transient buffers only."""
 import statistics
 library=C.CDLL(str(candidate));enc=library.gzram_encode_avx2;enc.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint];enc.restype=C.c_int
 entries={name:(fn,work,dec) for name,fn,work,dec in codecs.entries if name in ('table12-scalar','ghy-combined-avx2')};parent_dec=entries['ghy-combined-avx2'][2];entries['ghy-sample16-avx2']=(enc,None,parent_dec)
 zstd=C.CDLL('/lib64/libzstd.so.1');zstd.ZSTD_createCCtx.restype=C.c_void_p;zstd.ZSTD_createDCtx.restype=C.c_void_p
 zstd.ZSTD_compressCCtx.argtypes=[C.c_void_p,C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_int];zstd.ZSTD_compressCCtx.restype=C.c_size_t
 zstd.ZSTD_decompressDCtx.argtypes=[C.c_void_p,C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t];zstd.ZSTD_decompressDCtx.restype=C.c_size_t
 zstd.ZSTD_freeCCtx.argtypes=[C.c_void_p];zstd.ZSTD_freeDCtx.argtypes=[C.c_void_p];zstd.ZSTD_versionString.restype=C.c_char_p
 cctx=zstd.ZSTD_createCCtx();dctx=zstd.ZSTD_createDCtx()
 if not cctx or not dctx:raise RuntimeError('zstd context allocation failed')
 entries['zstd-userspace-level3']=(None,None,None)
 def encode_one(name,fn,work,page,target):
  if name=='zstd-userspace-level3':return zstd.ZSTD_compressCCtx(cctx,target,m.BOUND,page,m.PAGE,3)
  return fn(page,target,m.PAGE,m.BOUND,work) if work is not None else fn(page,m.PAGE,target,m.BOUND,10)
 def decode_one(name,work,dec,frame,n,decoded):
  if name=='zstd-userspace-level3':return zstd.ZSTD_decompressDCtx(dctx,decoded,m.PAGE,frame,n)
  return codecs.lz4(frame,decoded,n,m.PAGE) if work is not None else dec(frame,n,decoded,m.PAGE)
 obs={name:{op:{'wall':[],'cpu':[]} for op in ('compress','decompress')} for name in entries};sizes={name:0 for name in entries};pages=0;repeat=32
 for classification,data in samples:
  if classification.get('same_word'):continue
  page=C.create_string_buffer(data,m.PAGE);frames={};decoded=C.create_string_buffer(m.PAGE)
  for name,(fn,work,dec) in entries.items():
   target=C.create_string_buffer(m.BOUND);n=encode_one(name,fn,work,page,target)
   if n<=0 or n>m.BOUND:raise RuntimeError('timing encode failed')
   frame=C.create_string_buffer(target.raw[:n],n);got=decode_one(name,work,dec,frame,n,decoded)
   if got!=m.PAGE or decoded.raw!=data:raise RuntimeError('timing roundtrip failure')
   frames[name]=(frame,n,target);sizes[name]+=n
  tasks=[(name,op) for name in entries for op in ('compress','decompress')];rng.shuffle(tasks)
  for name,op in tasks:
   fn,work,dec=entries[name];frame,n,target=frames[name]
   # Warm each exact operation, then batch clocks outside the loop.
   def call():
    if op=='compress':return encode_one(name,fn,work,page,target)
    return decode_one(name,work,dec,frame,n,decoded)
   for _ in range(3):call()
   cpu=time.thread_time_ns();start=time.perf_counter_ns()
   for _ in range(repeat):got=call()
   wall=(time.perf_counter_ns()-start)/repeat;used=(time.thread_time_ns()-cpu)/repeat
   if got!=(n if op=='compress' else m.PAGE):raise RuntimeError('timing operation failure')
   if op=='decompress' and decoded.raw!=data:raise RuntimeError('timing decode mismatch')
   if op=='compress' and target.raw[:n]!=frame.raw:raise RuntimeError('timing encode output changed')
   obs[name][op]['wall'].append(wall);obs[name][op]['cpu'].append(used)
  pages+=1
 result={'pages':pages,'calls_per_batch':repeat,'warmups':3,'order':'randomized eight operations per page','scope':'Userspace, same generated renderer pages; wall and thread CPU include Python/ctypes overhead; no RAPL, kernel, allocator or application timing', 'metrics':{},'paired_percent':{}}
 for name,operations in obs.items():
  result['metrics'][name]={'encoded_bytes_total':sizes[name]}
  for op,values in operations.items():
   result['metrics'][name][op]={k+'_ns_median':statistics.median(v) for k,v in values.items()}
 for name in ('ghy-combined-avx2','ghy-sample16-avx2'):
  result['paired_percent'][name]={}
  for op in ('compress','decompress'):
   result['paired_percent'][name][op]={}
   for metric in ('wall','cpu'):
    a=obs[name][op][metric];b=obs['table12-scalar'][op][metric];result['paired_percent'][name][op][metric]=statistics.median(100*(x/y-1) for x,y in zip(a,b))
 result['zstd_version']=zstd.ZSTD_versionString().decode();result['zstd_level']=3
 result['candidate_vs_parent_percent']={}
 for op in ('compress','decompress'):
  result['candidate_vs_parent_percent'][op]={}
  for metric in ('wall','cpu'):
   a=obs['ghy-sample16-avx2'][op][metric];b=obs['ghy-combined-avx2'][op][metric];result['candidate_vs_parent_percent'][op][metric]=statistics.median(100*(x/y-1) for x,y in zip(a,b))
 result['vs_zstd_percent']={}
 for name in ('table12-scalar','ghy-combined-avx2','ghy-sample16-avx2'):
  result['vs_zstd_percent'][name]={}
  for op in ('compress','decompress'):
   result['vs_zstd_percent'][name][op]={}
   for metric in ('wall','cpu'):
    a=obs[name][op][metric];b=obs['zstd-userspace-level3'][op][metric];result['vs_zstd_percent'][name][op][metric]=statistics.median(100*(x/y-1) for x,y in zip(a,b))
 zstd.ZSTD_freeCCtx(cctx);zstd.ZSTD_freeDCtx(dctx)
 return result

p=argparse.ArgumentParser();p.add_argument('--output',type=pathlib.Path,required=True);p.add_argument('--seed',type=int,default=430);a=p.parse_args()
if a.output.exists():p.error('output exists')
if m.available_kib()<2*1024**2:p.error('need 2 GiB available')
if os.sysconf('SC_PAGE_SIZE')!=m.PAGE:p.error('4 KiB pages required')
paths=[ROOT/'benchmarks/owned-browser-workload.html',ROOT/'benchmarks/sample-owned-renderer-zstd.py',ROOT/'benchmarks/sample-owned-compile.py',ROOT/'build/astra-v9/libgzram-hybrid-bitdirectblock2avxbits4bounded.so']+[ROOT/f'build/lz4-scalar-table-001/table{x}-scalar.so' for x in (14,13,12)]
candidate=ROOT/'build/terra-combined-sampling-validation-001/normal/combined-sample16.so';paths.extend([candidate,pathlib.Path('/lib64/libzstd.so.1')])
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();before={str(p.relative_to(ROOT) if p.is_relative_to(ROOT) else p):sha(p) for p in paths};a.output.mkdir(parents=True);out=a.output/'result.json'
state={'status':'running','scope':'Chromium renderer sample plus randomized userspace codec timing, generated local content; no page bytes persisted; no package energy, ZRAM, reclaim or application-performance claim','seed':a.seed,'kernel':os.uname().release,'sources_and_binaries_sha256':before,'classes':{k:{'pages':0,'same_word':0,'codecs':{}} for k in ('anonymous_private','file_executable')},'eligible_reads':{'anonymous_private':0,'file_executable':0},'failures':0,'renderer_candidates':0,'renderer_map_denials':0,'descendants_seen':0,'renderer_type_seen':0,'profile_matches':0}
def save():out.write_text(json.dumps(state,indent=2)+'\n')
child=None
try:
 with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
  fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);codecs=m.Codecs(ROOT/'build/lz4-scalar-table-001',paths[3]);rng=random.Random(a.seed);res={k:[] for k in state['classes']};seen=set();buf=C.create_string_buffer(m.PAGE)
  tmp=tempfile.TemporaryDirectory(prefix='n100-browser-sample-');profile=pathlib.Path(tmp.name);cmd=['/usr/lib64/chromium-browser/chromium-browser','--headless','--disable-gpu','--no-first-run','--no-default-browser-check','--disable-background-networking','--disable-component-update','--disable-sync','--disable-extensions','--disable-breakpad','--host-resolver-rules=MAP * ~NOTFOUND','--user-data-dir='+str(profile/'profile'),paths[0].as_uri()];child=subprocess.Popen(cmd,env={'PATH':'/usr/bin:/bin','LANG':'C','LC_ALL':'C','XDG_CACHE_HOME':str(profile/'cache'),'XDG_CONFIG_HOME':str(profile/'config')},stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,start_new_session=True);deadline=time.monotonic()+35;save()
  while child.poll() is None and time.monotonic()<deadline:
   if m.available_kib()<1536*1024:raise RuntimeError('memory headroom below 1.5 GiB')
   # Every candidate must belong to this dedicated systemd service cgroup,
   # declare the renderer type, and carry this run's temporary profile path.
   # Chromium can create renderers through zygotes whose ancestry is not
   # visible as a leader-thread child, so cgroup membership scopes discovery.
   cgroup=pathlib.Path('/sys/fs/cgroup') / pathlib.Path(pathlib.Path('/proc/self/cgroup').read_text().strip().split('::',1)[1].lstrip('/'))
   if not cgroup.name.startswith('n100-terra-owned-renderer-sample-'):raise RuntimeError('dedicated service cgroup required')
   candidates=[]
   for token in (cgroup/'cgroup.procs').read_text().split():
    pid=int(token);state['descendants_seen']+=1
    try:
     proc=pathlib.Path('/proc')/str(pid);cmdline=(proc/'cmdline').read_bytes().replace(b'\0',b' ')
     if b' --type=renderer ' in b' '+cmdline+b' ':
      state['renderer_type_seen']+=1
      if (' --user-data-dir='+str(profile/'profile')+' ').encode() in b' '+cmdline+b' ':
       state['profile_matches']+=1
       parent=int(next(x.split()[1] for x in (proc/'status').read_text().splitlines() if x.startswith('PPid:')))
       candidates.append((pid,parent))
    except (OSError,StopIteration):continue
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
        if len(bank)<128:bank.append((value,buf.raw))
        else:
         i=rng.randrange(state['eligible_reads'][kind])
         if i<128:bank[i]=(value,buf.raw)
    except (OSError,StopIteration,ProcessLookupError):state['renderer_map_denials']+=1
   time.sleep(.2)
  if child.poll() is not None:raise RuntimeError('browser exited before sampling completed: '+str(child.returncode))
  os.killpg(child.pid,signal.SIGTERM);child.wait(timeout=10)
  for kind,bank in res.items():
   for x,_ in bank:m.add_sample(state['classes'][kind],x)
  state['codec_timing']=measure_pages(res['anonymous_private'],codecs,candidate,rng)
  if not state['classes']['anonymous_private']['pages']:raise RuntimeError('no anonymous pages')
  if before!={str(p.relative_to(ROOT) if p.is_relative_to(ROOT) else p):sha(p) for p in paths}:raise RuntimeError('source or binary changed')
  state['status']='passed';save()
except BaseException as e:state.update(status='failed',error=repr(e));save();raise
finally:
 if child and child.poll() is None:
  child.terminate()
  try:child.wait(timeout=5)
  except subprocess.TimeoutExpired:os.killpg(child.pid,signal.SIGKILL);child.wait()
 if 'tmp' in globals():tmp.cleanup()
