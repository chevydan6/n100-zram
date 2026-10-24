#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Guarded first-match hint and differential testing of the selected decoder."""
import ctypes as C,os,random,subprocess
from pathlib import Path
from check import codecs,pages
from guard_buffers import Guard
root=Path(__file__).resolve().parents[1];dest=root/'build/selection';dest.mkdir(exist_ok=True)
source=dest/'bridge.c';source.write_text('#include "select.h"\nint choose(const char*s,int n){return n100_first_long_period(s,n);}\n')
subprocess.run(['gcc','-O3','-mno-avx','-fPIC','-shared','-I'+str(root/'kernel'),str(source),'-o',str(dest/'bridge.so')],check=True)
bridge=C.CDLL(str(dest/'bridge.so'));choose=bridge.choose;choose.argtypes=[C.c_void_p,C.c_int]
libs=codecs();compress,original=libs['scalar'];optimized=libs['scalar-matchrep8'][1]
assert choose(None,-1)==0 and choose(None,0)==0
selected=0;count=0
for data in pages():
 packed=C.create_string_buffer(4352);work=C.create_string_buffer(32768)
 size=compress(data,packed,len(data),4352,work);assert size>0
 guard=Guard(size);C.memmove(guard.ptr,packed,size);out=Guard(len(data))
 use=choose(guard.ptr,size);assert use in [0,1]
 decoder=optimized if len(data)==4096 and use else original
 got=decoder(guard.ptr,out.ptr,size,len(data));assert got==len(data) and C.string_at(out.ptr,got)==data
 selected+=int(use and len(data)==4096);count+=1
 guard.close();out.close()
rng=random.Random(217)
for n in list(range(4353))+[rng.randrange(4353) for _ in range(20000)]:
 data=bytes([255])*n if n%7==0 else bytes(rng.getrandbits(8) for _ in range(n))
 guard=Guard(n);C.memmove(guard.ptr,data,n);use=choose(guard.ptr,n);assert use in [0,1]
 a=Guard(4096);b=Guard(4096)
 first=original(guard.ptr,a.ptr,n,4096);second=(optimized if use else original)(guard.ptr,b.ptr,n,4096)
 assert (first<0)==(second<0) and (first<0 or (first==second and C.string_at(a.ptr,first)==C.string_at(b.ptr,second)))
 guard.close();a.close();b.close();count+=1
print(f'Selected-decoder guarded differential cases passed: {count}; selected valid 4 KiB inputs: {selected}')
assert selected>0
