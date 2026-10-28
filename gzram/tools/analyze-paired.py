#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Retain every direct policy/block contrast in a completed native cohort."""
import argparse
import csv
import json
import math
import statistics
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--controls', nargs='+', default=['guard32'],
                        help='Hybrid policies to use as matched direct controls')
    args = parser.parse_args()
    checkpoint = args.input / 'checkpoint.json'
    if checkpoint.exists():
        state = json.loads(checkpoint.read_text())
        assert state['status'] == 'complete'
        inputs = state['inputs']
    else:
        # Published cohorts retain sanitized inputs and completion metadata.
        state = json.loads((args.input / 'metadata.json').read_text())
        inputs = state
    assert set(state['completed']) == {'validation', 'session-0', 'session-1', 'session-2'}
    variants = set(inputs['variant_names'])
    corpora = set(inputs['corpora'])
    groups = {}
    for session in range(3):
        seen = set()
        for row in csv.DictReader((args.input / f'session-{session}.csv').open()):
            key = (row['corpus'], row['variant'], row['operation'], int(row['round']))
            assert key not in seen
            seen.add(key)
            assert row['corpus'] in corpora and row['variant'] in variants
            assert row['operation'] in ('compress', 'decompress')
            for metric in ('ns_per_page', 'compressed_bytes', 'package_uj_per_page'):
                assert math.isfinite(float(row[metric]))
            groups.setdefault(key[:3], {})[(session, key[3])] = row
        assert len(seen) == len(variants) * len(corpora) * 18
    expected = {(s, r) for s in range(3) for r in range(9)}
    assert all(set(rows) == expected for rows in groups.values())
    cpu_present = ['cpu_ns_per_page' in row for rows in groups.values() for row in rows.values()]
    assert all(cpu_present) or not any(cpu_present), 'Mixed CPU accounting schemas'
    metrics = ['ns_per_page', 'compressed_bytes', 'package_uj_per_page']
    if all(cpu_present):
        metrics.append('cpu_ns_per_page')
        assert all(math.isfinite(float(row['cpu_ns_per_page'])) and float(row['cpu_ns_per_page']) > 0
                   for rows in groups.values() for row in rows.values())
    pmu_metrics = ('cycles', 'instructions', 'branch_misses', 'cache_misses')
    for metric in pmu_metrics:
        present = [metric in row for rows in groups.values() for row in rows.values()]
        assert all(present) or not any(present), f'Mixed {metric} schemas'
        if all(present):
            metrics.append(metric)
            assert all(math.isfinite(float(row[metric])) for rows in groups.values() for row in rows.values())
    contrasts = set()
    for variant in variants:
        if not variant.startswith('ghy-'):
            continue
        _, policy, isa, size = variant.split('-')
        for control_policy in args.controls:
            control = f'ghy-{control_policy}-{isa}-{size}'
            if control in variants and variant != control:
                contrasts.add((variant, control, 'policy'))
        if isa == 'avx2':
            control = f'ghy-{policy}-scalar-{size}'
            if control in variants:
                contrasts.add((variant, control, 'ISA'))
        control = variant.rsplit('-', 1)[0] + '-1024'
        if control in variants and variant != control:
            contrasts.add((variant, control, 'block size'))
    results = []
    for candidate, control, kind in sorted(contrasts):
        for corpus in sorted(corpora):
            for operation in ('compress', 'decompress'):
                selected = groups[corpus, candidate, operation]
                baseline = groups[corpus, control, operation]
                effects = {}
                for metric in metrics:
                    if metric in pmu_metrics and any(float(rows[k].get('pmu_running_fraction', -1)) < .99
                                                    for rows in (baseline, selected) for k in expected):
                        effects[metric] = None
                        continue
                    if any(float(baseline[k][metric]) <= 0 or float(selected[k][metric]) < 0 for k in expected):
                        effects[metric] = None
                        continue
                    sessions = [100 * (statistics.median(float(selected[s, r][metric]) /
                                float(baseline[s, r][metric]) for r in range(9)) - 1)
                                for s in range(3)]
                    effects[metric] = {'median_change_percent': statistics.median(sessions),
                                       'session_changes_percent': sessions,
                                       'candidate_median': statistics.median(float(selected[k][metric]) for k in expected),
                                       'control_median': statistics.median(float(baseline[k][metric]) for k in expected)}
                results.append(dict(candidate=candidate, control=control, kind=kind,
                                    corpus=corpus, operation=operation, effects=effects))
    assert not args.output.exists()
    args.output.mkdir(parents=True)
    scope = ('Physical N100 warm-cache userspace screening. Nine paired rounds per session; '
             'median of three session changes. Session ranges are descriptive, not confidence '
             'intervals. Negative changes mean less time/space/energy. Comparisons across block '
             'sizes can change encoding choices and ratios. PMU effects in JSON require fully '
             'scheduled user-only groups. No policy or kernel gain accepted.')
    (args.output / 'paired.json').write_text(json.dumps(dict(scope=scope, rows=results), indent=2) + '\n')
    lines = ['# Direct GZRAM policy and block comparisons', '', scope, '',
             '| Corpus | Operation | Candidate | Control | Time change, % (session range) | Bytes change, % | Package energy change, % |',
             '|---|---|---|---|---:|---:|---:|']
    if 'cpu_ns_per_page' in metrics:
        lines[-2] += ' Thread CPU time change, % |'
        lines[-1] += '---:|'
    for row in results:
        values = row['effects']
        timing = values['ns_per_page']
        changes = timing['session_changes_percent']
        def value(metric):
            effect = values[metric]
            return 'unavailable' if effect is None else f"{effect['median_change_percent']:+.2f}"
        lines.append(f"| {row['corpus']} | {row['operation']} | {row['candidate']} | {row['control']} | "
                     f"{value('ns_per_page')} ({min(changes):+.2f}..{max(changes):+.2f}) | "
                     f"{value('compressed_bytes')} | {value('package_uj_per_page')} |")
        if 'cpu_ns_per_page' in metrics:
            lines[-1] += f" {value('cpu_ns_per_page')} |"
    (args.output / 'paired.md').write_text('\n'.join(lines) + '\n')
    print(f'{len(results)} direct comparisons retained in {args.output}')


if __name__ == '__main__':
    main()
