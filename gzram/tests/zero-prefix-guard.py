#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Validate zero-prefix candidate selection, boundaries and size tradeoffs."""
import argparse
import ctypes as C
import importlib.util
import json
import random
from pathlib import Path
root=Path(__file__).resolve().parents[2]
def load(name,path):
 spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
sample=load('owned_compile_sample',root/'benchmarks/sample-owned-compile.py')
wire=load('gzram_wire',root/'gzram/tests/wire.py')
guards=load('guard_buffers',root/'tests/guard_buffers.py')
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--candidate',type=Path,required=True);p.add_argument('--parent',type=Path,required=True);p.add_argument('--table',type=Path,required=True)
p.add_argument('--minimum-matches',type=int,choices=[1,2],default=1)
a=p.parse_args()
parent=C.CDLL(str(a.parent));candidate=C.CDLL(str(a.candidate));lz=C.CDLL('liblz4.so.1').LZ4_decompress_safe
lz.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int];lz.restype=C.c_int
table=C.CDLL(str(a.table));table.n100_reuse_worksize.restype=C.c_ulong;table.n100_reuse_init.argtypes=[C.c_void_p]
table.n100_reuse_compress.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int,C.c_void_p];table.n100_reuse_compress.restype=C.c_int
tablework=C.create_string_buffer(table.n100_reuse_worksize());table.n100_reuse_init(tablework)
for lib in [parent,candidate]:
 for isa in ['scalar','avx2']:
  enc=getattr(lib,'gzram_encode_'+isa);enc.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint];enc.restype=C.c_int
  dec=getattr(lib,'gzram_decode_'+isa);dec.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t];dec.restype=C.c_int

def independent(frame):
 assert frame[:4]==b'GHY1' and len(frame)>=8 and frame[7]==0
 n=int.from_bytes(frame[4:6],'little');mode=frame[6];payload=frame[8:]
 if mode==0:assert len(payload)==n;return payload
 if mode==1:return wire.decode(payload)
 assert mode==2
 out=C.create_string_buffer(n);got=lz(payload,out,len(payload),n);assert got==n;return out.raw

rng=random.Random(687);pages=[]
# Two populations intentionally create both helpful repetitive words and
# harmful random sparse words. Both include a zero prefix and repeated key.
for population in ['repeat-vocabulary','random-sparse']:
 for seed in range(120):
  r=random.Random(seed+1000);words=[];vocab=[r.getrandbits(32)|1 for _ in range(8)]
  for _ in range(1024):
   if r.randrange(4):words.append(0)
   elif population=='repeat-vocabulary':words.append(vocab[r.randrange(len(vocab))])
   else:words.append(r.getrandbits(32)|1)
  data=bytearray().join(x.to_bytes(4,'little') for x in words);data[:8]=bytes(8)
  key=b'ABCDWXYZ';data[8:16]=key;data[256:264]=key
  if seed%2==0:data[768:776]=key
  pages.append((population,bytes(data)))
# Guarded tails and search-boundary/alignment cases have independently
# checked outputs, including pages too short to contain the probe.
for length in [0,1,7,8,15,16,17,31,32,63,64,65,71,72,73,127,128,129,1023,1024,1025,1031,1032,1033,1095,1096,1097,4095,4096]:
 for first in [8,16,32,64,72]:
  data=bytearray(length)
  if first+8<=length:
   data[first:first+8]=b'ABCDWXYZ'
   second=first+min(1024,max(8,length-first-8))
   if second+8<=length:data[second:second+8]=b'ABCDWXYZ'
  pages.append(('boundary',bytes(data)))
results={'transitions':0,'beneficial':0,'harmful':0,'equal_size':0,'unchanged':0,'roundtrips':0,'capacity_checks':0,'alignment_checks':0,'by_population':{}}
for label,data in pages:
 n=len(data);inp=guards.Guard(n);C.memmove(inp.ptr,data,n)
 try:
  for log in [5,8,10,12]:
   frames=[]
   for lib in [parent,candidate]:
    dst=guards.Guard(n+8);size=lib.gzram_encode_avx2(inp.ptr,n,dst.ptr,n+8,log);assert 0<size<=n+8
    frame=C.string_at(dst.ptr,size);assert independent(frame)==data;frames.append(frame);dst.close()
   old,new=frames
   predicted=old[6]==1 and len(old)-8>n//4 and sample.zero_prefix_recurrence_count(data)>=a.minimum_matches
   if predicted:
    assert new[6] in [0,2],(label,n,log,old[6],new[6]);results['transitions']+=1
    if n==4096:
     packed=C.create_string_buffer(n);size=table.n100_reuse_compress(inp.ptr,packed,n,n,tablework)
     if 0<size<n:assert new[6]==2 and new[8:]==packed.raw[:size]
     else:assert new[6]==0 and new[8:]==data
    key='beneficial' if len(new)<len(old) else 'harmful' if len(new)>len(old) else 'equal_size';results[key]+=1
    result=results['by_population'].setdefault(label,{'transitions':0,'beneficial':0,'harmful':0,'equal_size':0});result['transitions']+=1;result[key]+=1
   else:
    assert new==old,('unpredicted byte change',label,n,log);results['unchanged']+=1
   for isa in ['scalar','avx2']:
    enc=getattr(candidate,'gzram_encode_'+isa);out=C.create_string_buffer(n+8);got=enc(inp.ptr,n,out,n+8,log);assert out.raw[:got]==new
    for lib in [parent,candidate]:
     decoded=guards.Guard(n);size=getattr(lib,'gzram_decode_'+isa)(out,got,decoded.ptr,n);assert size==n and C.string_at(decoded.ptr,n)==data;decoded.close();results['roundtrips']+=1
    for cap in set([0,7,8,max(0,len(new)-1),len(new),n+8]):
     bounded=guards.Guard(cap);size=enc(inp.ptr,n,bounded.ptr,cap,log);assert 0<=size<=cap
     if size:assert independent(C.string_at(bounded.ptr,size))==data
     bounded.close();results['capacity_checks']+=1
   if n==4096 and log==10:
    for align in [1,2,3,7,8,15,31]:
     src=C.create_string_buffer(n+64);ptr=C.addressof(src)+align;C.memmove(ptr,data,n);out=C.create_string_buffer(n+8);size=candidate.gzram_encode_avx2(ptr,n,out,n+8,log);assert out.raw[:size]==new;results['alignment_checks']+=1
 finally:inp.close()
assert results['transitions']>0 and results['beneficial']>0 and results['harmful']>0,results
print(json.dumps(dict(status='passed',scope='Synthetic selection, independent decoding, guarded capacity and alignment checks; retained beneficial and harmful compressed-size cases',**results)))
