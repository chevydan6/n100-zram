#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""GHY1 independent wire checks, cross-path guards, fuzzing and concurrency."""
import argparse,concurrent.futures,ctypes as C,json,random,struct,sys
from pathlib import Path
root=Path(__file__).resolve().parents[2];sys.path.insert(0,str(root/'tests'))
from guard_buffers import Guard
from wire import decode as gz_decode_wire
p=argparse.ArgumentParser();p.add_argument('--library',type=Path,required=True);p.add_argument('--other-libraries',type=Path,nargs='*',default=[]);a=p.parse_args();lib=C.CDLL(str(a.library))
encoders=[lib.gzram_encode_scalar,lib.gzram_encode_avx2];decoders=[lib.gzram_decode_scalar,lib.gzram_decode_avx2]
for other in a.other_libraries:
 h=C.CDLL(str(other));decoders += [h.gzram_decode_scalar,h.gzram_decode_avx2]
for f in encoders:f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint];f.restype=C.c_int
for f in decoders:f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t];f.restype=C.c_int
lz4=C.CDLL('liblz4.so.1').LZ4_decompress_safe;lz4.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int];lz4.restype=C.c_int
def oracle(frame):
 if len(frame)<8 or len(frame)>4136 or frame[:4]!=b'GHY1':raise ValueError()
 n,kind,reserved=struct.unpack('<HBB',frame[4:8]);payload=frame[8:]
 if n>4096 or kind>2 or reserved:raise ValueError()
 if kind==0:
  if len(payload)!=n:raise ValueError()
  return payload
 if not n:raise ValueError()
 if kind==1:out=gz_decode_wire(payload)
 else:
  buf=C.create_string_buffer(n);got=lz4(payload,buf,len(payload),n)
  if got!=n:raise ValueError()
  out=buf.raw
 if len(out)!=n:raise ValueError()
 return out
rng=random.Random(305);inputs=[]
for size in list(range(0,65))+[127,128,129,255,256,257,511,512,513,1023,1024,1025,2047,2048,2049,4095,4096]:
 inputs += [rng.randbytes(size),bytes(size),(b'ABCD'*((size+3)//4))[:size]]
for _ in range(100):
 n=rng.randrange(4097);inputs.append(bytes(0 if rng.randrange(4) else rng.randrange(256) for _ in range(n)))
pattern=bytes((i*37+11)%256 for i in range(127));period=(pattern*33)[:4096]
long_pattern=rng.randbytes(509);long_period=(long_pattern*9)[:4096]
inputs += [long_period[:2048]+bytes(2048),period,period[:2048]+bytes(2048),rng.randbytes(2048)+bytes(2048),struct.pack('<I',1)+bytes(4092),Path('/usr/bin/bash').read_bytes()[4096:8192]]
roundtrips=capacity=0;frames=[];modes=set()
for index,data in enumerate(inputs):
 src=Guard(len(data));C.memmove(src.ptr,data,len(data))
 for log in range(5,13):
  reference=None
  for encode in encoders:
   packed=Guard(len(data)+8);n=encode(src.ptr,len(data),packed.ptr,len(data)+8,log);assert 0<n<=len(data)+8
   frame=C.string_at(packed.ptr,n);assert oracle(frame)==data;modes.add(frame[6])
   if reference is None:reference=frame
   else:assert frame==reference,'scalar/AVX2 selection differs'
   if index%23==0:frames.append(frame)
   for decode in decoders:
    out=Guard(len(data));got=decode(packed.ptr,n,out.ptr,len(data));assert got==len(data) and C.string_at(out.ptr,len(data))==data;out.close();roundtrips+=1
   for cap in set([0,7,max(0,n-1),n]):
    out=Guard(cap);got=encode(src.ptr,len(data),out.ptr,cap,log);assert got==0 or 0<got<=cap
    if got:assert oracle(C.string_at(out.ptr,got))==data
    out.close();capacity+=1
   packed.close()
 src.close()
assert modes=={0,1,2},modes
if 'recurrence' in a.library.name:
 for data in [period,period[:2048]+bytes(2048),long_period[:2048]+bytes(2048)]:
  out=C.create_string_buffer(4104);n=encoders[1](data,4096,out,4104,10)
  assert n<(768 if data==long_period[:2048]+bytes(2048) else 256) and out.raw[6]==2,'Repeated-prefix ratio recovery failed'

# Outer/nested length disagreement, reserved modes, short LZ4 and empty-frame cases.
frames += [b'GHY1'+struct.pack('<HBB',32,1,0)+b'GZR1'+struct.pack('<HBB',64,6,0)+bytes([1]),b'GHY1'+struct.pack('<HBB',4096,2,0)+b'\0',b'GHY1'+struct.pack('<HBB',0,1,0)+b'GZR1'+bytes(4)]
malformed=0
for i in range(20000):
 if i%3:
  b=bytearray(rng.choice(frames))
  if i%2:b=b[:rng.randrange(len(b)+1)]
  elif b:b[rng.randrange(len(b))]^=1<<rng.randrange(8)
  frame=bytes(b)
 else:frame=rng.randbytes(rng.randrange(4137))
 try:expected=oracle(frame)
 except ValueError:expected=None
 src=Guard(len(frame));C.memmove(src.ptr,frame,len(frame));cap=4096 if i%2 else rng.randrange(4097)
 for decode in decoders:
  out=Guard(cap);got=decode(src.ptr,len(frame),out.ptr,cap)
  if expected is not None and len(expected)<=cap:assert got==len(expected) and C.string_at(out.ptr,got)==expected
  else:assert got==-1
  out.close();malformed+=1
 src.close()
def worker(seed):
 randomizer=random.Random(seed)
 for _ in range(1000):
  data=randomizer.choice(inputs);packed=C.create_string_buffer(len(data)+8);out=C.create_string_buffer(max(1,len(data)))
  n=randomizer.choice(encoders)(data,len(data),packed,len(data)+8,randomizer.randrange(5,13));assert n>0
  assert randomizer.choice(decoders)(packed,n,out,len(data))==len(data) and out.raw[:len(data)]==data
 return 1000
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:concurrent=sum(pool.map(worker,range(4)))
print(json.dumps({'status':'passed','roundtrips':roundtrips,'guarded_capacity_cases':capacity,'malformed_or_mutated_decode_cases':malformed,'four_thread_roundtrips':concurrent,'modes_checked':sorted(modes)}))
