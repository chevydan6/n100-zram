#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""One bounded active-kernel baseline; does not alter ZRAM configuration."""
import subprocess,json,time,argparse,platform,hashlib
from pathlib import Path
parser=argparse.ArgumentParser();parser.add_argument('--session',type=int,default=0);args=parser.parse_args()
root=Path(__file__).resolve().parents[1];out=root/'build/pressure'/('session-'+str(args.session));out.mkdir(parents=True,exist_ok=True)
files=['/proc/vmstat','/sys/block/zram0/mm_stat','/sys/block/zram0/stat','/sys/block/zram0/comp_algorithm','/proc/meminfo']
def snapshot(label):
 d={'time':time.time(),'kernel':platform.release()}
 for pattern in ['/sys/class/thermal/thermal_zone*/temp','/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq','/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor']:
  import glob
  for name in glob.glob(pattern):
   try:d[name]=Path(name).read_text().strip()
   except OSError:pass
 for name in files:d[name]=Path(name).read_text()
 (out/(label+'.json')).write_text(json.dumps(d,indent=2)+'\n')
subprocess.run(['gcc','-O2','-Wall','-Wextra','benchmarks/pressure.c','-o','build/pressure-test'],cwd=root,check=True)
snapshot('before')
argv=['systemd-run','--user','--wait','--pipe','--unit=n100-zram-pressure-'+str(args.session),'--property=MemoryMax=384M','--property=MemoryHigh=320M','--property=MemorySwapMax=1G','--property=CPUQuota=100%','--property=RuntimeMaxSec=180','--property=OOMPolicy=stop',str(root/'build/pressure-test')]
with (out/'workload.jsonl').open('w') as f,(out/'stderr.log').open('w') as log:
 result=subprocess.run(argv,stdout=f,stderr=log)
snapshot('after')
status={'status':'passed' if result.returncode==0 else 'failed','returncode':result.returncode,'binary_sha256':hashlib.sha256((root/'build/pressure-test').read_bytes()).hexdigest(),'source_sha256':hashlib.sha256((root/'benchmarks/pressure.c').read_bytes()).hexdigest(),'scope':'active stock kernel lzo-rle baseline; page-compare latency includes swap and cache effects, not pure codec timing'}
(out/'result.json').write_text(json.dumps(status,indent=2)+'\n');print(json.dumps(status));raise SystemExit(result.returncode)
