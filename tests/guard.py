#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Place codec buffers against inaccessible pages; a bound error terminates this process."""
import ctypes as C, random, mmap
from check import codecs
libc=C.CDLL(None,use_errno=True)
libc.mmap.restype=C.c_void_p
libc.mmap.argtypes=[C.c_void_p,C.c_size_t,C.c_int,C.c_int,C.c_int,C.c_long]
libc.mprotect.argtypes=[C.c_void_p,C.c_size_t,C.c_int]
libc.munmap.argtypes=[C.c_void_p,C.c_size_t]
class Guard:
    def __init__(self,n):
        self.total=((max(n,1)+4095)//4096+2)*4096
        self.base=libc.mmap(None,self.total,0,mmap.MAP_PRIVATE|mmap.MAP_ANONYMOUS,-1,0)
        assert self.base != C.c_void_p(-1).value
        assert libc.mprotect(self.base+4096,self.total-8192,3)==0
        self.ptr=self.base+self.total-4096-n; self.n=n
    def close(self): assert libc.munmap(self.base,self.total)==0
rng=random.Random(104)
libs=codecs(); count=0
for n in list(range(0,257))+[511,512,1023,1024,2047,2048,4095,4096]:
    for period in [0,1,3,7,8,15,16,31,32,33,127]:
        pattern=bytes(rng.randrange(256) for _ in range(period or max(n,1)))
        data=(pattern*((n+len(pattern)-1)//len(pattern)))[:n]
        src=Guard(n); C.memmove(src.ptr,data,n)
        for name,(comp,dec) in libs.items():
            bound=n+n//255+16; dst=Guard(bound);work=C.create_string_buffer(32768)
            size=comp(src.ptr,dst.ptr,n,bound,work);assert size>0,(name,n)
            encoded=C.string_at(dst.ptr,size); dst.close()
            packed=Guard(size);C.memmove(packed.ptr,encoded,size)
            out=Guard(n);got=dec(packed.ptr,out.ptr,size,n)
            assert got==n and C.string_at(out.ptr,n)==data,(name,n,got)
            out.close();packed.close();count+=1
        src.close()
for _ in range(5000):
    n=rng.randrange(1,512);src=Guard(n);C.memmove(src.ptr,bytes(rng.randrange(256) for _ in range(n)),n)
    cap=rng.randrange(4097)
    for name,(_,dec) in libs.items():
        out=Guard(cap);got=dec(src.ptr,out.ptr,n,cap);assert got<=cap
        out.close();count+=1
    src.close()
print(f'guard-page checks passed: {count}')
