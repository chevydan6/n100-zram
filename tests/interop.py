#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Independent liblz4 interoperability and four-thread separate-workspace tests."""
import ctypes as C, random, concurrent.futures
from check import codecs
libs=codecs();system=C.CDLL('liblz4.so.1')
system.LZ4_compress_default.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int]
system.LZ4_decompress_safe.argtypes=[C.c_void_p,C.c_void_p,C.c_int,C.c_int]
def worker(seed):
    rng=random.Random(seed);count=0
    for _ in range(300):
        n=rng.randrange(4097);period=rng.choice([1,3,7,8,15,16,31,32,127,4096])
        pattern=bytes(rng.randrange(256) for _ in range(period))
        data=(pattern*((n+period-1)//period))[:n]
        packed=C.create_string_buffer(4352)
        size=system.LZ4_compress_default(data,packed,n,4352);assert size>0
        encoded=packed.raw[:size]
        for name,(comp,dec) in libs.items():
            output=C.create_string_buffer(n+32);work=C.create_string_buffer(32768)
            assert dec(encoded,output,size,n)==n and output.raw[:n]==data,(name,'system->variant')
            size2=comp(data,packed,n,4352,work);assert size2>0
            assert system.LZ4_decompress_safe(packed,output,size2,n)==n and output.raw[:n]==data,(name,'variant->system')
            count+=1
    return count
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
    count=sum(pool.map(worker,range(4)))
print(f'independent liblz4 cross-decoding passed: {count} cases, four threads')
