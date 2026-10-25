# SPDX-License-Identifier: GPL-2.0-only
import struct
def decode(frame,variable_period=False):
 if len(frame)<8 or len(frame)>4104 or frame[:4] not in ([b'GZR1',b'GZR2'] if variable_period else [b'GZR1']):raise ValueError()
 n,log,raw=struct.unpack('<HBB',frame[4:8])
 if n>4096 or not 5<=log<=12 or raw>1:raise ValueError()
 if raw:
  if len(frame)!=n+8:raise ValueError()
  return frame[8:]
 block=1<<log;chunks=(n+block-1)//block;pos=8+chunks;output=bytearray()
 if pos>len(frame):raise ValueError()
 for chunk in range(chunks):
  length=min(block,n-len(output));mode=frame[8+chunk]
  if mode==0:
   if pos+length>len(frame):raise ValueError()
   output.extend(frame[pos:pos+length]);pos+=length
  elif mode==1:output.extend(bytes(length))
  elif mode==4:
   if length%32:raise ValueError()
   groups=length//32;masks=frame[pos:pos+groups];pos+=groups
   if len(masks)!=groups:raise ValueError()
   for mask in masks:
    for lane in range(8):
     if mask&(1<<lane):
      if pos+4>len(frame):raise ValueError()
      output.extend(frame[pos:pos+4]);pos+=4
     else:output.extend(bytes(4))
  elif mode==7 and variable_period and frame[:4]==b'GZR2':
   if pos+2>len(frame):raise ValueError()
   period=int.from_bytes(frame[pos:pos+2],'little');pos+=2
   if not 1<=period<=255 or period>length or pos+period>len(frame):raise ValueError()
   pattern=frame[pos:pos+period];output.extend((pattern*((length+period-1)//period))[:length]);pos+=period
  else:
   period={2:4,3:8,5:16,6:32}.get(mode)
   if period is None or period>length or length%period or pos+period>len(frame):raise ValueError()
   output.extend(frame[pos:pos+period]*(length//period));pos+=period
 if pos!=len(frame) or len(output)!=n:raise ValueError()
 return bytes(output)
