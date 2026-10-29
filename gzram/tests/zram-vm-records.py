#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Do not mistake interleaved printk output for a missing device-test result."""
import argparse
import json
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'tools'))
from zram_vm_records import FAILURE_TOKENS, parse_device_records

p = argparse.ArgumentParser()
p.add_argument('--serial', type=Path, required=True)
a = p.parse_args()
base = ('GZRAM_DEVICE_BEGIN pass=1 algorithm=ghy-bitdirect\n'
        'GZRAM_ZRAM_ROUNDTRIP_PASS corpora=26 workers=4 checks=24197\n'
        'GZRAM_DEVICE_END pass=1 algorithm=ghy-bitdirect\n'
        'GZRAM_DEVICE_VM_PASS\n')
expected = parse_device_records(base)
assert len(expected['records']) == 1 and expected['pass_markers'] == 1
assert not expected['protocol_errors'] and not expected['failure_tokens']
for position in range(len(base) + 1):
    console = base[:position] + '[    4.257621] zram0: detected capacity change\n' + base[position:]
    assert parse_device_records(console) == expected, position
for token in FAILURE_TOKENS:
    console = base[:20] + '[ 1.25] ' + token + ' injected regression fixture\n' + base[20:]
    assert token in parse_device_records(console)['failure_tokens']
for bad in [base.replace('GZRAM_DEVICE_END pass=1', 'GZRAM_DEVICE_END pass=2'),
            base.replace('GZRAM_ZRAM_ROUNDTRIP_PASS corpora=26 workers=4 checks=24197\n', ''),
            base.replace('GZRAM_DEVICE_END pass=1 algorithm=ghy-bitdirect\n', ''),
            base.replace('checks=24197', 'checks=not-a-count'),
            base.replace('GZRAM_DEVICE_VM_PASS', 'GZRAM_DEVICE_VM_PASSjunk')]:
    assert parse_device_records(bad)['protocol_errors']
actual = parse_device_records(a.serial.read_text())
assert not actual['protocol_errors'] and not actual['failure_tokens'] and actual['pass_markers'] == 1
assert len(actual['records']) == 10
assert {(r['cycle'], r['algorithm']) for r in actual['records']} == {(str(c), x) for c in [1, 2] for x in ['lzo-rle', 'lz4', 'zstd', 'lz4-ghy', 'ghy-bitdirect']}
assert all(r['corpora'] == '26' and r['workers'] == '4' and int(r['checks']) == 24197 for r in actual['records'])
print(json.dumps(dict(status='passed',interleaving_positions=len(base)+1,raw_failure_tokens_checked=len(FAILURE_TOKENS),negative_protocol_cases=5,actual_completed_runs=len(actual['records']))))
