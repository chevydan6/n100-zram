# SPDX-License-Identifier: GPL-2.0-only
"""Strictly reconstruct per-device coexistence markers from guest console."""
import re


def parse_coexist_markers(text, expected_algorithms):
    # Preserve raw warning/failure scanning in parse_device_records; this
    # reconstructed stream is only for userspace marker accounting.
    protocol = re.sub(r'\[[ \t]*\d+\.\d+\][^\n]*(?:\n|$)', '', text)
    expected = set(expected_algorithms)
    active = None
    seen = set()
    completed = []
    unloads = 0
    errors = []
    for line in protocol.splitlines():
        begin = re.fullmatch(r'GZRAM_DEVICE_BEGIN pass=(\d+) algorithm=([a-z0-9-]+)', line)
        end = re.fullmatch(r'GZRAM_DEVICE_END pass=(\d+) algorithm=([a-z0-9-]+)', line)
        if begin:
            if active is not None:
                errors.append('Begin before previous end')
            active, seen = (begin[1], begin[2]), set()
        elif line in ('COEXIST_CPU1_PASS', 'COEXIST_STOCK_PASS'):
            if active is None or line in seen:
                errors.append('Unowned or duplicate coexistence marker')
            seen.add(line)
        elif end:
            if active != (end[1], end[2]) or seen != {'COEXIST_CPU1_PASS', 'COEXIST_STOCK_PASS'}:
                errors.append('Coexistence markers missing or mismatched at end')
            else:
                completed.append(active)
            active, seen = None, set()
        elif line == 'COEXIST_UNLOAD_PASS':
            unloads += 1
            cycles = [x for x in completed if x[0] == str(unloads)]
            if active is not None or len(cycles) != len(expected) or {x[1] for x in cycles} != expected:
                errors.append('Unload before all expected algorithms completed')
        elif line.startswith('COEXIST_'):
            errors.append('Malformed coexistence marker')
    if active is not None:
        errors.append('Unfinished coexistence record')
    return dict(completed=completed, unloads=unloads, errors=errors)
