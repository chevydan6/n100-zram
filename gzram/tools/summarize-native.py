#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Export all new-format trials; do not select favorable block sizes or omit regressions."""
import argparse,csv,json,math,random,shutil,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
state=json.loads((a.input/'checkpoint.json').read_text());assert state['status']=='complete' and set(state['completed'])=={'validation','session-0','session-1','session-2'}
assert not a.output.exists();a.output.mkdir(parents=True);rows=[]
for session in ['session-0','session-1','session-2']:
 path=a.input/(session+'.csv');data=list(csv.DictReader(path.open()));assert len(data)==2754 and len({(r['corpus'],r['round'],r['variant'],r['operation']) for r in data})==2754
 for r in data:
  assert all(math.isfinite(float(r[k])) for k in ['ns_per_page','compressed_bytes','cycles','instructions','package_uj_per_page']);r['session']=session;rows.append(r)
 shutil.copy2(path,a.output/path.name)
metadata=dict(state['inputs']);metadata['completed']=state['completed']
for key in ['before','after']:metadata[key]={k:v for k,v in state[key].items() if k!='time'}
metadata['all_pmu_batches_fully_scheduled']=all(float(r['pmu_running_fraction'])>=.99 for r in rows)
metadata['package_energy_available_all_rows']=all(float(r['package_uj_per_page'])>=0 for r in rows)
(a.output/'metadata.json').write_text(json.dumps(metadata,indent=2)+'\n');shutil.copy2(a.input/'validation.log',a.output/'validation.log')
samples=[json.loads(s) for s in (a.input/'telemetry.jsonl').read_text().splitlines()]
if samples:
 start=samples[0]['time']
 for row in samples:row['elapsed_seconds']=round(row.pop('time')-start,3)
(a.output/'telemetry.jsonl').write_text(''.join(json.dumps(s)+'\n' for s in samples))
lines=['# GZRAM-AVX2 first native userspace comparison','',state['inputs']['scope']+'.',
'Three sessions, nine randomized recorded rounds, two warm-ups, 128 pages/corpus,',
'32,768 calls per batch. All sixteen format/block-size variants and scalar LZ4',
'are retained, including losses. No preferred compressor or block size is selected.',
'',
'Package energy is direct RAPL over each complete batch, including counter/timer',
'bookkeeping and background activity. It is not whole-laptop energy. PMU values',
'are user-only; missing data is -1 and unscheduled counters must not be interpreted.',
'Validation and format comparisons run outside timing. All compressed pages are',
'checked after timed encoding; setup round trips every page and decoding checks',
'the final output after each batch. This is warm-cache screening, not swap latency.',
'',
'GZRAM includes its eight-byte raw framing; kernel ZRAM would normally handle',
'incompressible pages itself. Zero pages are normally elided by kernel ZRAM.',
'Scalar GZRAM is a format reference, not the existing optimized scalar LZ4.',
'New-codec ratio regressions and kernel FPU overhead may disqualify userspace wins.',
'',
'Intervals bootstrap the three session median paired-round ratios (10,000 seeded',
'draws). They describe this small experiment, not independent workload confidence',
'or acceptance after multiple comparisons. No established N100 kernel gain is claimed.',
'',
'| Corpus | Variant | Bytes/page | Compress ns [change vs LZ4, 95% session interval] | Decode ns [change, interval] | Package uJ/page comp / dec |',
'|---|---|---:|---:|---:|---:|'];rng=random.Random(100)
variants=['lz4-small-scalar']+[f'gz-{isa}-{1<<log}' for isa in ['scalar','avx2'] for log in range(5,13)]
for corpus in sorted({r['corpus'] for r in rows}):
 for variant in variants:
  group=[r for r in rows if r['corpus']==corpus and r['variant']==variant];cells=[];energies=[]
  for op in ['compress','decompress']:
   selected=[r for r in group if r['operation']==op];base={(r['session'],r['round']):float(r['ns_per_page']) for r in rows if r['corpus']==corpus and r['variant']=='lz4-small-scalar' and r['operation']==op}
   ratios=[statistics.median(float(r['ns_per_page'])/base[(session,r['round'])] for r in selected if r['session']==session) for session in ['session-0','session-1','session-2']]
   draws=sorted(100*(statistics.median(rng.choices(ratios,k=3))-1) for _ in range(10000));cells.append(f"{statistics.median(float(r['ns_per_page']) for r in selected):.1f} [{100*(statistics.median(ratios)-1):+.1f}% {draws[250]:+.1f}..{draws[9749]:+.1f}]")
   energies.append(f"{statistics.median(float(r['package_uj_per_page']) for r in selected):.3f}" if all(float(r['package_uj_per_page'])>=0 for r in selected) else 'NA')
  lines.append(f"| {corpus} | {variant} | {statistics.median(float(r['compressed_bytes']) for r in group):.1f} | {' | '.join(cells)} | {' / '.join(energies)} |")
(a.output/'summary.md').write_text('\n'.join(lines)+'\n');print(a.output/'summary.md')
