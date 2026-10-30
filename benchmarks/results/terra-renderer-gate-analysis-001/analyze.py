#!/usr/bin/env python3
"""Summarize hypothetical sampling gates on preserved renderer aggregates."""
import hashlib,json,pathlib
root=pathlib.Path(__file__).resolve().parents[3];directory=root/'benchmarks/results/terra-owned-renderer-sample-001';rows=[]
for n in (6,7):
 path=directory/f'trial-00{n}.json';d=json.loads(path.read_text());assert d['status']=='passed';a=d['classes']['anonymous_private'];non_same=a['pages']-a['same_word'];parent=a['codecs']['ghy-combined-avx2']['logical_stored_bytes'];lz4=a['codecs']['table12-scalar']['logical_stored_bytes']
 for policy in ('16','64','16-union','16-whole50'):
  parts=a['sampling_probe'][policy];chosen=parts.get('selected',{});rejected=parts.get('rejected',{});assert chosen.get('pages',0)+rejected.get('pages',0)==non_same;assert chosen.get('parent_bytes',0)+rejected.get('parent_bytes',0)==parent
  estimate=chosen.get('parent_bytes',0)+rejected.get('lz4_framed_bytes',0)
  rows.append(dict(trial=n,policy=policy,pages=non_same,selected_pages=chosen.get('pages',0),selected_lz4_smaller=chosen.get('lz4_smaller',0),selected_lz4_larger=chosen.get('lz4_larger',0),rejected_pages=rejected.get('pages',0),rejected_lz4_smaller=rejected.get('lz4_smaller',0),parent_bytes=parent,hypothetical_bytes=estimate,direct_lz4_bytes=lz4,input_sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
print(json.dumps(dict(status='passed',scope='Retrospective capped logical-size predictions on biased disposable renderer samples; no time, energy or real reclaim claim',rows=rows),indent=2))
