#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Combine existing screening points without treating unresolved intervals as thresholds."""
import argparse,json
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('inputs',type=Path,nargs='+');p.add_argument('--output',type=Path,required=True);a=p.parse_args()
assert not a.output.exists();libraries=None;points={}
for folder in a.inputs:
 meta=json.loads((folder/'metadata.json').read_text())
 if libraries is None:libraries=meta['libraries']
 assert meta['libraries']==libraries,'Implementations changed; do not combine crossover cohorts'
 for row in json.loads((folder/'analysis.json').read_text())['screening_winners']:
  key=(row['bytes'],row['corpus'],row['operation']);points.setdefault(key,[]).append(row['winner'])
transitions=[];combined=[]
for (size,corpus,operation),winners in sorted(points.items()):combined.append({'bytes':size,'corpus':corpus,'operation':operation,'winner':winners[0] if len(set(winners))==1 else 'unresolved'})
for corpus in sorted({r['corpus'] for r in combined}):
 for operation in ['compress','decompress']:
  group=[r for r in combined if r['corpus']==corpus and r['operation']==operation]
  for before,after in zip(group,group[1:]):
   if before['winner']!=after['winner']:transitions.append({'corpus':corpus,'operation':operation,'lower_bytes':before['bytes'],'upper_bytes':after['bytes'],'lower_screening_winner':before['winner'],'upper_screening_winner':after['winner']})
a.output.write_text(json.dumps({'scope':'Combined user-space whole-codec screening; not kernel/component crossover thresholds','libraries':libraries,'points':combined,'screening_transitions':transitions,'kernel_policy_selected':False},indent=2)+'\n')
for row in transitions:print(row)
