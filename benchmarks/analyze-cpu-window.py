#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Paired pressure/application/energy analysis for a fixed observation window."""
import argparse,json,random,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();assert not a.output.exists()
d=json.loads((a.input/'results.json').read_text());rows=d['rows'];assert rows and all(r.get('competing_application',{}).get('fixed_window_ns') for r in rows)
windows={r['competing_application']['fixed_window_ns'] for r in rows};assert len(windows)==1
rng=random.Random(100);output=[];lines=['# Fixed-window scalar CPU-availability comparison','','Five paired trials per corpus/backend; bootstrap median trial ratios 10,000 times.', 'Lower pressure completion/energy is favorable; higher application throughput is favorable.', 'Energy covers the fixed application observation, both workloads and startup/background.', 'This is controlled CPU contention, not interactive responsiveness or whole-laptop energy.', 'All trials and frequency/background variation are retained. No general application gain is selected.', '', '| Corpus | Metric | 8 KiB vs 16 KiB change [95% paired bootstrap] |', '|---|---|---:|']
for corpus in sorted({r['corpus'] for r in rows}):
 b={r['trial']:r for r in rows if r['corpus']==corpus and r['algorithm']=='lz4-control'};c={r['trial']:r for r in rows if r['corpus']==corpus and r['algorithm']=='lz4-mid'};assert set(b)==set(c)==set(range(5))
 for name,fn in [('pressure completion',lambda r:r['pressure_elapsed_ns']),('application throughput',lambda r:r['competing_application']['window_completed_batch_bytes']/r['competing_application']['fixed_window_ns']),('package energy',lambda r:sum(r['package_energy_uj'].values()))]:
  ratios=[fn(c[i])/fn(b[i]) for i in range(5)];draws=sorted(100*(statistics.median(rng.choices(ratios,k=5))-1) for _ in range(10000));change=100*(statistics.median(ratios)-1);interval=[draws[250],draws[9749]]
  output.append({'corpus':corpus,'metric':name,'paired_change_percent':change,'bootstrap_95_percent':interval,'baseline_median':statistics.median(fn(r) for r in b.values()),'candidate_median':statistics.median(fn(r) for r in c.values())})
  lines.append(f'| {corpus} | {name} | {change:+.2f}% [{interval[0]:+.2f}, {interval[1]:+.2f}] |')
lines+=['','Application-throughput intervals span zero on these corpora; a repeatable CPU-capacity gain is not established.', 'This does not negate the measured pressure completion changes; it limits what they demonstrate.']
a.output.mkdir(parents=True);(a.output/'analysis.json').write_text(json.dumps({'scope':'physical N100 fixed-window CPU contention','window_ns':next(iter(windows)),'rows':output},indent=2)+'\n');(a.output/'analysis.md').write_text('\n'.join(lines)+'\n');print(a.output/'analysis.md')
