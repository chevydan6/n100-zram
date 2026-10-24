#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Reduce native raw metrics to public benchmark evidence without host identifiers."""
import json,sys
from pathlib import Path
root=Path(sys.argv[1]);result=[]
def vm(text):return {k:int(v) for k,v in (line.split() for line in text.splitlines())}
for session in sorted(root.glob('session-*')):
 before=json.loads((session/'before.json').read_text());after=json.loads((session/'after.json').read_text())
 a=vm(before['/proc/vmstat']);b=vm(after['/proc/vmstat'])
 sa=list(map(int,before['/sys/block/zram0/stat'].split()));sb=list(map(int,after['/sys/block/zram0/stat'].split()))
 measurements=[json.loads(line) for line in (session/'workload.jsonl').read_text().splitlines()]
 result.append({'session':session.name,'kernel':before['kernel'],'algorithm':before['/sys/block/zram0/comp_algorithm'].strip(),'workload_mib':768,'resident_limit_mib':384,'memory_high_mib':320,'swap_limit_mib':1024,'cpu_quota_cores':1,'workload':measurements,'vmstat_deltas':{k:b[k]-a[k] for k in ['pswpin','pswpout','pgmajfault','oom_kill']},'zram_io_deltas':{name:sb[i]-sa[i] for i,name in [(0,'reads'),(2,'read_sectors'),(4,'writes'),(6,'write_sectors')]},'provenance':json.loads((session/'result.json').read_text())})
print(json.dumps(result,indent=2))
