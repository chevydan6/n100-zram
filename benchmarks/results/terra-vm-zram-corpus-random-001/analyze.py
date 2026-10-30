#!/usr/bin/env python3
"""Summarize all six sequential guest cycles without selecting favorable runs."""
import csv,json,pathlib,sys
base=pathlib.Path(__file__).resolve().parent;records=[];names=None;digests=None;module=None
for seed in (471,472,482):
 s=json.loads((base/f'guest-{seed}.json').read_text());assert s['status']=='passed' and s['before_settings']==s['after_settings'] and not s['experimental_host_module_loaded'];assert len(s['allocation_observations'])==312
 if names is None:names=set(s['corpus_sha256']);digests=s['corpus_sha256'];module=s['hashes']['module']
 assert names==set(s['corpus_sha256']) and digests==s['corpus_sha256'] and module==s['hashes']['module'] and not s['allocation_protocol_errors']
 for x in s['allocation_observations']:records.append(dict(seed=seed,**x))
w=csv.writer(sys.stdout,lineterminator='\n');w.writerow(['corpus','algorithm','compressed_min','compressed_max','allocated_min','allocated_max','same_pages_min','same_pages_max','observations'])
for corpus in sorted(names):
 for algorithm in ('ghy-bitdirect','ghy-simd','lz4-ghy','lz4','lzo-rle','zstd'):
  a=[x for x in records if x['corpus']==corpus and x['algorithm']==algorithm];assert len(a)==6
  w.writerow([corpus,algorithm,min(x['compr_data_size'] for x in a),max(x['compr_data_size'] for x in a),min(x['mem_used_total'] for x in a),max(x['mem_used_total'] for x in a),min(x['same_pages'] for x in a),max(x['same_pages'] for x in a),len(a)])
