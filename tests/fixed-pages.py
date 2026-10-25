#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
import importlib.util,tempfile
from pathlib import Path
p=Path(__file__).resolve().parents[1]/'benchmarks/fixed_pages.py'
s=importlib.util.spec_from_file_location('fixed_pages',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
with tempfile.TemporaryDirectory() as d:
 p=Path(d)/'fixture';p.write_bytes(bytes(m.CHUNK*2))
 for percentage in [0,25,50,75,100]:
  sha=m.transfer(p,m.CHUNK*2,percentage,direct=False)
  assert m.transfer(p,m.CHUNK*2,percentage,verify=True,direct=False)==sha
  assert len(m.page(1,percentage))==4096
  with p.open('r+b') as f:f.seek(4096);old=f.read(1);f.seek(4096);f.write(bytes([old[0]^1]))
  try:m.transfer(p,m.CHUNK*2,percentage,verify=True,direct=False)
  except AssertionError:pass
  else:raise AssertionError('Corruption went undetected')
print('Fixed-page generation, complete verification and corruption detection passed')
