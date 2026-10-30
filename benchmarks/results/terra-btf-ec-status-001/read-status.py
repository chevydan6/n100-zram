#!/usr/bin/env python3
"""Issue only Chrome EC HANG_DETECT GET_STATUS; never arm, cancel or clear."""
import fcntl
import json
import os
import platform
import struct

assert os.geteuid() == 0
# cros_ec_command: 5 native u32 values followed by ec_params_hang_detect.
# Kernel headers define _IOWR(0xec, 0, struct cros_ec_command), size 20.
request = bytearray(struct.pack('=IIIIIHH', 0, 0x009f, 4, 1, 0, 3, 0))
result = {'operation': 'EC_CMD_HANG_DETECT version 0 GET_STATUS',
          'kernel': platform.release(), 'watchdog_armed': False,
          'scope': 'Read-only status query; no recovery capability or timer state proof'}
try:
    fd = os.open('/dev/cros_ec', os.O_RDONLY | os.O_CLOEXEC)
    try:
        rc = fcntl.ioctl(fd, 0xc014ec00, request, True)
    finally:
        os.close(fd)
    version, command, outsize, insize, ec_result = struct.unpack_from('=IIIII', request)
    result.update(ioctl_return=rc, ec_result=ec_result,
                  status=request[20] if ec_result == 0 and rc >= 1 else None)
except OSError as error:
    result.update(errno=error.errno, error=str(error))
print(json.dumps(result, sort_keys=True))
