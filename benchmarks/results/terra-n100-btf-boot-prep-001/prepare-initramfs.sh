#!/bin/bash
set -euo pipefail
base=/home/dan/n100-zram/build/terra-custom-kernel-001
release=7.2.11-n100-gzram-btf
out="$base/physical-prep/initramfs-$release.img"
[[ $(id -u) == 0 && $(uname -r) == 7.2.11-200.fc44.x86_64 ]] || { echo 'Requires root and the normal Fedora kernel' >&2; exit 1; }
[[ ! -e "$out" ]] || { echo 'Refusing to overwrite initramfs' >&2; exit 1; }
flock -n /home/dan/.cache/n100-zram/native-validation.lock dracut --hostonly --kver "$release" --kmoddir "$base/stage-btf/lib/modules/$release" "$out"
chown 1000:1000 "$out"
echo "Prepared $out; inspect with lsinitrd before installing"
