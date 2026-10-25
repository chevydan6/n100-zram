#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Bounded persistent collection of one completed native user-space experiment."""
import argparse,json,shlex,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('--host',required=True);p.add_argument('--unit',required=True);p.add_argument('--remote',required=True);p.add_argument('--private',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--publish',action='store_true');p.add_argument('--kind',choices=['small-table','crossover','components'],default='small-table');a=p.parse_args();branch='feature/n100-adaptive-simd-zram' if a.kind in ['crossover','components'] else 'feature/n100-avx2-zram'
root=Path(__file__).resolve().parents[1]
def git(*args):return subprocess.check_output(['git',*args],cwd=root,text=True).strip()
revision=git('rev-parse','HEAD')
if a.publish:
 assert git('branch','--show-current')==branch
 assert not git('status','--porcelain'),'Refuse publishing around unrelated work'
assert not a.output.exists()
deadline=time.monotonic()+1500
while time.monotonic()<deadline:
 result=subprocess.run(['ssh','-o','BatchMode=yes','-o','ConnectTimeout=8',a.host,shlex.join(['systemctl','show',a.unit,'-p','ActiveState','-p','SubState','-p','ExecMainStatus'])],capture_output=True,text=True,timeout=15)
 if result.returncode==0:
  d=dict(line.split('=',1) for line in result.stdout.splitlines() if '=' in line)
  if d.get('ActiveState')=='failed':raise SystemExit('Native service failed; preserve logs and inspect checkpoint')
  if d.get('SubState')=='exited':
   assert d.get('ExecMainStatus')=='0';break
 time.sleep(5)
else:raise SystemExit('Collection deadline reached; remote job was not stopped')
a.private.mkdir(parents=True,exist_ok=True)
for name in ['checkpoint.json','validation.log','session-0.csv','session-1.csv','session-2.csv','telemetry.jsonl']:
 subprocess.run(['scp','-q',a.host+':'+a.remote+'/'+name,str(a.private/name)],check=True)
assert json.loads((a.private/'checkpoint.json').read_text())['status']=='complete'
if a.publish:
 assert git('rev-parse','HEAD')==revision and not git('status','--porcelain'),'Work changed during test; raw results preserved privately'
subprocess.run(['python3',str(root/('adaptive/summarize-components.py' if a.kind=='components' else 'tools/summarize-crossover.py' if a.kind=='crossover' else 'tools/summarize-small-table-user.py')),'--input',str(a.private),'--output',str(a.output)],cwd=root,check=True)
if a.publish:
 relative=a.output.resolve().relative_to(root)
 status=root/'STATUS.md';status.write_text(status.read_text()+f'\n### Native experiment collection\n\nThree native experimental sessions completed; all raw rows and sanitized\ntelemetry are in [{relative}/summary.md]({relative}/summary.md). Measurement scope is documented in the report; component and codec results\nestablish no end-to-end ZRAM improvement.\n')
 subprocess.run(['git','diff','--check'],cwd=root,check=True)
 subprocess.run(['git','add','--',str(relative),'STATUS.md'],cwd=root,check=True)
 subprocess.run(['git','commit','-m','Preserve real kernel SIMD component and FPU-cost measurements' if a.kind=='components' else 'Preserve refined native scalar SSE2 AVX2 crossover measurements' if a.kind=='crossover' else 'Preserve three matched N100 table-size sessions and all compression-ratio tradeoffs'],cwd=root,check=True)
 subprocess.run(['python3',str(root/'tools/audit-publication.py')],cwd=root,check=True)
 subprocess.run(['git','push','origin','HEAD:'+branch],cwd=root,check=True)
print('COLLECTION_COMPLETE; all measured data retained; no kernel default changed',flush=True)
