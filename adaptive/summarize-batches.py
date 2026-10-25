#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Export exact kernel component rows, including FPU controls and losing paths."""
import argparse,csv,json,random,shutil,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--input',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
s=json.loads((a.input/'checkpoint.json').read_text());assert s['status']=='complete' and s['probe_unloaded'] is True and len(s['completed'])==15 and s['batches']==[1,2,4,8,16] and s['page_only']
assert not a.output.exists();a.output.mkdir(parents=True);rows=[]
for session in s['completed']:
 path=a.input/(session+'.csv');data=list(csv.DictReader(path.open()));assert len(data)==360 and len({(r['bytes'],r['operation'],r['pattern'],r['round'],r['state'],r['variant']) for r in data})==360
 for r in data:r['session']=session;rows.append(r)
 shutil.copy2(path,a.output/path.name)
meta={k:s[k] for k in ['kernel','module_sha256','helper_sha256','scope','completed','probe_unloaded','batches','page_only','fpu_bracketing','normal_zram_unchanged','cpu_model','runner_sha256']}
for name in ['before','after']:meta[name]={k:v for k,v in s[name].items() if k!='time'}
meta['all_pmu_groups_fully_scheduled']=all(float(r['pmu_running_fraction'])>=.99 for r in rows)
meta['package_energy_all_rows_measured']=all(float(r['package_uj_per_call'])>=0 for r in rows)
(a.output/'metadata.json').write_text(json.dumps(meta,indent=2)+'\n');shutil.copy2(a.input/'validation.log',a.output/'validation.log')
samples=[json.loads(x) for x in (a.input/'telemetry.jsonl').read_text().splitlines()]
if samples:
 start=samples[0]['time']
 for r in samples:r['elapsed_seconds']=round(r.pop('time')-start,3)
(a.output/'telemetry.jsonl').write_text(''.join(json.dumps(r)+'\n' for r in samples))
lines=['# Physical N100 independent-operation SIMD amortization experiment','',s['scope']+'.',
'Three sessions per operation count; five shuffled recorded rounds plus one warm-up; 2,048 ioctl calls per timing batch.',
'Independent 4 KiB operations, counts 1/2/4/8/16; six operation/pattern configurations and three caller-state fixtures.',
'All sixteen YMM sentinels checked before every batch; kernel verification and canaries',
'checked after each batch; nested kernel-FPU sections selected scalar fallback.',
'Probe unloaded successfully. No ZRAM compressor or boot default was replaced.',
'',
'Lengths beyond 4096 bytes are diagnostics, not changes to MM page size or proof',
'of viable ZRAM batching. These primitives exclude hash search and format parsing.',
'Per-operation times divide the complete ioctl time by independent-operation count. Each ioctl enters the FPU context once, not once per page. Times include syscall, mutex, dispatch, checks/loop and state handling; FPU-scalar',
'uses the same scalar body and charges context-management overhead. Requested',
'clean/SSE-dirty/YMM-dirty states do not model every application xstate history.',
'PMU counts include user and kernel; RAPL includes batch bookkeeping/background.',
'Missing values remain -1; scheduling fraction is retained for rejecting multiplexing.',
'',
'Intervals bootstrap three session median paired-round ratios (10,000 seeded draws).',
'These are descriptive small-sample intervals, not a universal crossover guarantee.',
'',
'| Operations/ioctl | Bytes/operation | Operation | Pattern | Caller state | Scalar / FPU-scalar / SSE / AVX2 ns per operation | SSE change [95% session interval] | AVX2 change [interval] | Matched FPU-scalar delta ns/ioctl |',
'|---:|---:|---|---|---|---:|---:|---:|---:|'];rng=random.Random(100);analysis=[]
keys=sorted({(int(r['batch']),int(r['bytes']),r['operation'],r['pattern'],r['state']) for r in rows})
for batch,length,op,pattern,state in keys:
 g=[r for r in rows if int(r['batch'])==batch and int(r['bytes'])==length and r['operation']==op and r['pattern']==pattern and r['state']==state]
 med={v:statistics.median(float(r['ns_per_call']) for r in g if r['variant']==v) for v in ['scalar','fpu-scalar','sse','avx2']}
 lookup={(r['session'],r['round'],r['variant']):float(r['ns_per_call']) for r in g};effects={};cells=[]
 for variant in ['sse','avx2']:
  ratios=[statistics.median(lookup[(session,str(round),variant)]/lookup[(session,str(round),'scalar')] for round in range(5)) for session in sorted({r['session'] for r in g})]
  draws=sorted(100*(statistics.median(rng.choices(ratios,k=3))-1) for _ in range(10000));effects[variant]={'median_paired_percent':100*(statistics.median(ratios)-1),'bootstrap_95_percent':[draws[250],draws[9749]],'every_session_beats_scalar_by_2_percent':all(r<.98 for r in ratios)}
  cells.append(f"{effects[variant]['median_paired_percent']:+.1f}% [{draws[250]:+.1f}, {draws[9749]:+.1f}]")
 delta=statistics.median(lookup[(session,str(round),'fpu-scalar')]-lookup[(session,str(round),'scalar')] for session in sorted({r['session'] for r in g}) for round in range(5))
 analysis.append({'batch':batch,'matched_fpu_control_delta_ns_per_ioctl':delta,'medians_ns_per_independent_operation':{v:med[v]/batch for v in med},'bytes':length,'operation':op,'pattern':pattern,'state':state,'medians_ns':med,'effects_vs_scalar':effects})
 lines.append(f"| {batch} | {length} | {op} | {pattern} | {state} | "+' / '.join(f'{med[v]/batch:.1f}' for v in ['scalar','fpu-scalar','sse','avx2'])+' | '+' | '.join(cells)+f' | {delta:.1f} |')
(a.output/'analysis.json').write_text(json.dumps({'scope':s['scope'],'rows':analysis,'kernel_hybrid_selected':False},indent=2)+'\n');(a.output/'summary.md').write_text('\n'.join(lines)+'\n');print(a.output/'summary.md')
