#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Generate an unbuilt, namespaced ZRAM coexistence prototype.

No module loading, kernel settings, swap changes, or native use. A tested
source module and its two guest device reports are required as identity evidence;
this generator still needs independent compilation and coexistence validation.
"""
import argparse, hashlib, json, re, shutil
from pathlib import Path
p=argparse.ArgumentParser(description=__doc__)
for name in ['source','build-record','guest-scalar','guest-avx2','output']:
 p.add_argument('--'+name,type=Path,required=True)
a=p.parse_args();source=a.source.resolve();out=a.output.resolve();assert source.is_dir() and not out.exists()
assert source not in out.parents and out not in source.parents
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
build=json.loads(a.build_record.read_text());assert build['status']=='built'
assert sha(source/'zram.ko')==build['module_sha256']
for path in [a.guest_scalar,a.guest_avx2]:
 guest=json.loads(path.read_text());assert guest['status']=='passed' and guest['hashes']['module']==build['module_sha256']
out.mkdir(parents=True)
source_hashes={}
for f in sorted(source.rglob('*')):
 if not f.is_file() or not (f.suffix in ['.c','.h'] or f.name in ['Makefile','Kconfig']) or f.name.endswith('.mod.c'):continue
 relative=f.relative_to(source);target=out/relative;target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(f,target);source_hashes[str(relative)]=sha(f)
for name in ['zcomp.c','zram_drv.c','zcomp.h','Makefile']:
 assert name in source_hashes
# The stock driver registers CPUHP_ZCOMP_PREPARE globally. A second module must
# use a distinct dynamically allocated state, or it can collide with stock.
# PREPARE ordering must still be reviewed and guest CPU-hotplug tested; this
# transformation is a hypothesis, not proof that native coexistence is safe.
h=out/'zcomp.h';text=h.read_text();marker='#include <linux/mutex.h>\n';assert text.count(marker)==1;h.write_text(text.replace(marker,marker+'\nextern int n100_zcomp_cpuhp_state;\n'))
c=out/'zcomp.c';text=c.read_text();marker='#include "zcomp.h"\n';assert text.count(marker)==1;text=text.replace(marker,marker+'\nint n100_zcomp_cpuhp_state = -1;\n');assert text.count('CPUHP_ZCOMP_PREPARE')==2;text=text.replace('CPUHP_ZCOMP_PREPARE','n100_zcomp_cpuhp_state');c.write_text(text)
d=out/'zram_drv.c';text=d.read_text()
for old,new,count in [('debugfs_create_dir("zram", NULL)','debugfs_create_dir("n100_zram", NULL)',1),('"zram%d", device_id','"n100zram%d", device_id',1),('"zram-control"','"n100-zram-control"',1),('unregister_blkdev(zram_major, "zram")','unregister_blkdev(zram_major, "n100_zram")',1),('register_blkdev(0, "zram")','register_blkdev(0, "n100_zram")',1),('"block/zram:prepare"','"block/n100_zram:prepare"',1)]:
 assert text.count(old)==count,(old,text.count(old));text=text.replace(old,new)
assert text.count('cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE')==1
text=text.replace('cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE','cpuhp_setup_state_multi(CPUHP_BP_PREPARE_DYN')
assert text.count('cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE)')==3
text=text.replace('cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE)','cpuhp_remove_multi_state(n100_zcomp_cpuhp_state)')
old='''	if (ret < 0)
		return ret;

	ret = class_register(&zram_control_class);'''
new='''	if (ret < 0)
		return ret;
	n100_zcomp_cpuhp_state = ret;

	ret = class_register(&zram_control_class);'''
assert text.count(old)==1;text=text.replace(old,new);assert 'CPUHP_ZCOMP_PREPARE' not in text;d.write_text(text)
f=out/'Makefile';text=f.read_text();text,n=re.subn(r'^zram(?=-)', 'n100_zram',text,flags=re.M);assert n>=2
old='obj-$(CONFIG_ZRAM)\t+=\tzram.o';assert text.count(old)==1;text=text.replace(old,'obj-$(CONFIG_ZRAM)\t+=\tn100_zram.o');f.write_text(text)
for path in out.rglob('*.c'):
 assert not re.search(r'^\s*EXPORT_SYMBOL(?:_GPL)?\(',path.read_text(),re.M),path
record=dict(scope='Unbuilt coexistence prototype; no load, safety, timing or recovery claim',tested_source_module_sha256=build['module_sha256'],guest_reports_sha256=[sha(a.guest_scalar),sha(a.guest_avx2)],generator_sha256=sha(Path(__file__)),source_sha256=source_hashes,generated_sha256={str(p.relative_to(out)):sha(p) for p in sorted(out.rglob('*')) if p.is_file()},names=dict(module='n100_zram',disk='n100zram%d',control_class='n100-zram-control',debugfs='n100_zram',cpu_hotplug='separate dynamically allocated PREPARE state'),limitations=['No stock-plus-prototype coexistence has been tested','CPU hotplug ordering and lifetime require explicit validation','No native loading or measured performance'])
(out/'coexist-manifest.json').write_text(json.dumps(record,indent=2)+'\n');print(out)
