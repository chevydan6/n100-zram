#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Summarize every size-only variant, retaining expansion and fallback costs."""
import argparse
import csv
import json
import statistics
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    args = parser.parse_args()
    metadata = json.loads((args.input / 'metadata.json').read_text())
    variants = metadata['variant_names']
    corpora = list(metadata['corpus_sha256'])
    groups = {}
    for row in csv.DictReader((args.input / 'sizes.csv').open()):
        key = row['corpus'], row['variant']
        assert key[0] in corpora and key[1] in variants
        group = groups.setdefault(key, {})
        page = int(row['page'])
        assert page not in group
        group[page] = int(row['compressed_bytes'])
    assert len(groups) == len(corpora) * len(variants)
    assert all(set(group) == set(range(metadata['pages_per_corpus'])) for group in groups.values())
    equivalent = [policy for policy in ('outlinetail', 'ctzunpack', 'wordrepeat', 'ctzrepeat', 'bitpack', 'mixpack',
                                       'ctzfull', 'bitctz', 'bitfull', 'select2', 'select3', 'select4')
                  if f'ghy-{policy}-scalar-1024' in variants]
    for corpus in corpora:
        for policy in equivalent:
            for isa in ('scalar', 'avx2'):
                for block in (1024, 4096):
                    assert groups[corpus, f'ghy-{policy}-{isa}-{block}'] == groups[corpus, f'ghy-wordmixed-{isa}-{block}']
        if 'ghy-repeatmergefast-scalar-1024' in variants:
            for isa in ('scalar', 'avx2'):
                for block in (1024, 4096):
                    assert groups[corpus, f'ghy-repeatmergefast-{isa}-{block}'] == groups[corpus, f'ghy-repeatmerge-{isa}-{block}']
    lines = ['# GZRAM candidate size-only checkpoint', '', metadata['scope'] + '.', '',
             f'{len(variants)} variants, {len(corpora)} corpora, 128 pages per corpus. '
             'One deterministic encoding per page; these are not repeated timing samples.',
             'Every frame was decoded by the independent Python wire decoder or system liblz4.',
             'These variants have exactly the same per-page sizes as wordmixed at both screened',
             'block sizes and ISAs: ' + ', '.join(equivalent) + '.',
             'Other policies may change sizes; every result is retained. No speed or energy claim follows.', '',
             'The existing twelve inputs are preserved; words25/50/75 vary nonzero-word density',
             'and mixed-pages interleaves executable, sparse, random and periodic-prefix pages.',
             'When present, clusters25/50/75 place random full 32-byte groups among zero groups;',
             'these test spatial clustering separately from random per-word density.',
             'All bytes include the codec framing. ZRAM zero/same-page bypass, allocator rounding',
             'and raw-page handling are excluded. No whole-system memory saving is inferred.', '',
             '| Corpus | Variant | Mean bytes | Min..max bytes | Size change vs LZ4 |',
             '|---|---|---:|---:|---:|']
    for corpus in corpora:
        baseline = statistics.mean(groups[corpus, 'lz4-small-scalar'].values())
        for variant in variants:
            values = groups[corpus, variant].values()
            mean = statistics.mean(values)
            lines.append(f'| {corpus} | {variant} | {mean:.3f} | {min(values)}..{max(values)} | {100*(mean/baseline-1):+.2f}% |')
    with (args.input / 'summary.md').open('x') as output:
        output.write('\n'.join(lines) + '\n')
    print(f'{len(groups)} complete groups; candidate/control size equality verified')


if __name__ == '__main__':
    main()
