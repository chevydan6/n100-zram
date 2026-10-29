# SPDX-License-Identifier: GPL-2.0-only
"""Parse guest test records while retaining raw-console warning detection."""
import re

FAILURE_TOKENS = ('GZRAM_DEVICE_VM_FAIL', 'Kernel panic', 'Oops:', 'BUG:', 'WARNING:')


def parse_device_records(text):
    # Kernel console writes can interrupt a userspace tty write, even within a
    # marker word. Remove complete timestamped kernel records only for protocol
    # reconstruction. Always inspect the ORIGINAL console for warnings/failures.
    protocol = re.sub(r'\[[ \t]*\d+\.\d+\][^\n]*(?:\n|$)', '', text)
    failures = [word for word in FAILURE_TOKENS if word in text]
    records, errors, active, client, passes = [], [], None, None, 0
    for line in protocol.splitlines():
        begin = re.fullmatch(r'GZRAM_DEVICE_BEGIN pass=(\d+) algorithm=([a-z0-9-]+)', line)
        done = re.fullmatch(r'GZRAM_DEVICE_END pass=(\d+) algorithm=([a-z0-9-]+)', line)
        result = re.fullmatch(r'GZRAM_ZRAM_ROUNDTRIP_PASS corpora=(\d+) workers=(\d+) checks=(\d+)', line)
        if begin:
            if active is not None:
                errors.append('Begin before previous end')
            active, client = (begin[1], begin[2]), None
        elif result:
            if active is None or client is not None:
                errors.append('Unowned or duplicate client result')
            client = tuple(result.groups())
        elif done:
            if active != (done[1], done[2]) or client is None:
                errors.append('End does not match a completed client')
            else:
                records.append(dict(cycle=active[0], algorithm=active[1],
                                    corpora=client[0], workers=client[1], checks=client[2]))
            active, client = None, None
        elif line == 'GZRAM_DEVICE_VM_PASS':
            passes += 1
            if active is not None:
                errors.append('Guest pass during unfinished client')
        elif line.startswith(('GZRAM_DEVICE_BEGIN', 'GZRAM_DEVICE_END',
                              'GZRAM_ZRAM_ROUNDTRIP_PASS', 'GZRAM_DEVICE_VM_PASS')):
            errors.append('Malformed protocol record: ' + line)
    if active is not None:
        errors.append('Unfinished client at end of console')
    return dict(records=records, protocol_errors=errors, failure_tokens=failures,
                pass_markers=passes)
