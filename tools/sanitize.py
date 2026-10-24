#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Build and run the codec suites with ASan/UBSan, isolated from timing binaries."""
import subprocess,os
from pathlib import Path
root=Path(__file__).resolve().parents[1]
env=dict(os.environ,BUILD_ROOT=str(root/'build/asan'),EXTRA_CFLAGS='-fsanitize=address,undefined -fno-omit-frame-pointer')
subprocess.run(['python3','tools/build.py'],cwd=root,env=env,check=True)
env['LD_PRELOAD']=subprocess.check_output(['gcc','-print-file-name=libasan.so'],text=True).strip()
env['ASAN_OPTIONS']='detect_leaks=0:abort_on_error=1'
env['UBSAN_OPTIONS']='halt_on_error=1:print_stacktrace=1'
for script in ['check.py','guard.py','interop.py']:
    subprocess.run(['python3','tests/'+script],cwd=root,env=env,check=True)
