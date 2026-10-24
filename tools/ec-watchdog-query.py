#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Read-only Chrome EC AP-watchdog capability and last-reset-status query."""
import os,fcntl,struct,json
# CROS_EC_DEV_IOCXCMD: _IOWR(0xec, 0, struct cros_ec_command), header size 20.
IOCTL=0xc014ec00
fd=os.open('/dev/cros_ec',os.O_RDWR|os.O_CLOEXEC)
def command(number,payload,insize):
 buffer=bytearray(struct.pack('<IIIII',0,number,len(payload),insize,0)+payload+b'\0'*max(0,insize-len(payload)))
 fcntl.ioctl(fd,IOCTL,buffer,True)
 version,cmd,outsize,returned,result=struct.unpack_from('<IIIII',buffer)
 return result,bytes(buffer[20:20+insize])
try:
 result,data=command(0x0008,bytes([0x9f]),4)
 record={'query':'EC_CMD_HANG_DETECT capability','ec_result':result,'watchdog_armed_by_query':False}
 if result==0:
  record['version_mask']=struct.unpack('<I',data)[0]
  if record['version_mask']&1:
   result,data=command(0x009f,struct.pack('<HH',3,0),1)
   record.update(status_query_ec_result=result,last_boot_status=data[0] if result==0 else None)
 print(json.dumps(record))
finally:os.close(fd)
