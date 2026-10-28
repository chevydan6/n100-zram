#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Exercise vector scanners directly, bypassing hybrid page-selection shortcuts."""
import argparse
import ctypes as C
import json
import random
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(root / 'tests'))
from guard_buffers import Guard
from wire import decode

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--directory', type=Path, required=True)
a = p.parse_args()
handles = []
encoders = []
for policy in ['bitdirect', 'bitdirectpipe1', 'bitdirectpipe2', 'bitdirectpipe4',
               'bitdirectavxbits2', 'bitdirectavxbits4']:
    lib = C.CDLL(str(a.directory / f'libgzram-hybrid-{policy}.so'))
    assert lib.gzram_avx2_available(), 'This test requires actual AVX2 execution'
    handles.append(lib)
    encode = lib.gzram_base_encode_avx2
    encode.argtypes = [C.c_void_p, C.c_size_t, C.c_void_p, C.c_size_t, C.c_uint]
    encode.restype = C.c_int
    encoders.append(encode)

rng = random.Random(707)
pages = []
for length in [32,64,96,128,160,224,256,288,992,1024,1056,4064,4096]:
    for period in [4,8,16,32]:
        pattern = rng.randbytes(period)
        repeated = (pattern * ((length + period - 1) // period))[:length]
        pages.append(repeated)
        for group in range(length // 32):
            data = bytearray(repeated)
            data[group * 32 + group % 32] ^= 0x80
            pages.append(bytes(data))
    for group in range(length // 32):
        data = bytearray(length)
        data[group * 32 + group % 32] = 0x80
        pages.append(bytes(data))
# Unaligned guarded source endings and every remainder in a four-group scan.
for length in range(1,289):
    pages.extend([rng.randbytes(length), bytes(length),
                  bytes(rng.randrange(256) if rng.randrange(8)==0 else 0
                        for _ in range(length))])

checks = capacities = 0
for data in pages:
    src = Guard(len(data))
    C.memmove(src.ptr, data, len(data))
    for log in range(5,13):
        reference = None
        for encode in encoders:
            out = Guard(len(data)+8)
            size = encode(src.ptr, len(data), out.ptr, len(data)+8, log)
            assert 0 < size <= len(data)+8
            frame = C.string_at(out.ptr, size)
            assert decode(frame) == data
            if reference is None:
                reference = frame
            else:
                assert frame == reference
            out.close()
            for cap in [size-1,size]:
                out = Guard(cap)
                got = encode(src.ptr,len(data),out.ptr,cap,log)
                assert got == 0 or 0 < got <= cap
                if got:
                    assert decode(C.string_at(out.ptr,got)) == data
                out.close()
                capacities += 1
            checks += 1
    src.close()
print(json.dumps(dict(status='passed', inputs=len(pages),
                      direct_vector_encodes=checks, guarded_capacities=capacities)))
