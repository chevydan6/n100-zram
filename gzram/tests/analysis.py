#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Known-ratio fixtures for legacy/current CPU schemas and unavailable PMUs."""
import csv
import json
import subprocess
import sys
import tempfile
from pathlib import Path

root = Path(__file__).resolve().parents[2]
for cpu, scheduled in [(False, True), (True, True), (True, False)]:
    with tempfile.TemporaryDirectory(prefix='gzram-analysis-') as directory:
        directory = Path(directory)
        data = directory / 'input'
        data.mkdir()
        names = ['lz4-small-scalar', 'ghy-wordmixed-scalar-1024', 'ghy-outlinetail-scalar-1024']
        fields = ['corpus', 'round', 'variant', 'operation', 'ns_per_page', 'compressed_bytes',
                  'cycles', 'instructions', 'branch_misses', 'cache_misses',
                  'package_uj_per_page', 'pmu_running_fraction']
        if cpu:
            fields += ['cpu_ns_per_page', 'cpu_utilization_percent']
        for session in range(3):
            with (data / f'session-{session}.csv').open('w') as output:
                writer = csv.DictWriter(output, fieldnames=fields, lineterminator='\n')
                writer.writeheader()
                for round_index in range(9):
                    for index, name in enumerate(names):
                        for operation in ['compress', 'decompress']:
                            row = dict(corpus='synthetic-unit-fixture', round=round_index, variant=name,
                                       operation=operation, ns_per_page=[120, 100, 80][index],
                                       compressed_bytes=500, cycles=[120, 100, 80][index],
                                       instructions=100, branch_misses=[10, 10, 2][index],
                                       cache_misses=[2, 2, 1][index], package_uj_per_page=-1,
                                       pmu_running_fraction=1 if scheduled else .5)
                            if cpu:
                                row.update(cpu_ns_per_page=[110, 90, 81][index],
                                           cpu_utilization_percent=[110 / 120 * 100, 90, 81 / 80 * 100][index])
                            writer.writerow(row)
        inputs = dict(manifest={}, variant_names=names, corpora=['synthetic-unit-fixture'],
                      scope='Synthetic unit fixture only; no hardware measurements')
        if cpu:
            inputs['calls_per_batch'] = 8192
        state = dict(status='complete', completed=['validation', 'session-0', 'session-1', 'session-2'],
                     inputs=inputs, before=dict(time=0), after=dict(time=1))
        (data / 'checkpoint.json').write_text(json.dumps(state))
        (data / 'validation.log').write_text('Synthetic fixture\n')
        (data / 'telemetry.jsonl').write_text('{"time":0}\n{"time":1}\n')
        subprocess.run([sys.executable, str(root / 'gzram/tools/analyze-paired.py'),
                        '--input', str(data), '--output', str(directory / 'paired'),
                        '--controls', 'wordmixed'], check=True, capture_output=True)
        report = json.loads((directory / 'paired/paired.json').read_text())
        assert len(report['rows']) == 2
        for row in report['rows']:
            effects = row['effects']
            timing = effects['ns_per_page']
            assert abs(timing['median_change_percent'] + 20) < 1e-10
            assert timing['candidate_median'] == 80 and timing['control_median'] == 100
            assert effects['package_uj_per_page'] is None
            if cpu:
                assert abs(effects['cpu_ns_per_page']['median_change_percent'] + 10) < 1e-10
            else:
                assert 'cpu_ns_per_page' not in effects
            if scheduled:
                assert abs(effects['cycles']['median_change_percent'] + 20) < 1e-10
                assert abs(effects['branch_misses']['median_change_percent'] + 80) < 1e-10
            else:
                assert all(effects[name] is None for name in ['cycles', 'instructions', 'branch_misses', 'cache_misses'])
        subprocess.run([sys.executable, str(root / 'gzram/tools/summarize-native.py'),
                        '--input', str(data), '--output', str(directory / 'summary')],
                       check=True, capture_output=True)
        summary = (directory / 'summary/summary.md').read_text()
        assert ('Thread occupancy' in summary) == cpu
        assert ('8,192 calls' if cpu else '32,768 calls') in summary
        print(f'Passed analysis fixture: cpu={cpu}, fully_scheduled={scheduled}')
