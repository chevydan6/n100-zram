# SPDX-License-Identifier: GPL-2.0-only
"""Buffers ending at an inaccessible page for native codec bound checks."""
import ctypes as C, mmap
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
