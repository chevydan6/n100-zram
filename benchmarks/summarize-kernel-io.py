#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Export synthetic-device metrics, excluding host IDs, swap paths and raw perf data."""
from pathlib import Path
import argparse,json,re,statistics
p=argparse.ArgumentParser();p.add_argument('input',type=Path);p.add_argument('output',type=Path);a=p.parse_args();a.output.mkdir(parents=True,exist_ok=True)
env=json.loads((a.input/'environment-private.json').read_text());checkpoint=json.loads((a.input/'checkpoint.json').read_text())
assert checkpoint['status']=='complete'
rows=[];profiles={}
for path in sorted(a.input.glob('*-rand*.metrics.json')):
 label=path.name.removesuffix('.metrics.json');algorithm,trial_op=label.split('-trial-');trial,operation=trial_op.split('-',1)
 data=json.loads((a.input/(label+'.json')).read_text());assert all(j['error']==0 for j in data['jobs'])
 job=data['jobs'][0];io=job['read' if operation=='randread' else 'write'];metrics=json.loads(path.read_text());mm=list(map(int,metrics['zram_mm_stat'].split()))
 record={'algorithm':algorithm,'trial':int(trial),'operation':operation,'iops':io['iops'],'bytes_per_second':io['bw_bytes'],'completed_ios':metrics['completed_ios'],'mean_clat_ns':io['clat_ns']['mean'],'clat_stddev_ns':io['clat_ns']['stddev'],'clat_percentiles_ns':io['clat_ns'].get('percentile',{}),'user_cpu_percent':job['usr_cpu'],'system_cpu_percent':job['sys_cpu'],'package_energy_uj':metrics['package_energy_uj'],'whole_job_package_uj_per_io':sum(metrics['package_energy_uj'].values())/metrics['completed_ios'],'energy_scope':metrics['energy_scope'],'measurement_elapsed_ns':metrics['elapsed_ns'],'original_bytes':mm[0],'compressed_bytes':mm[1],'allocated_bytes':mm[2],'same_filled_pages':mm[5]}
 rows.append(record)
 # fio JSON refers only to the newly allocated synthetic device.
 (a.output/(label+'.fio.json')).write_text(json.dumps(data,indent=2)+'\n')
for path in sorted(a.input.glob('*-verify.json')):
 data=json.loads(path.read_text());assert all(j['error']==0 and j['read']['io_bytes']==64*1024*1024 for j in data['jobs'])
for path in sorted(a.input.glob('*-profile.txt')):
 profiles[path.stem]=[{'kernel_symbol':m.group(2),'self_percent':float(m.group(1))} for line in path.read_text().splitlines() if (m:=re.match(r'\s+(\d+\.\d+)%\s+\[k\]\s+(\S+)',line))]
metadata={'kernel':env['kernel'],'kernel_config_sha256':env['kernel_config_sha256'],'zram_module_srcversion':env['zram_module_srcversion'],'fio':env['fio'],'compiler':env['compiler'],'recovery_policy':env['recovery_policy'],'source_sha256':checkpoint['source_sha256'],'scope':'Physical N100 stock-kernel, isolated synthetic ZRAM device, 64 MiB, 50% nominal compression, 4 KiB synchronous direct I/O, CPU 0, three randomized trials per algorithm','crc32c_full_device_verification':'passed after every trial','rows':rows,'profiles':profiles}
(a.output/'results.json').write_text(json.dumps(metadata,indent=2)+'\n')
print('| Algorithm | Operation | Median IOPS | Mean completion latency (ns) | Whole-job package energy (uJ/IO) |')
print('|---|---|---:|---:|---:|')
for algorithm in sorted({r['algorithm'] for r in rows}):
 for operation in ['randread','randwrite']:
  group=[r for r in rows if r['algorithm']==algorithm and r['operation']==operation]
  print(f"| {algorithm} | {operation} | {statistics.median(r['iops'] for r in group):,.0f} | {statistics.median(r['mean_clat_ns'] for r in group):,.0f} | {statistics.median(r['whole_job_package_uj_per_io'] for r in group):.3f} |")
