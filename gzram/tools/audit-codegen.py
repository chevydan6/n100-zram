#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Compare preserved codec text without modifying potentially loaded libraries."""
import argparse
import hashlib
import json
import shutil
import subprocess
import tempfile
from pathlib import Path


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def text_sha(path):
    # objcopy without an explicit output rewrites its input, even when dumping
    # a section. Only operate on a private copy, never an mmap'ed test artifact.
    before = sha(path)
    with tempfile.TemporaryDirectory() as directory:
        copied = Path(directory) / 'input.so'
        section = Path(directory) / 'text.bin'
        shutil.copyfile(path, copied)
        subprocess.run(['objcopy', '--dump-section', '.text=' + str(section),
                        str(copied)], check=True, capture_output=True)
        result = sha(section)
    assert sha(path) == before, f'Artifact changed during inspection: {path.name}'
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', type=Path, required=True)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    # Check complete artifact hashes against the build manifests before looking
    # at text; matching text alone does not prove a reproducible build.
    manifests = []
    for directory in (args.baseline, args.candidate):
        manifest = json.loads((directory / 'manifest.json').read_text())
        for name, expected in manifest['artifacts'].items():
            assert sha(directory / name) == expected, f'Artifact mismatch: {name}'
        manifests.append(manifest)
    rows = {}
    for name in sorted(manifests[0]['artifacts']):
        previous = text_sha(args.baseline / name)
        current = text_sha(args.candidate / name)
        rows[name] = dict(baseline=previous, candidate_build=current,
                          identical=previous == current)
    # Never overwrite an earlier audit, including a failed one.
    with args.output.open('x') as output:
        json.dump(rows, output, indent=2)
        output.write('\n')
    assert all(row['identical'] for row in rows.values()), 'Preserved text changed'
    print(f'{len(rows)} preserved codec text sections match; source artifacts untouched')


if __name__ == '__main__':
    main()
