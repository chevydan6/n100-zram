#!/usr/bin/env python3
"""Allocation parser accepts printk splits and rejects malformed protocols."""
import importlib.util,pathlib
root=pathlib.Path(__file__).resolve().parents[1];spec=importlib.util.spec_from_file_location('records',root/'tools/zram_allocation_records.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
mark='ZRAM_CORPUS_STATS pass={n} algorithm=lz4 corpus=a.bin 520192 30 40 0 40 0 0 0 0'
def stream(first,second):return f'GZRAM_DEVICE_BEGIN pass=1 algorithm=lz4\n{first}\nGZRAM_DEVICE_END pass=1 algorithm=lz4\nGZRAM_DEVICE_BEGIN pass=2 algorithm=lz4\n{second}\nGZRAM_DEVICE_END pass=2 algorithm=lz4\n'
a=mark.format(n=1);b=mark.format(n=2)
for i in range(len(a)+1):
 text=stream(a[:i]+'[  12.345678] guest printk\n'+a[i:],b);assert not m.parse_allocation_records(text,['lz4'],['a.bin'])['errors'],i
for text in (stream(a+'\n'+a,b),stream(a.replace('520192','1'),b),stream(a,b.replace('a.bin','b.bin')),stream(a.replace(' 30 ',' bad '),b)):
 assert m.parse_allocation_records(text,['lz4'],['a.bin'])['errors']
print(f'passed {len(a)+1} printk split positions and four negative protocol cases')
