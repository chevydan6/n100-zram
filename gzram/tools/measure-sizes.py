#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Measure complete framed sizes with independent decoding, without timing."""
import argparse
import csv
import ctypes as C
import hashlib
import json
import os
import struct
import subprocess
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(root / 'gzram/tests'))
from wire import decode as wire_decode


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--benchmark', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    env = dict(os.environ, GZRAM_HYBRID_SCREEN='1')
    env.pop('GZRAM_VARIANT_LIST', None)

    def fixture(option):
        return subprocess.check_output([str(args.benchmark), str(args.directory), option], env=env)

    names = fixture('--list-variants').decode().splitlines()
    corpora = fixture('--list-corpora').decode().splitlines()
    lz4 = C.CDLL('liblz4.so.1').LZ4_decompress_safe
    lz4.argtypes = [C.c_void_p, C.c_void_p, C.c_int, C.c_int]
    lz4.restype = C.c_int
    decoded = C.create_string_buffer(4096)
    packed = C.create_string_buffer(4352)
    workspace = C.create_string_buffer(32768)
    codecs = []
    for name in names:
        if name == 'lz4-small-scalar':
            library = args.directory / 'lz4-small.so'
            handle = C.CDLL(str(library))
            encode = handle.LZ4_compress_default
            encode.argtypes = [C.c_void_p, C.c_void_p, C.c_int, C.c_int, C.c_void_p]
            log = None
        else:
            parts = name.split('-')
            isa, size = parts[-2:]
            if parts[0] == 'ghy':
                library = args.directory / f'libgzram-hybrid-{parts[1]}.so'
            else:
                suffix = '' if len(parts) == 3 else '-' + parts[1]
                library = args.directory / f'libgzram{suffix}.so'
            handle = C.CDLL(str(library))
            encode = getattr(handle, 'gzram_encode_' + isa)
            encode.argtypes = [C.c_void_p, C.c_size_t, C.c_void_p, C.c_size_t, C.c_uint]
            log = int(size).bit_length() - 1
        encode.restype = C.c_int
        codecs.append((name, handle, encode, log))

    def oracle(frame, name):
        if name.startswith('ghy-'):
            assert frame[:4] == b'GHY1'
            length, mode, reserved = struct.unpack('<HBB', frame[4:8])
            assert length == 4096 and reserved == 0 and mode in (0, 1, 2)
            frame = frame[8:]
            if mode == 0:
                return frame
            if mode == 1:
                return wire_decode(frame)
        elif name.startswith('gz-'):
            return wire_decode(frame, variable_period=name.startswith(('gz-period-', 'gz-filter-')))
        got = lz4(frame, decoded, len(frame), 4096)
        assert got == 4096
        return decoded.raw

    hashes = {}
    with (args.output / 'sizes.csv').open('w') as output:
        writer = csv.writer(output, lineterminator='\n')
        writer.writerow(['corpus', 'variant', 'page', 'compressed_bytes', 'hybrid_mode'])
        for corpus in corpora:
            data = fixture('--dump-corpus=' + corpus)
            assert len(data) == 128 * 4096
            hashes[corpus] = hashlib.sha256(data).hexdigest()
            for name, handle, encode, log in codecs:
                for page in range(128):
                    source = data[page * 4096:(page + 1) * 4096]
                    count = (encode(source, packed, 4096, len(packed), workspace) if log is None
                             else encode(source, 4096, packed, len(packed), log))
                    assert 0 < count <= len(packed), (corpus, name, page)
                    frame = packed.raw[:count]
                    assert oracle(frame, name) == source, (corpus, name, page)
                    writer.writerow([corpus, name, page, count, frame[6] if name.startswith('ghy-') else -1])
    metadata = dict(scope='Size and independent correctness only; no timing, CPU or energy measurements',
                    pages_per_corpus=128, variant_names=names, corpus_sha256=hashes,
                    manifest=json.loads((args.directory / 'manifest.json').read_text()),
                    benchmark_sha256=hashlib.sha256(args.benchmark.read_bytes()).hexdigest(),
                    script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    (args.output / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n')
    print(f'{len(names) * len(corpora) * 128} independently decoded size records; no performance measurement')


if __name__ == '__main__':
    main()
