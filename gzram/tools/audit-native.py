#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Audit completed local cohorts without changing or selecting their measurements."""
import argparse
import csv
import hashlib
import json
import statistics
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--input', type=Path, required=True)
p.add_argument('--directory', type=Path, required=True)
p.add_argument('--preflight', type=Path, required=True)
p.add_argument('--output', type=Path, required=True)
a = p.parse_args()
assert not a.output.exists()
state = json.loads((a.input / 'checkpoint.json').read_text())
assert state['status'] == 'complete'
assert set(state['completed']) == {'validation', 'session-0', 'session-1', 'session-2'}
inputs = state['inputs']
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
assert sha(a.directory / 'benchmark') == inputs['binary_sha256']
for name, digest in inputs['libraries'].items():
    assert sha(a.directory / name) == digest == inputs['manifest']['artifacts'][name]
rows = []
for session in range(3):
    data = list(csv.DictReader((a.input / f'session-{session}.csv').open()))
    keys = {(r['corpus'], r['variant'], r['operation'], int(r['round'])) for r in data}
    expected = {(corpus, variant, operation, index) for corpus in inputs['corpora']
                for variant in inputs['variant_names'] for operation in ('compress', 'decompress')
                for index in range(9)}
    assert keys == expected and len(data) == len(expected)
    rows.extend(data)
samples = [json.loads(line) for line in (a.input / 'telemetry.jsonl').read_text().splitlines()]
assert len(samples) > 1
gaps = [b['time'] - a['time'] for a, b in zip(samples, samples[1:])]
assert min(gaps) > 0 and max(gaps) < 10, 'Discontinuous telemetry; retain but do not accept this cohort'
assert samples[0]['time'] - state['started'] < 10
assert state['finished'] - samples[-1]['time'] < 10
settings = {}
ranges = {}
for key in sorted(set().union(*(sample.keys() for sample in samples))):
    values = [sample[key] for sample in samples if key in sample]
    if key.endswith(('scaling_governor', 'scaling_min_freq', 'scaling_max_freq', '/status', '/online')):
        settings[key] = sorted(set(values))
    elif key.endswith(('scaling_cur_freq', '/temp', '/current_now', '/voltage_now', '/charge_now')):
        numbers = [int(value) for value in values]
        ranges[key] = dict(min=min(numbers), median=statistics.median(numbers), max=max(numbers), samples=len(numbers))
preflight = json.loads(a.preflight.read_text())
restoration = {}
for name, original in preflight['files'].items():
    if '/power_supply/' in name:
        continue  # Charge/status are context, not a setting we restore.
    path = Path(name)
    restoration[name] = dict(before_sha256=original['sha256'], after_sha256=sha(path))
    assert restoration[name]['before_sha256'] == restoration[name]['after_sha256'], name
battery_energy = None
current = '/sys/class/power_supply/BAT0/current_now'
voltage = '/sys/class/power_supply/BAT0/voltage_now'
status = '/sys/class/power_supply/BAT0/status'
if all(s.get(status) == 'Discharging' and current in s and voltage in s for s in samples):
    power = [abs(int(s[current])) * int(s[voltage]) / 1e12 for s in samples]
    battery_energy = sum((power[i] + power[i+1]) * gap / 2 for i, gap in enumerate(gaps))
result = dict(
    status='passed', timing_rows=len(rows), sessions=3, telemetry_samples=len(samples),
    maximum_telemetry_gap_seconds=max(gaps), elapsed_seconds=state['finished']-state['started'],
    artifacts_match=True, preserved_settings_and_zram=restoration, observed_settings=settings,
    observed_ranges=ranges,
    pmu_running_fraction_range=[min(float(r['pmu_running_fraction']) for r in rows), max(float(r['pmu_running_fraction']) for r in rows)],
    package_energy_available_rows=sum(float(r['package_uj_per_page']) >= 0 for r in rows),
    thread_occupancy_percent_range=[min(float(r['cpu_utilization_percent']) for r in rows), max(float(r['cpu_utilization_percent']) for r in rows)],
    thread_occupancy_percent_median=statistics.median(float(r['cpu_utilization_percent']) for r in rows),
    approximate_battery_energy_joules=battery_energy,
    battery_scope='Trapezoidal integration of sampled battery current times voltage across the entire experiment, including validation, warmups, telemetry and other laptop activity. Battery gauge precision/lag not calibrated. Not assignable to individual codecs; not RAPL or a comparative energy result.',
    kernel_scope='Userspace only. Observed unchanged ZRAM module/algorithm/size and CPU policy; no claim of current-kernel recovery validation or application responsiveness.'
)
a.output.write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps({key: result[key] for key in ('status', 'timing_rows', 'maximum_telemetry_gap_seconds', 'package_energy_available_rows', 'elapsed_seconds')}))
