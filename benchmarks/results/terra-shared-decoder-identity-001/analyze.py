#!/usr/bin/env python3
"""Check actual frame identity and compare shared-decoder timing; no raw pages saved."""
import ctypes as C,fcntl,hashlib,json,os,pathlib,statistics,subprocess
r=pathlib.Path(__file__).resolve().parents[3];bench=r/'build/terra-combined-sampling-benchmark-001/normal';source=r/'benchmarks/results/terra-combined-sampling-energy-001';checkpoint=json.loads((source/'checkpoint.json').read_text());pairs=json.loads((source/'paired.json').read_text());manifest=json.loads((bench/'manifest.json').read_text());sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(bench/'benchmark')==checkpoint['inputs']['binary_sha256']
for name,digest in checkpoint['inputs']['libraries'].items():assert sha(bench/name)==digest==manifest['artifacts'][name]
libs={name:C.CDLL(str(bench/file)) for name,file in [('parent','libgzram-hybrid-bitdirectblock2avxbits4bounded.so'),('sample16','combined-sample16.so'),('sample64','combined-sample64.so')]}
enc={}
for name,lib in libs.items():
 for isa in ('scalar','avx2'):
  f=getattr(lib,'gzram_encode_'+isa);f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint];f.restype=C.c_int;enc[name,isa]=f
out=C.create_string_buffer(4352);rows=[];env=dict(os.environ,GZRAM_ZERO_GUARD_FIXTURES='1',GZRAM_EXEC_CORPUS_DIR=str(r/'build/astra-exec-corpora-001'))
with (pathlib.Path.home()/'.cache/n100-zram/native-validation.lock').open('r+') as lock:
 fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
 for corpus in checkpoint['inputs']['corpora']:
  data=subprocess.check_output([str(bench/'benchmark'),str(bench),'--dump-corpus='+corpus],env=env);assert hashlib.sha256(data).hexdigest()==checkpoint['inputs']['corpus_sha256'][corpus] and len(data)==128*4096
  counts={(name,isa):0 for name in ('sample16','sample64') for isa in ('scalar','avx2')}
  for i in range(128):
   page=C.create_string_buffer(data[i*4096:(i+1)*4096],4096)
   for isa in ('scalar','avx2'):
    n=enc['parent',isa](page,4096,out,4352,10);assert n>0;parent=out.raw[:n]
    for name in ('sample16','sample64'):
     n=enc[name,isa](page,4096,out,4352,10);assert n>0;counts[name,isa]+=int(out.raw[:n]==parent)
  for (name,isa),identical in counts.items():
   matches=[x for x in pairs if x['corpus']==corpus and x['candidate']==f'ghy-{name}-{isa}' and x['control']==f'ghy-combined-{isa}' and x['operation']=='decompress'];assert len(matches)==1
   rows.append(dict(corpus=corpus,candidate=name,isa=isa,identical_frames=identical,total=128,decoding=matches[0]['metrics']['ns_per_page']))
print(json.dumps(dict(status='passed',scope='Byte identity of 128 inputs and shared decoder timings; comparisons remain subject to cache, ordering and measurement noise; no causal decoder claim',timing_checkpoint_sha256=sha(source/'checkpoint.json'),pairs_sha256=sha(source/'paired.json'),rows=rows),indent=2))
