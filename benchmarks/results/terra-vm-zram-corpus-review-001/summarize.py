#!/usr/bin/env python3
"""Create a simple per-corpus guest allocator table from strict reanalysis."""
import csv,json,pathlib,sys
p=pathlib.Path(__file__).with_name('review-result.json');s=json.loads(p.read_text());assert s['status']=='passed';r=s['records'];w=csv.writer(sys.stdout);w.writerow(['corpus','cycle','algorithm','orig_bytes','compressed_bytes','allocated_bytes','same_pages','huge_pages'])
for x in sorted(r,key=lambda z:(z['corpus'],z['cycle'],z['algorithm'])):w.writerow([x['corpus'],x['cycle'],x['algorithm'],x['orig_data_size'],x['compr_data_size'],x['mem_used_total'],x['same_pages'],x['huge_pages']])
