#!/bin/bash
set -euo pipefail
base=/home/dan/n100-zram/build/terra-custom-kernel-001
out="$base/physical-prep/initramfs-7.2.11-n100-gzram.img"
[ ! -e "$out" ] || { echo 'Refusing to overwrite initramfs'; exit 1; }
[ "$(uname -r)" = 7.2.11-200.fc44.x86_64 ] || { echo 'Unexpected running kernel'; exit 1; }
dracut --hostonly --kver 7.2.11-n100-gzram --kmoddir "$base/stage/lib/modules/7.2.11-n100-gzram" "$out"
chown 1000:1000 "$out"
