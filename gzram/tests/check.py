#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Independent format oracle, guard pages, malformed frames and concurrency."""
import argparse,concurrent.futures,ctypes as C,json,random,struct,sys
from pathlib import Path
root=Path(__file__).resolve().parents[2];sys.path.insert(0,str(root/'tests'))
from guard_buffers import Guard
p=argparse.ArgumentParser();p.add_argument('--library',type=Path,default=root/'build/gzram/libgzram.so');a=p.parse_args()
lib=C.CDLL(str(a.library));encoders=[lib.gzram_encode_scalar,lib.gzram_encode_avx2];decoders=[lib.gzram_decode_scalar,lib.gzram_decode_avx2]
for f in encoders:f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint];f.restype=C.c_int
for f in decoders:f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t];f.restype=C.c_int
def oracle(frame):
 if len(frame)<8 or len(frame)>4104 or frame[:4]!=b'GZR1':raise ValueError()
 n,log,raw=struct.unpack('<HBB',frame[4:8])
 if n>4096 or not 5<=log<=12 or raw>1:raise ValueError()
 if raw:
  if len(frame)!=n+8:raise ValueError()
  return frame[8:]
 block=1<<log;chunks=(n+block-1)//block;pos=8+chunks;output=bytearray()
 if pos>len(frame):raise ValueError()
 for chunk in range(chunks):
  length=min(block,n-len(output));mode=frame[8+chunk]
  if mode==0:
   if pos+length>len(frame):raise ValueError()
   output.extend(frame[pos:pos+length]);pos+=length
  elif mode==1:output.extend(bytes(length))
  elif mode==4:
   if length%32:raise ValueError()
   groups=length//32;masks=frame[pos:pos+groups];pos+=groups
   if len(masks)!=groups:raise ValueError()
   for mask in masks:
    for lane in range(8):
     if mask&(1<<lane):
      if pos+4>len(frame):raise ValueError()
      output.extend(frame[pos:pos+4]);pos+=4
     else:output.extend(bytes(4))
  else:
   period={2:4,3:8,5:16,6:32}.get(mode)
   if period is None or period>length or length%period or pos+period>len(frame):raise ValueError()
   output.extend(frame[pos:pos+period]*(length//period));pos+=period
 if pos!=len(frame) or len(output)!=n:raise ValueError()
 return bytes(output)
def encode(data,log,fn):
 out=C.create_string_buffer(len(data)+8);n=fn(data,len(data),out,len(out),log);assert n>0;return out.raw[:n]
# Explicit wire fixtures verify control/data separation and little-endian lengths.
assert encode(bytes(32),5,encoders[0])==b'GZR1'+struct.pack('<HBB',32,5,0)+b'\1'
assert encode(bytes(range(32)),5,encoders[0])==b'GZR1'+struct.pack('<HBB',32,5,1)+bytes(range(32))
assert encode(struct.pack('<I',1)+bytes(60),6,encoders[0])==b'GZR1'+struct.pack('<HBB',64,6,0)+bytes([4,1,0])+struct.pack('<I',1)
rng=random.Random(104);inputs=[]
for size in list(range(0,130))+[255,256,257,511,512,513,1023,1024,1025,2047,2048,2049,4095,4096]:
 inputs.extend([rng.randbytes(size),bytes(size),(b'ABCD'*((size+3)//4))[:size],(bytes(range(32))*((size+31)//32))[:size]])
for _ in range(400):
 size=rng.randrange(4097);inputs.append(bytes(0 if rng.randrange(4) else rng.randrange(256) for _ in range(size)))
inputs.extend([struct.pack('<I',1)+bytes(4092),rng.randbytes(2048)+bytes(2048)])
roundtrips=0;capacity_cases=0;frames=[]
for index,data in enumerate(inputs):
 source=Guard(len(data));C.memmove(source.ptr,data,len(data))
 for log in range(5,13):
  reference=None
  for fn in encoders:
   packed=Guard(len(data)+8);n=fn(source.ptr,len(data),packed.ptr,len(data)+8,log);assert 0<n<=len(data)+8
   frame=C.string_at(packed.ptr,n);assert oracle(frame)==data
   if reference is None:reference=frame
   else:assert frame==reference,'scalar/AVX2 format differs'
   if index%41==0:frames.append(frame)
   for decode in decoders:
    output=Guard(len(data));assert decode(packed.ptr,n,output.ptr,len(data))==len(data) and C.string_at(output.ptr,len(data))==data;output.close();roundtrips+=1
   for cap in set([0,7,max(0,n-1),n]):
    small=Guard(cap);got=fn(source.ptr,len(data),small.ptr,cap,log);assert got==0 or 0<got<=cap
    if got:assert oracle(C.string_at(small.ptr,got))==data
    small.close();capacity_cases+=1
   packed.close()
 source.close()
# Include valid noncanonical short repeated chunks to exercise SIMD tails.
for period,mode in [(4,2),(8,3),(16,5),(32,6)]:
 for size in [period,period*3,period*5]:
  if size>4096:continue
  block=256;frames.append(b'GZR1'+struct.pack('<HBB',size,8,0)+bytes([mode])+bytes(range(period)))
malformed=0
for i in range(20000):
 if i%3:
  b=bytearray(rng.choice(frames))
  if i%2:b=b[:rng.randrange(len(b)+1)]
  elif b:b[rng.randrange(len(b))]^=1<<rng.randrange(8)
  frame=bytes(b)
 else:frame=rng.randbytes(rng.randrange(4105))
 try:expected=oracle(frame)
 except ValueError:expected=None
 source=Guard(len(frame));C.memmove(source.ptr,frame,len(frame))
 cap=4096 if i%2 else rng.randrange(4097)
 for decode in decoders:
  out=Guard(cap);n=decode(source.ptr,len(frame),out.ptr,cap)
  if expected is not None and len(expected)<=cap:assert n==len(expected) and C.string_at(out.ptr,n)==expected
  else:assert n==-1
  out.close();malformed+=1
 source.close()
def worker(seed):
 rng=random.Random(seed);count=0
 for _ in range(1000):
  data=rng.choice(inputs);frame=encode(data,rng.randrange(5,13),rng.choice(encoders));out=C.create_string_buffer(max(1,len(data)))
  assert rng.choice(decoders)(frame,len(frame),out,len(data))==len(data) and out.raw[:len(data)]==data
  count+=1
 return count
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:concurrency=sum(pool.map(worker,range(4)))
print(json.dumps({'status':'passed','roundtrips':roundtrips,'guarded_output_capacity_cases':capacity_cases,'malformed_or_mutated_decode_cases':malformed,'four_thread_roundtrips':concurrency,'avx2_available':bool(lib.gzram_avx2_available())}))
