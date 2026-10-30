#!/usr/bin/env python3
"""Verify ownership and coverage of guest hotplug/I/O-window markers."""
import json,re,sys
from pathlib import Path
root=Path(sys.argv[1]); result=json.loads((root/'result.json').read_text());assert result['status']=='passed'
assert result['before_settings']==result['after_settings'] and not result['experimental_host_module_loaded']
s=re.sub(r'\[[ \t]*\d+\.\d+\][^\n]*(?:\n|$)','',(root/'serial.log').read_text().replace('\r',''))
active=None;seen={}
for line in s.splitlines():
 begin=re.fullmatch(r'GZRAM_DEVICE_BEGIN pass=(\d+) algorithm=([a-z0-9-]+)',line)
 end=re.fullmatch(r'GZRAM_DEVICE_END pass=(\d+) algorithm=([a-z0-9-]+)',line)
 m=re.fullmatch(r'HOTPLUG_IO_OVERLAP before=(\d+) after=(\d+) cycles=(\d+)',line)
 if begin:assert active is None;active=begin.group(1,2)
 elif end:assert active==end.group(1,2);active=None
 elif m:
  assert active is not None and active not in seen
  before,after,cycles=map(int,m.groups());assert 16<=before<after<=26*128*4 and cycles==10
  seen[active]=dict(before=before,after=after,cycles=cycles)
 elif line.startswith('HOTPLUG_IO_'):raise ValueError('Malformed marker: '+line)
assert active is None and set(seen)=={(str(c),a) for c in (1,2) for a in result['algorithms']}
print(json.dumps([dict(cycle=k[0],algorithm=k[1],**v) for k,v in sorted(seen.items())],indent=2))
