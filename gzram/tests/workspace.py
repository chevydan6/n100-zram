#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Explicit-workspace GHY1 API bounds, identity, reuse and concurrent ownership."""
import argparse
import concurrent.futures
import ctypes as C
import json
import random
import sys
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--library', type=Path, required=True)
p.add_argument('--reference', type=Path, required=True)
a = p.parse_args()
sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'tests'))
from guard_buffers import Guard
lib = C.CDLL(str(a.library))
reference = C.CDLL(str(a.reference)).gzram_encode_scalar
reference.argtypes = [C.c_void_p, C.c_size_t, C.c_void_p, C.c_size_t, C.c_uint]
reference.restype = C.c_int
encode = lib.n100_ghy_encode
encode.argtypes = reference.argtypes + [C.c_void_p, C.c_size_t]
encode.restype = C.c_int
decode = lib.n100_ghy_decode
decode.argtypes = [C.c_void_p, C.c_size_t, C.c_void_p, C.c_size_t]
decode.restype = C.c_int
lib.n100_ghy_workspace_size.restype = C.c_size_t
lib.n100_ghy_workspace_alignment.restype = C.c_size_t
size, alignment = lib.n100_ghy_workspace_size(), lib.n100_ghy_workspace_alignment()
assert size == 4128 and alignment == 8, (size, alignment)
rng = random.Random(905)
inputs = []
for n in [0, 1, 31, 32, 33, 127, 128, 129, 1023, 1024, 1025, 4095, 4096]:
    inputs += [rng.randbytes(n), bytes(n), (b'abcdefghijklmnop' * ((n + 15) // 16))[:n]]
inputs += [Path('/usr/bin/bash').read_bytes()[4096:8192], rng.randbytes(2048) + bytes(2048),
           b''.join(rng.randbytes(4) + bytes(28) for _ in range(128))]
work = Guard(size)
assert work.ptr % alignment == 0
checks = 0
for data in inputs:
    src, packed, out = Guard(len(data)), Guard(len(data) + 8), Guard(len(data))
    C.memmove(src.ptr, data, len(data))
    for log in [5, 8, 10, 12]:
        expected = C.create_string_buffer(len(data) + 8)
        count = reference(src.ptr, len(data), expected, len(data) + 8, log)
        assert count > 0
        # Adversarial prior contents and reuse across unrelated pages must not
        # create a persistent dictionary or change the independently decodable frame.
        for poison in [0, 0xa5, 0xff]:
            C.memset(work.ptr, poison, size)
            got = encode(src.ptr, len(data), packed.ptr, len(data) + 8, log, work.ptr, size)
            assert got == count and C.string_at(packed.ptr, got) == expected.raw[:count]
            assert decode(packed.ptr, got, out.ptr, len(data)) == len(data)
            assert C.string_at(out.ptr, len(data)) == data
            checks += 1
        for ptr, capacity in [(None, size), (work.ptr, 0), (work.ptr, size - 1), (work.ptr + 1, size)]:
            C.memset(work.ptr, 0xa5, size)
            C.memset(packed.ptr, 0x5a, len(data) + 8)
            assert encode(src.ptr, len(data), packed.ptr, len(data) + 8, log, ptr, capacity) == 0
            assert C.string_at(work.ptr, size) == b'\xa5' * size
            assert C.string_at(packed.ptr, len(data) + 8) == b'\x5a' * (len(data) + 8)
            checks += 1
    src.close(); packed.close(); out.close()
work.close()

def worker(seed):
    rng = random.Random(seed)
    work = Guard(size)
    packed, out = Guard(4104), Guard(4096)
    count = 0
    try:
        for _ in range(250):
            data = inputs[rng.randrange(len(inputs))]
            log = rng.randrange(5, 13)
            expected = C.create_string_buffer(len(data) + 8)
            expected_size = reference(data, len(data), expected, len(data) + 8, log)
            got = encode(data, len(data), packed.ptr, 4104, log, work.ptr, size)
            assert got == expected_size and C.string_at(packed.ptr, got) == expected.raw[:got]
            assert decode(packed.ptr, got, out.ptr, 4096) == len(data)
            assert C.string_at(out.ptr, len(data)) == data
            count += 1
    finally:
        work.close(); packed.close(); out.close()
    return count

with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
    concurrent = sum(pool.map(worker, range(100, 104)))
print(json.dumps(dict(status='passed',workspace_bytes=size,workspace_alignment=alignment,
                     identity_reuse_and_rejection_cases=checks,four_thread_roundtrips=concurrent,
                     scope='Explicit userspace workspace API; kernel code generation and performance not tested')))
