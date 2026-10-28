#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""GHY1 independent wire checks, cross-path guards, fuzzing and concurrency."""
import argparse,concurrent.futures,ctypes as C,json,random,struct,sys
from pathlib import Path
root=Path(__file__).resolve().parents[2];sys.path.insert(0,str(root/'tests'))
from guard_buffers import Guard
from wire import decode as gz_decode_wire
p=argparse.ArgumentParser();p.add_argument('--library',type=Path,required=True);p.add_argument('--same-encoding-libraries',type=Path,nargs='*',default=[]);p.add_argument('--other-libraries',type=Path,nargs='*',default=[]);a=p.parse_args();lib=C.CDLL(str(a.library))
guarded=any(name in a.library.name for name in ['recurrence','guard','fused','wordmixed','splittail','outlinetail','ctzunpack','wordrepeat','ctzrepeat','bitpack','mixpack','repeatmerge','ctzfull','bitctz','bitfull','select2','select3','select4'])
encoders=[lib.gzram_encode_scalar,lib.gzram_encode_avx2];decoders=[lib.gzram_decode_scalar,lib.gzram_decode_avx2]
for other in a.other_libraries:
 h=C.CDLL(str(other));decoders += [h.gzram_decode_scalar,h.gzram_decode_avx2]
for f in encoders:f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint];f.restype=C.c_int
for f in decoders:f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t];f.restype=C.c_int
comparison_encoders=[]
for other in a.same_encoding_libraries:
 h=C.CDLL(str(other))
 for f in [h.gzram_encode_scalar,h.gzram_encode_avx2]:f.argtypes=[C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t,C.c_uint];f.restype=C.c_int;comparison_encoders.append(f)
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
# Exercise nonzero anchors at every byte position and short/odd guarded tails.
for length in [32,63,64,65,96,127,128,129,1023,1024,1025,4095,4096]:
 for anchor in range(8):
  data=bytearray(length);data[8:max(8,length//3)]=rng.randbytes(max(0,length//3-8));data[anchor]=0x5a;inputs.append(bytes(data))
partial=bytearray(1024)
for at in range(0,1024,32):partial[at:at+12]=bytes([17])*4+bytes([34])*4+bytes([51])*4
partial[:8]=b'ABCDEFGH';partial_edge=bytes(partial)+bytes(partial[:8]);inputs.append(partial_edge)
edge_pattern=bytearray(rng.randbytes(1024));edge_pattern[:8]=bytes(7)+b'Z';edge_mixed=bytes(edge_pattern)*2+bytes(2048);inputs.append(edge_mixed)
# Equal repeat tags must not hide different patterns in adjacent blocks.
for repeat_period in [4,8,16,32]:
 pattern=bytes(range(1,repeat_period+1));different=bytes(range(65,65+repeat_period))
 inputs += [pattern*(4096//repeat_period),pattern*(2048//repeat_period)+different*(2048//repeat_period)]
 for length in [36,40,48,64,96,128,1028,1032,1040,1056,2056,2064,2080,4080,4092]:
  if length%repeat_period==0:inputs.append(pattern*(length//repeat_period))
 for log in range(5,12):
  block=1<<log
  inputs.append(b''.join((pattern if chunk%2==0 else different)*(block//repeat_period) for chunk in range(4096//block)))
# Exercise every packing population with rotating lanes, including full masks
# inside an otherwise sparse block. Changing word values prevents repeat mode
# from bypassing the packing path being checked.
for population in range(9):
 data=bytearray(4096)
 for group in range(1,128,2):
  mask=(1<<population)-1;rotation=group%8;mask=((mask<<rotation)|(mask>>(8-rotation)))&255
  for lane in range(8):
   if mask&(1<<lane):data[group*32+lane*4:group*32+lane*4+4]=struct.pack('<I',0x10203040+group*97+lane)
 inputs.append(bytes(data))
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
   for compare in comparison_encoders:
    match=C.create_string_buffer(len(data)+8);m=compare(src.ptr,len(data),match,len(data)+8,log);assert m==n and match.raw[:m]==frame,'Equivalent guard policies differ'
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
if guarded:
 for data in [period,period[:2048]+bytes(2048),long_period[:2048]+bytes(2048)]:
  out=C.create_string_buffer(4104);n=encoders[1](data,4096,out,4104,10)
  assert n<(768 if data==long_period[:2048]+bytes(2048) else 256) and out.raw[6]==2,'Repeated-prefix ratio recovery failed'

if guarded:
 out=C.create_string_buffer(4104);n=encoders[1](edge_mixed,4096,out,4104,10)
 assert 0<n<2048 and out.raw[6]==2,'Last prefix-search candidate was missed'
 out=C.create_string_buffer(len(partial_edge)+8);n=encoders[1](partial_edge,len(partial_edge),out,len(out),10)
 assert n>0 and out.raw[6]==2,'Partial-block prefix-search candidate was missed'
merge_checks=0
if 'repeatmerge' in a.library.name:
 for period in [4,8,16,32]:
  data=bytes(range(1,period+1))*(4096//period)
  for log in range(5,13):
   if 1<<log<=period:continue
   for encode in encoders:
    out=Guard(4104);n=encode(data,4096,out.ptr,4104,log);frame=C.string_at(out.ptr,n)
    assert n==17+period and frame[6]==1 and frame[14]==12 and oracle(frame)==data
    out.close();merge_checks+=1
# Exhaust every sparse-group mask independently of encoder selection. In
# particular, the encoder normally avoids dense MASK32 groups. Check those
# legal decoder inputs too, including exact boundaries and every truncation.
mask_checks=0
for mask in range(256):
 words=[struct.pack('<I',0x10203040+lane) for lane in range(8)]
 expected=b''.join(words[lane] if mask&(1<<lane) else bytes(4) for lane in range(8))
 nested=b'GZR1'+struct.pack('<HBB',32,5,0)+bytes([4,mask])+b''.join(words[lane] for lane in range(8) if mask&(1<<lane))
 frame=b'GHY1'+struct.pack('<HBB',32,1,0)+nested
 assert oracle(frame)==expected
 for length in range(len(frame)+1):
  src=Guard(length);C.memmove(src.ptr,frame,length)
  for decode in decoders:
   for cap in [31,32]:
    out=Guard(cap);got=decode(src.ptr,length,out.ptr,cap)
    if length==len(frame) and cap==32:assert got==32 and C.string_at(out.ptr,32)==expected
    else:assert got==-1
    out.close();mask_checks+=1
  src.close()
# Legal short repeat blocks need not be encoder-canonical. Exercise every
# sub-32-byte tail and reject lengths that do not divide by the stated period.
# Input and output end exactly at protected pages, including every truncation.
repeat_checks=0
for period,mode in [(4,2),(8,3),(16,5),(32,6)]:
 pattern=bytes(range(1,period+1))
 for length in list(range(1,41))+[48,64,96,128,4092,4096]:
  nested=b'GZR1'+struct.pack('<HBB',length,12,0)+bytes([mode])+pattern
  frame=b'GHY1'+struct.pack('<HBB',length,1,0)+nested
  valid=length>=period and length%period==0
  if valid:
   expected=pattern*(length//period);assert oracle(frame)==expected;frames.append(frame)
  else:
   try:oracle(frame)
   except ValueError:pass
   else:raise AssertionError('Independent oracle accepted a bad repeat length')
  for size in range(len(frame)+1):
   src=Guard(size);C.memmove(src.ptr,frame,size)
   for decode in decoders:
    for cap in [length-1,length]:
     out=Guard(cap);got=decode(src.ptr,size,out.ptr,cap)
     if valid and size==len(frame) and cap==length:assert got==length and C.string_at(out.ptr,length)==expected
     else:assert got==-1
     out.close();repeat_checks+=1
   src.close()
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
print(json.dumps({'status':'passed','roundtrips':roundtrips,'guarded_capacity_cases':capacity,'repeat_merge_checks':merge_checks,'repeat_decode_boundary_checks':repeat_checks,'exhaustive_mask_decode_checks':mask_checks,'malformed_or_mutated_decode_cases':malformed,'four_thread_roundtrips':concurrent,'modes_checked':sorted(modes)}))
