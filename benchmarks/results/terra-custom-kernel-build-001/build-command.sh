#!/bin/bash
# Resume only after inspecting the saved log, lock ownership, available memory,
# disk space and the staged source/config hashes. Does not install or boot.
set -eu
cd /home/dan/n100-zram
flock -n /home/dan/.cache/n100-zram/native-validation.lock env \
  PATH=/home/dan/n100-zram/build/terra-custom-kernel-001/toolchain/usr/bin:$PATH \
  BISON_PKGDATADIR=/home/dan/n100-zram/build/terra-custom-kernel-001/toolchain/usr/share/bison \
  HOSTCFLAGS=-I/home/dan/n100-zram/build/terra-custom-kernel-001/toolchain/usr/include \
  HOSTLDFLAGS=-L/home/dan/n100-zram/build/terra-custom-kernel-001/toolchain/usr/lib64 \
  nice -n 15 ionice -c 3 make -C build/terra-custom-kernel-001/source/linux-7.2.11 \
  O=/home/dan/n100-zram/build/terra-custom-kernel-001/out -j2 bzImage modules
