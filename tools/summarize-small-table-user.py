#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Export all smaller-table native batches with size tradeoffs and regressions."""
import argparse,csv,json,random,shutil,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
s=json.loads((a.input/'checkpoint.json').read_text());assert s['status']=='complete' and len(s['completed'])==3
assert not a.output.exists();a.output.mkdir(parents=True);rows=[]
for session in s['completed']:
 path=a.input/(session+'.csv');data=list(csv.DictReader(path.open()));assert len(data)==2688 and len({(r['corpus'],r['round'],r['variant'],r['operation']) for r in data})==2688
 for r in data:r['session']=session;rows.append(r)
 shutil.copy2(path,a.output/path.name)
meta={k:s[k] for k in ['scope','kernel','binary_sha256','libraries','bash_sha256','completed']}
for name in ['before','after']:meta[name]={k:v for k,v in s[name].items() if k!='time'}
(a.output/'metadata.json').write_text(json.dumps(meta,indent=2)+'\n');shutil.copy2(a.input/'validation.log',a.output/'validation.log')
samples=[json.loads(line) for line in (a.input/'telemetry.jsonl').read_text().splitlines()]
if samples:
 start=samples[0]['time']
 for row in samples:row['elapsed_seconds']=round(row.pop('time')-start,3)
(a.output/'telemetry.jsonl').write_text(''.join(json.dumps(row)+'\n' for row in samples))
lines=['# Physical N100 smaller-table screening','',s['scope']+'.',
'Three sessions; 21 recorded rounds and two warm-ups; 128 pages/corpus and 8,192 calls/batch.',
'CPU 0, CPUID/XGETBV checked. Every compression batch checked all 128 packed buffers',
'outside timing; setup independently decoded every candidate block with the baseline decoder.',
'Guarded capacity and independent liblz4 concurrency tests passed before native execution.',
'',
'Compression ratios may change: all measured bytes/page are retained. The decoder remains baseline.',
'Controls are full baseline scalar/AVX2-guard APIs; candidates have a specialized 4 KiB private API.',
'API/code-generation differences are a confounder. Matched table14 private controls are required',
'before attributing gains exclusively to table size. No kernel integration or ZRAM gain is established.',
'Energy and responsiveness were not measured. User-space cycles exclude kernel and hypervisor.',
'',
'Change intervals bootstrap the three session median paired round ratios (10,000 seeded draws).',
'These small-sample intervals describe repeatability, not general workload confidence.',
'',
'| Corpus | Variant | Compress ns/page | Change [95% session bootstrap] | Bytes/page | Size change | Cycles/page |',
'|---|---|---:|---:|---:|---:|---:|']
rng=random.Random(100)
for corpus in sorted({r['corpus'] for r in rows}):
 for variant in ['scalar','table13-scalar','table12-scalar','table11-scalar','avx2-guard','table13-avx2','table12-avx2','table11-avx2']:
  group=[r for r in rows if r['corpus']==corpus and r['variant']==variant and r['operation']=='compress']
  control='avx2-guard' if 'avx2' in variant else 'scalar';ratios=[]
  controls=[r for r in rows if r['corpus']==corpus and r['variant']==control and r['operation']=='compress']
  for session in s['completed']:
   base={r['round']:float(r['ns_per_page']) for r in controls if r['session']==session}
   ratios.append(statistics.median(float(r['ns_per_page'])/base[r['round']] for r in group if r['session']==session))
  boot=sorted(100*(statistics.median(rng.choices(ratios,k=3))-1) for _ in range(10000))
  size=statistics.median(float(r['compressed_bytes_per_page']) for r in group);base_size=statistics.median(float(r['compressed_bytes_per_page']) for r in controls)
  lines.append(f"| {corpus} | {variant} | {statistics.median(float(r['ns_per_page']) for r in group):.1f} | {100*(statistics.median(ratios)-1):+.1f}% [{boot[250]:+.1f}, {boot[9749]:+.1f}] | {size:.1f} | {100*(size/base_size-1):+.2f}% | {statistics.median(float(r['user_core_cycles_per_page']) for r in group):.1f} |")
(a.output/'summary.md').write_text('\n'.join(lines)+'\n');print(a.output/'summary.md')
