#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
import argparse,shutil
from pathlib import Path
root=Path(__file__).resolve().parent
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args();assert not a.output.exists();a.output.mkdir(parents=True)
for name in ['Makefile','api.h','private.h','scalar.c','module.c']:shutil.copy2(root/name,a.output/name)
for name,width,mask,builtin in [('sse',16,'0xffffU','__builtin_ia32_pmovmskb128'),('avx2',32,'0xffffffffU','__builtin_ia32_pmovmskb256')]:
 text=(root/'vector-template.c.in').read_text().replace('WIDTH',str(width)).replace('ALL_MASK',mask).replace('MOVEMASK',builtin).replace('WORDS_INIT','{'+','.join(['value']*(width//8))+'}').replace('ISA',name)
 (a.output/(name+'.c')).write_text(text)
print(a.output)
