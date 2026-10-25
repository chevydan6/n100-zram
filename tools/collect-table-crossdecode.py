#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Collect completed matrix, retaining all cells and avoiding unrelated changes."""
import argparse,csv,json,statistics,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--remote',required=True);p.add_argument('--private',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();root=Path(__file__).resolve().parents[1]
def git(*args):return subprocess.check_output(['git',*args],cwd=root,text=True).strip()
assert git('branch','--show-current')=='feature/n100-avx2-zram' and not git('status','--porcelain')
assert not a.output.exists();a.private.mkdir(parents=True,exist_ok=True)
for name in ['checkpoint.json','session-0.csv','session-1.csv','session-2.csv']:
 subprocess.run(['scp','-q',a.host+':'+a.remote+'/'+name,str(a.private/name)],check=True)
state=json.loads((a.private/'checkpoint.json').read_text());assert state['status']=='complete' and state['completed']==[0,1,2]
a.output.mkdir(parents=True);rows=[]
for i in range(3):
 f=a.private/f'session-{i}.csv';data=list(csv.DictReader(f.open()));assert len(data)==486
 for r in data:r['session']=i;rows.append(r)
 (a.output/f.name).write_bytes(f.read_bytes())
(a.output/'metadata.json').write_text(json.dumps(state,indent=2)+'\n')
lines=['# Identical-page scalar LZ4 decoder matrix','','Three physical N100 warm-cache userspace sessions, nine shuffled rounds after two warm-ups.', 'Every encoder processes identical pages; every decoder receives each encoder stream.', 'Full cross-path byte checks occur before timing, final-page checks after every batch.', 'Hash values are diagnostic stream fingerprints, not cryptographic integrity checks.', 'All cells are retained. Kernel context, allocator and end-to-end swap costs are excluded.', 'Cycles are user-only; interpret only fully scheduled measurements. RAPL covers package and batch bookkeeping/background activity, not whole-laptop energy.', '', '| Corpus | Encoder table KiB | Decoder table KiB | Median ns/page | Bytes/page |', '|---|---:|---:|---:|---:|']
for corpus in sorted({r['corpus'] for r in rows}):
 for e in ['12','13','14']:
  for d in ['12','13','14']:
   arows=[r for r in rows if r['corpus']==corpus and r['encoder_bits']==e and r['decoder_bits']==d]
   lines.append(f"| {corpus} | {2**int(e)//1024} | {2**int(d)//1024} | {statistics.median(float(r['ns_per_page']) for r in arows):.3f} | {arows[0]['bytes_per_page']} |")
(a.output/'summary.md').write_text('\n'.join(lines)+'\n')
subprocess.run(['git','diff','--check'],cwd=root,check=True)
subprocess.run(['git','add','--',str(a.output.resolve().relative_to(root))],cwd=root,check=True)
subprocess.run(['git','commit','-m','Preserve full identical-page scalar cross-decoding matrix'],cwd=root,check=True)
subprocess.run(['python3',str(root/'tools/audit-publication.py')],cwd=root,check=True)
for i in range(3):
 if subprocess.run(['git','push','origin','HEAD:feature/n100-avx2-zram'],cwd=root).returncode==0:break
 if i==2:raise SystemExit('Push failed; committed evidence retained')
 time.sleep(5*(i+1))
print('CROSSDECODE_COLLECTION_COMPLETE',flush=True)
