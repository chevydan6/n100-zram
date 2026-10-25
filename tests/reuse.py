#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Independent byte identity, protected buffers, epoch wrap and private concurrency."""
import argparse,ctypes as C,concurrent.futures,random
from pathlib import Path
from check import pages
from guard_buffers import Guard
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--directory',type=Path,default=root/'build/reuse');a=p.parse_args()
reference=C.CDLL(str(root/'build/scalar.so'));comp=reference.LZ4_compress_default;comp.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int,C.c_void_p]
liblz4=C.CDLL('liblz4.so.1');decode=liblz4.LZ4_decompress_safe;decode.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int]
variants=[]
for path in sorted(a.directory.glob('*.so')):
 lib=C.CDLL(str(path));lib.n100_reuse_worksize.restype=C.c_ulong;lib.n100_reuse_init.argtypes=[C.c_void_p];lib.n100_reuse_compress.argtypes=comp.argtypes
 work=Guard(lib.n100_reuse_worksize());lib.n100_reuse_init(work.ptr);variants.append((path.stem,lib,work))
assert variants
# Force the exact u16/u32 virtual-position rollover after a clean initialization.
for name,lib,work in variants:
 lib.n100_reuse_epoch_offset.restype=C.c_ulong
 table_type=C.c_uint32 if '32-' in name else C.c_uint16
 old_base=0xfffff000 if '32-' in name else 61440
 table=(table_type*8192).from_address(work.ptr)
 for entry in range(8192):table[entry]=old_base+(entry%4084)
 C.c_uint32.from_address(work.ptr+lib.n100_reuse_epoch_offset()).value=0xfffff000 if '32-' in name else 61440
 out=C.create_string_buffer(4352);reference_out=C.create_string_buffer(4352);reference_work=C.create_string_buffer(32768)
 data=bytes(range(256))*16
 expected=comp(data,reference_out,4096,4352,reference_work)
 got=lib.n100_reuse_compress(data,out,4096,4352,work.ptr)
 assert got==expected and out.raw[:got]==reference_out.raw[:expected],(name,'forced wrap')
rng=random.Random(493);count=0
inputs=[raw+bytes(4096-len(raw)) for raw in pages()]
inputs += [rng.randbytes(2048)+bytes(2048),rng.randbytes(4096)]
refwork=C.create_string_buffer(32768)
for data in inputs:
 source=Guard(4096);C.memmove(source.ptr,data,4096)
 expected=C.create_string_buffer(4352);size=comp(source.ptr,expected,4096,4352,refwork);assert size>0
 for name,lib,work in variants:
  packed=Guard(4352);out=Guard(4096)
  got=lib.n100_reuse_compress(source.ptr,packed.ptr,4096,4352,work.ptr)
  assert got==size and C.string_at(packed.ptr,got)==expected.raw[:size],(name,'bytes',count)
  assert decode(packed.ptr,out.ptr,got,4096)==4096 and C.string_at(out.ptr,4096)==data
  packed.close();out.close();count+=1
 source.close()
# Reuse far beyond the 16-page u16-position interval, with failed-capacity calls.
for iteration in range(70000):
 data=inputs[(iteration*104729)%len(inputs)];cap=[0,1,8,15,64,256,4096,4352][iteration%8]
 expected=C.create_string_buffer(4352);size=comp(data,expected,4096,cap,refwork)
 for name,lib,work in variants:
  packed=Guard(cap);got=lib.n100_reuse_compress(data,packed.ptr,4096,cap,work.ptr)
  assert got==size and (got==0 or C.string_at(packed.ptr,got)==expected.raw[:size]),(name,'epoch/capacity',iteration,cap)
  packed.close();count+=1
for _,_,work in variants:work.close()
def worker(seed):
 rng=random.Random(seed);n=0
 for name,lib,_ in variants:
  work=Guard(lib.n100_reuse_worksize());lib.n100_reuse_init(work.ptr)
  for _ in range(1000):
   data=inputs[rng.randrange(len(inputs))];packed=C.create_string_buffer(4352);out=C.create_string_buffer(4096)
   got=lib.n100_reuse_compress(data,packed,4096,4352,work.ptr)
   assert got>0 and decode(packed,out,got,4096)==4096 and out.raw==data,(name,'concurrency')
   n+=1
  work.close()
 return n
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:concurrent=sum(pool.map(worker,range(4)))
print(f'Reuse correctness passed: {count} guarded byte-identity cases; {concurrent} independent four-thread decodes; 70,000 warm calls per variant')
