#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Exercise strict coexistence marker ownership and kernel-log interleaving."""
import importlib.util, pathlib
path=pathlib.Path(__file__).resolve().parents[1]/'tools/coexist_vm_records.py'
spec=importlib.util.spec_from_file_location('coexist_vm_records',path);module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
parse=module.parse_coexist_markers
base='GZRAM_DEVICE_BEGIN pass=1 algorithm=lz4\nCOEXIST_CPU1_PASS\nCOEXIST_STOCK_PASS\nGZRAM_DEVICE_END pass=1 algorithm=lz4\nCOEXIST_UNLOAD_PASS\n'
result=parse(base,['lz4']);assert result['completed']==[('1','lz4')] and result['unloads']==1 and not result['errors']
count=0
for marker in ['COEXIST_CPU1_PASS','COEXIST_STOCK_PASS','COEXIST_UNLOAD_PASS']:
 start=base.index(marker)
 for at in range(len(marker)+1):
  candidate=base[:start+at]+'[  10.123] kernel message\n'+base[start+at:]
  assert parse(candidate,['lz4'])==result,(marker,at)
  count+=1
for text in [base.replace('COEXIST_CPU1_PASS\n',''),base.replace('COEXIST_STOCK_PASS\n','COEXIST_STOCK_PASS\nCOEXIST_STOCK_PASS\n'),base.replace('COEXIST_UNLOAD_PASS\n','COEXIST_UNLOAD_PASS\nCOEXIST_UNLOAD_PASS\n'),base.replace('GZRAM_DEVICE_END pass=1 algorithm=lz4','GZRAM_DEVICE_END pass=1 algorithm=zstd')]:
 assert parse(text,['lz4'])['errors']
print(f'Passed {count} marker-interleaving positions and four negative protocol cases')
