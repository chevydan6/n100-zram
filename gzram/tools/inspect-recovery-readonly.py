#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Report recovery-related metadata without changing system state or reading secrets."""
import json,os,pathlib,platform,time
p=pathlib.Path('/boot/loader/entries');entries=[]
try:
 for f in sorted(p.glob('*.conf')):
  entries.append(dict(name=f.name,size=f.stat().st_size))
 error=None
except OSError as e:error=str(e)
values={}
for name in ['panic','panic_on_oops','nmi_watchdog','hardlockup_panic','softlockup_panic']:
 try:values[name]=pathlib.Path('/proc/sys/kernel',name).read_text().strip()
 except OSError as e:values[name]='unavailable: '+str(e)
print(json.dumps(dict(time=time.time(),kernel=platform.release(),effective_uid=os.geteuid(),boot_entries=entries,boot_entries_error=error,watchdogs=[x.name for x in pathlib.Path('/dev').glob('watchdog*')],runtime_panic_settings=values,scope='Read-only metadata; no recovery or reboot capability proven'),indent=2))
