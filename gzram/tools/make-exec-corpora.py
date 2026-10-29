#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Sample file pages covering executable ELF PT_LOAD segments before relocation.

These are public executable-file fixtures, not captured application heaps or a
claim about pages selected by real reclaim. Preserve existing first-512-KiB ELF
corpora separately. Never read user application memory or private documents.
"""
import argparse
import hashlib
import json
import struct
from pathlib import Path

PAGE, COUNT = 4096, 128
HEADER = struct.Struct('<16sHHIQQQIHHHHHH')
PROGRAM = struct.Struct('<IIQQQQQQ')
INPUTS = {'bash-exec': Path('/usr/bin/bash'), 'git-exec': Path('/usr/bin/git'),
          'libc-exec': Path('/usr/lib64/libc.so.6')}


def executable_offsets(data):
    if len(data) < HEADER.size:
        raise ValueError('Truncated ELF header')
    h = HEADER.unpack_from(data)
    if h[0][:7] != b'\x7fELF\x02\x01\x01' or h[1] not in (2, 3) or h[2] != 62 or h[3] != 1:
        raise ValueError('Require a little-endian ELF64 x86-64 executable/shared object')
    offset, entry_size, count = h[5], h[9], h[10]
    if h[8] != HEADER.size or entry_size != PROGRAM.size or not 1 <= count <= 1024:
        raise ValueError('Unsupported ELF/program-header size or count')
    if offset > len(data) or count * entry_size > len(data) - offset:
        raise ValueError('Truncated program-header table')
    offsets, segments = set(), []
    for i in range(count):
        kind, flags, start, address, _, size, memory, alignment = PROGRAM.unpack_from(data, offset + i * entry_size)
        if kind != 1 or not flags & 1:
            continue
        if size > memory or start > len(data) or size > len(data) - start or start % PAGE != address % PAGE:
            raise ValueError('Invalid executable segment bounds/alignment')
        if not size:
            continue
        pages = list(range(start // PAGE * PAGE, (start + size + PAGE - 1) // PAGE * PAGE, PAGE))
        offsets.update(pages)
        segments.append(dict(index=i, file_offset=start, virtual_address=address,
                             file_bytes=size, memory_bytes=memory, flags=flags,
                             alignment=alignment, covering_file_pages=len(pages)))
    if not offsets:
        raise ValueError('No executable file pages')
    return sorted(offsets), segments


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if args.output.exists():
        parser.error('Preserve existing fixtures; use a new output directory')
    # Validate all inputs before creating an output set.
    corpora = {}
    for name, path in INPUTS.items():
        data = path.read_bytes()
        offsets, segments = executable_offsets(data)
        selected = [offsets[i * (len(offsets) - 1) // (COUNT - 1)] for i in range(COUNT)]
        pages = b''.join(data[at:at + PAGE].ljust(PAGE, b'\0') for at in selected)
        assert len(pages) == COUNT * PAGE
        corpora[name] = (pages, dict(path=str(path), file_sha256=hashlib.sha256(data).hexdigest(),
                                    file_bytes=len(data), segments=segments,
                                    available_unique_pages=len(offsets), selected_file_offsets=selected,
                                    selected_unique_pages=len(set(selected)),
                                    corpus_sha256=hashlib.sha256(pages).hexdigest()))
    args.output.mkdir(parents=True)
    for name, (pages, _) in corpora.items():
        (args.output / (name + '.bin')).write_bytes(pages)
    record = dict(scope='Deterministic evenly spaced executable PT_LOAD covering file pages, before relocation; not anonymous runtime memory or measured reclaim selection. File-page padding is retained; EOF is zero-padded. BSS-only pages are excluded.',
                  pages_per_corpus=COUNT, page_bytes=PAGE, generator_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  corpora={name: record for name, (_, record) in corpora.items()})
    (args.output / 'manifest.json').write_text(json.dumps(record, indent=2) + '\n')
    print(json.dumps({name: entry['selected_unique_pages'] for name, entry in record['corpora'].items()}))


if __name__ == '__main__':
    main()
