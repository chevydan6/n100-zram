# SPDX-License-Identifier: GPL-2.0-only
"""Strict guest allocation records, tolerating timestamped printk interleaving."""
import re

def parse_allocation_records(text, algorithms, corpora):
 protocol=re.sub(r'\[[ \t]*\d+\.\d+\][^\n]*(?:\n|$)','',text.replace('\r',''))
 active=None;records=[];errors=[];seen=set()
 pattern=re.compile(r'ZRAM_CORPUS_STATS pass=(\d+) algorithm=([a-z0-9-]+) corpus=([A-Za-z0-9_-]+\.bin) ((?:\d+\s+){8}\d+)')
 for line in protocol.splitlines():
  begin=re.fullmatch(r'GZRAM_DEVICE_BEGIN pass=(\d+) algorithm=([a-z0-9-]+)',line)
  end=re.fullmatch(r'GZRAM_DEVICE_END pass=(\d+) algorithm=([a-z0-9-]+)',line)
  match=pattern.fullmatch(line)
  if begin:
   if active is not None:errors.append('nested algorithm record')
   active=(begin[1],begin[2])
  elif end:
   if active!=(end[1],end[2]):errors.append('mismatched algorithm end')
   active=None
  elif match:
   cycle,algorithm,corpus=match.group(1,2,3);key=(cycle,algorithm,corpus)
   if active!=(cycle,algorithm) or algorithm not in algorithms or corpus not in corpora or key in seen:errors.append('unowned, unexpected or duplicate allocation record')
   seen.add(key);v=[int(x) for x in match[4].split()]
   if v[0]!=127*4096:errors.append('unexpected source page count')
   records.append(dict(cycle=cycle,algorithm=algorithm,corpus=corpus,orig_data_size=v[0],compr_data_size=v[1],mem_used_total=v[2],mem_limit=v[3],mem_used_max=v[4],same_pages=v[5],pages_compacted=v[6],huge_pages=v[7],huge_pages_since=v[8]))
  elif line.startswith('ZRAM_CORPUS_'):errors.append('malformed allocation marker')
 if active is not None:errors.append('unfinished algorithm record')
 expected={(str(cycle),algorithm,corpus) for cycle in (1,2) for algorithm in algorithms for corpus in corpora}
 if seen!=expected:errors.append('missing or extra allocation records')
 return {'records':records,'errors':errors}
