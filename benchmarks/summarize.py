#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Paired round-level log-ratio bootstrap; exploratory, not independent boot CIs."""
import csv,sys,collections,statistics,math,random
from pathlib import Path
rng=random.Random(100)
rows={};groups=collections.defaultdict(set)
for path in map(Path,sys.argv[1:]):
    for row in csv.DictReader(path.open()):
        key=(row['corpus'],row['operation'],row['variant'])
        rows[*key,path.name,int(row['round'])]=float(row['ns_per_page'])
        groups[key].add((path.name,int(row['round'])))
print('| Corpus | Operation | Variant | Median ns/page | Paired ratio | Round bootstrap 95% CI | Session ratios |')
print('|---|---|---|---:|---:|---:|---|')
for (corpus,op,v),keys in sorted(groups.items()):
    if v=='scalar':continue
    keys=sorted(keys)
    logs=[math.log(rows[corpus,op,v,*k]/rows[corpus,op,'scalar',*k]) for k in keys]
    draws=sorted(math.exp(statistics.mean(rng.choices(logs,k=len(logs)))) for _ in range(2000))
    sessions=collections.defaultdict(list)
    for k,l in zip(keys,logs):sessions[k[0]].append(l)
    ses=', '.join(f'{math.exp(statistics.mean(ls)):.3f}' for _,ls in sorted(sessions.items()))
    print(f'| {corpus} | {op} | {v} | {statistics.median(rows[corpus,op,v,*k] for k in keys):.1f} | {math.exp(statistics.mean(logs)):.3f} | {draws[49]:.3f}–{draws[1949]:.3f} | {ses} |')
