#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded smaller-table encoding and independent decoding, including failed output."""
import argparse,ctypes as C,concurrent.futures,random
from pathlib import Path
from check import pages
from guard_buffers import Guard
root=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--directory',type=Path,default=root/'build/small-table');a=p.parse_args()
independent=C.CDLL('liblz4.so.1').LZ4_decompress_safe;independent.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int]
libs=[]
for path in sorted(a.directory.glob('table*.so')):
 lib=C.CDLL(str(path));lib.n100_reuse_worksize.restype=C.c_ulong;lib.n100_reuse_init.argtypes=[C.c_void_p]
 lib.n100_reuse_compress.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int,C.c_void_p];lib.n100_reuse_decompress.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int]
 assert lib.n100_reuse_worksize()==(1<<int(path.stem[5:7]))+32
 libs.append((path.stem,lib))
assert len(libs)==6
inputs=[data+bytes(4096-len(data)) for data in pages()]
rng=random.Random(201);inputs += [rng.randbytes(4096) for _ in range(128)]
count=0
for name,lib in libs:
 work=Guard(lib.n100_reuse_worksize());lib.n100_reuse_init(work.ptr)
 for idx,data in enumerate(inputs):
  source=Guard(4096);C.memmove(source.ptr,data,4096)
  for cap in [4352,[0,1,8,64,256,2048,4096][idx%7]]:
   packed=Guard(cap);out=Guard(4096)
   size=lib.n100_reuse_compress(source.ptr,packed.ptr,4096,cap,work.ptr)
   assert 0<=size<=cap,(name,'size',cap,size)
   if cap==4352:assert size>0
   if size:
    for decode in [independent,lib.n100_reuse_decompress]:
     assert decode(packed.ptr,out.ptr,size,4096)==4096 and C.string_at(out.ptr,4096)==data,(name,'decode')
   packed.close();out.close();count+=1
  source.close()
 work.close()
def worker(seed):
 rng=random.Random(seed);count=0
 for name,lib in libs:
  work=Guard(lib.n100_reuse_worksize());lib.n100_reuse_init(work.ptr)
  for _ in range(1000):
   data=inputs[rng.randrange(len(inputs))];packed=C.create_string_buffer(4352);out=C.create_string_buffer(4096)
   n=lib.n100_reuse_compress(data,packed,4096,4352,work.ptr)
   assert n>0 and independent(packed,out,n,4096)==4096 and out.raw==data
   count+=1
  work.close()
 return count
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:concurrent=sum(pool.map(worker,range(4)))
print(f'Small-table correctness passed: {count} guarded capacity cases; {concurrent} independent concurrent decodes')
