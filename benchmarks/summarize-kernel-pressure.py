#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Export completed pressure comparisons without swap paths or machine identifiers."""
import argparse,json,shutil,statistics
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('input',type=Path);p.add_argument('output',type=Path);a=p.parse_args()
state=json.loads((a.input/'checkpoint.json').read_text());assert state['status']=='complete' and state['cleanup_verified']
assert not a.output.exists();a.output.mkdir(parents=True)
def conditions(snapshot):return {key:value for key,value in snapshot.items() if key.startswith('/sys/')}
rows=[]
for label,relative in sorted(state['completed'].items()):
 folder=a.input/relative;x=json.loads((folder/'result-private.json').read_text());assert x['status']=='passed'
 records=x['workload'];health=next(r for r in records if r.get('phase')=='cgroup_health');assert all(health['memory_events'].get(k,0)==0 for k in ['oom','oom_kill','oom_group_kill'])
 verify=[r for r in records if r.get('phase')=='verify'];assert len(verify)==3
 usage=[r for r in records if r.get('phase') in ['start','verified']]
 row={key:x[key] for key in ['algorithm','corpus','trial','elapsed_ns','package_energy_uj','energy_scope','vmstat_delta','fpu_processes','scope']}
 row.update(initial_fill_ns=next(r['elapsed_ns'] for r in records if r.get('phase')=='initial_fill'),verification=verify,cgroup_health=health,user_cpu_us=usage[-1]['user_us']-usage[0]['user_us'],system_cpu_us=usage[-1]['system_us']-usage[0]['system_us'],peak_rss_kib=usage[-1]['max_rss_kib'],zram_peak_allocated_bytes=int(x['after']['mm_stat'].split()[4]),before_conditions=conditions(x['before']),after_conditions=conditions(x['after']))
 if 'competing_application' in x:row['competing_application']=x['competing_application']
 if 'pressure_elapsed_ns' in x:row['pressure_elapsed_ns']=x['pressure_elapsed_ns']
 app_path=folder/'application.jsonl'
 if app_path.exists():
  app_records=[json.loads(line) for line in app_path.read_text().splitlines()];start=app_records[0]['started_ns']
  for record in app_records:
   for key in ['started_ns','begin_ns','end_ns','ended_ns']:
    if key in record:record[key]-=start
  (a.output/(label+'.application.jsonl')).write_text(''.join(json.dumps(r)+'\n' for r in app_records))
 rows.append(row);shutil.copyfile(folder/'workload.jsonl',a.output/(label+'.workload.jsonl'))
 telemetry=[]
 for line in (folder/'telemetry-private.jsonl').read_text().splitlines():
  sample=json.loads(line);telemetry.append({'elapsed_seconds':sample['time']-x['before']['time'],'conditions':conditions(sample),'zram_mm_stat':sample['mm_stat']})
 (a.output/(label+'.telemetry.json')).write_text(json.dumps(telemetry,indent=2)+'\n')
record={'inputs':state['inputs'],'scope':'Physical N100; controlled memcg reclaim, 768 MiB working set, 384 MiB resident ceiling, 320 MiB high threshold, 1 GiB swap ceiling, CPU0, dedicated 1 GiB logical ZRAM device with priority 200','verification':'every byte in three full permuted passes; four concurrent CPU/register helpers before every trial; no OOM','rows':rows,'attempt_counts':state['attempts']}
(a.output/'results.json').write_text(json.dumps(record,indent=2)+'\n')
lines=['# Native N100 controlled memory-pressure results','',record['scope']+'.','',record['verification']+'.','',
'Whole-workload time includes pattern generation, swap, byte comparison, service startup',
'and telemetry. Package energy also includes background activity. Page-compare latencies',
'include cache/resident pages and swap faults; they are not pure codec or swap-in timings.',
'This forces real reclaim on the installed 4 GiB target without exhausting the entire machine.',
'One trial is a harness smoke check, not a repeatability or optimization acceptance result.','',
'| Corpus | Algorithm | Trials | Median elapsed s | Median package J | Median system CPU s | Peak ZRAM MiB |',
'|---|---|---:|---:|---:|---:|---:|']
for corpus in sorted({r['corpus'] for r in rows}):
 for algorithm in sorted({r['algorithm'] for r in rows if r['corpus']==corpus}):
  group=[r for r in rows if r['corpus']==corpus and r['algorithm']==algorithm]
  med=lambda key:statistics.median(r[key] for r in group)
  energy=statistics.median(sum(r['package_energy_uj'].values())/1e6 for r in group)
  lines.append(f'| {corpus} | {algorithm} | {len(group)} | {med("elapsed_ns")/1e9:.3f} | {energy:.3f} | {med("system_cpu_us")/1e6:.3f} | {med("zram_peak_allocated_bytes")/2**20:.2f} |')
if any('competing_application' in r for r in rows):
 lines+=['','## Competing SHA256 workload','','Pinned to CPU0 outside the pressure memcg; fixed 1 MiB hashes, 16 per batch.', 'Only batches fully inside the pressure launcher window contribute throughput.', 'This is a controlled CPU-contention probe, not interactive responsiveness.', 'Package energy covers both workloads, startup and background activity.','', '| Corpus | Algorithm | Trial | Application MiB/s | Median 16-hash batch ms | Overlapping batches |', '|---|---|---:|---:|---:|---:|']
 for r in rows:
  if 'competing_application' not in r:continue
  app=r['competing_application'];rate=app['completed_batch_bytes']/2**20/(app['overlap_window_ns']/1e9)
  lines.append(f"| {r['corpus']} | {r['algorithm']} | {r['trial']} | {rate:.3f} | {statistics.median(app['batch_elapsed_ns'])/1e6:.3f} | {app['fully_contained_batches']} |")
if any(r.get('competing_application',{}).get('fixed_window_ns') for r in rows):
 lines+=['','## Fixed application observation window','','The competing process continues after pressure finishes, through the same fixed window.', 'Total elapsed/energy above includes that window. Pressure completion is separate below.', 'This captures post-pressure CPU availability; scheduler weights and clocks still matter.', '', '| Corpus | Algorithm | Trial | Pressure completion s | Fixed window s | Application MiB/s across window |', '|---|---|---:|---:|---:|---:|']
 for r in rows:
  app=r.get('competing_application',{})
  if not app.get('fixed_window_ns'):continue
  rate=app['window_completed_batch_bytes']/2**20/(app['fixed_window_ns']/1e9)
  lines.append(f"| {r['corpus']} | {r['algorithm']} | {r['trial']} | {r['pressure_elapsed_ns']/1e9:.3f} | {app['fixed_window_ns']/1e9:.1f} | {rate:.3f} |")
(a.output/'summary.md').write_text('\n'.join(lines)+'\n');print('\n'.join(lines[-len(rows)-3:]))
