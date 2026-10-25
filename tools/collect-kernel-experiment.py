#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Preserve a completed native I/O run, verifying stock restoration before export."""
import argparse,json,random,shlex,statistics,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--unit',required=True);p.add_argument('--remote',required=True);p.add_argument('--private',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--publish',action='store_true');p.add_argument('--mode',choices=['io','pressure'],default='io');a=p.parse_args()
root=Path(__file__).resolve().parents[1]
def git(*args):return subprocess.check_output(['git',*args],cwd=root,text=True).strip()
revision=git('rev-parse','HEAD')
if a.publish:assert git('branch','--show-current')=='feature/n100-avx2-zram' and not git('status','--porcelain')
assert not a.output.exists();deadline=time.monotonic()+1500
while time.monotonic()<deadline:
 q=subprocess.run(['ssh','-o','BatchMode=yes','-o','ConnectTimeout=8',a.host,shlex.join(['systemctl','show',a.unit,'-p','ActiveState','-p','SubState','-p','ExecMainStatus'])],capture_output=True,text=True,timeout=15)
 if q.returncode==0:
  d=dict(line.split('=',1) for line in q.stdout.splitlines() if '=' in line)
  if d.get('ActiveState')=='failed' or d.get('SubState')=='exited':break
 time.sleep(5)
else:raise SystemExit('Deadline reached; remote job remains untouched')
a.private.mkdir(parents=True,exist_ok=True)
subprocess.run(['rsync','-a',"--include=*/","--include=*.json","--include=*.jsonl","--include=*.txt","--include=*.csv","--exclude=*",a.host+':'+a.remote+'/',str(a.private)+'/'],check=True)
state=json.loads((a.private/'checkpoint.json').read_text());assert state['status']=='complete' and state['stock_restored'] is True,'Run failed or restoration unverified; raw evidence retained privately'
if a.publish:assert git('rev-parse','HEAD')==revision and not git('status','--porcelain'),'Concurrent changes; evidence retained privately'
if a.mode=='pressure':
 subprocess.run(['python3',str(root/'benchmarks/summarize-kernel-pressure.py'),str(a.private/'pressure'),str(a.output)],cwd=root,check=True)
 parent={k:state[k] for k in ['status','kernel','experimental_sha256','stock_sha256','stock_build_note','stock_restored','primary_disksize','primary_algorithm']}
 (a.output/'restoration.json').write_text(json.dumps(parent,indent=2)+'\n')
else:
 report=subprocess.check_output(['python3',str(root/'benchmarks/summarize-kernel-io.py'),str(a.private/'io'),str(a.output)],cwd=root,text=True)
 parent={k:state[k] for k in ['status','kernel','experimental_sha256','stock_sha256','stock_build_note','stock_restored','primary_disksize','primary_algorithm']}
 (a.output/'restoration.json').write_text(json.dumps(parent,indent=2)+'\n')
 data=json.loads((a.output/'results.json').read_text());lines=['# Native scalar small-table ZRAM I/O comparison','',data['scope']+'.','Five shuffled trials per algorithm; full-device CRC32C after every trial and after write profiling.','Installed stock module, primary swap size and algorithm were verified restored.','Package energy covers the complete fio job, including startup/background activity.','This is synthetic block I/O; application responsiveness and memory-pressure acceptance remain unmeasured.','Comparisons include compiler/code-layout differences, not only hash-table size.','',report,'','## Paired trial comparisons against LZ4','','Five trial IDs are paired by number. Seeded bootstrap resamples those five ratios 10,000 times.','Intervals describe this small experiment and do not establish general workload effects.','', '| Algorithm | Operation | IOPS change [95% bootstrap] | Package uJ/IO change [95% bootstrap] |','|---|---|---:|---:|'];rng=random.Random(100)
 for algorithm in sorted({r['algorithm'] for r in data['rows']} - {'lz4'}):
  for operation in ['randread','randwrite']:
   baseline={r['trial']:r for r in data['rows'] if r['algorithm']=='lz4' and r['operation']==operation};candidate={r['trial']:r for r in data['rows'] if r['algorithm']==algorithm and r['operation']==operation};assert set(baseline)==set(candidate) and len(baseline)==5
   cells=[]
   for metric in ['iops','whole_job_package_uj_per_io']:
    ratios=[candidate[t][metric]/baseline[t][metric] for t in sorted(baseline)];boot=sorted(100*(statistics.median(rng.choices(ratios,k=5))-1) for _ in range(10000));cells.append(f'{100*(statistics.median(ratios)-1):+.2f}% [{boot[250]:+.2f}, {boot[9749]:+.2f}]')
   lines.append(f'| {algorithm} | {operation} | '+ ' | '.join(cells)+' |')
 (a.output/'summary.md').write_text('\n'.join(lines)+'\n')
if a.publish:
 relative=a.output.resolve().relative_to(root)
 subprocess.run(['git','diff','--check'],cwd=root,check=True);subprocess.run(['git','add','--',str(relative)],cwd=root,check=True)
 subprocess.run(['git','commit','-m','Preserve native scalar small-table pressure trials and verified restoration' if a.mode=='pressure' else 'Preserve native scalar small-table I/O trials, energy, counters and verified stock restoration'],cwd=root,check=True)
 subprocess.run(['python3',str(root/'tools/audit-publication.py')],cwd=root,check=True)
 subprocess.run(['git','push','origin','HEAD:feature/n100-avx2-zram'],cwd=root,check=True)
print('NATIVE_'+a.mode.upper()+'_COLLECTION_COMPLETE; stock restored and all trials retained',flush=True)
