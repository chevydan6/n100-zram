# Recovery status

The known-good default is the existing stock Fedora 7.0.10 kernel. Installed
custom 7.2.8-n100v1 and stock 7.2.8 are comparison candidates, not verified
recovery kernels. Preserve the existing boot entries, initramfs and signing
material. Never publish signing keys or host credentials.

Remote SSH is verified. Current out-of-band video, serial and power access and
automatic boot rollback are **not verified**. Historical NanoKVM/SuzyQ access is
not sufficient evidence of a working present recovery path. No experimental boot
has been attempted by this branch.

Before experimental kernel boots: record current bootloader entries/default,
verify a known-good entry can boot and restore SSH, preserve logs off-device,
verify console/power recovery, and test one-shot boot plus automatic fallback
where supported. Boot an experimental kernel only through that established
path. Keep persistent journals and capture pstore/previous-boot logs on recovery.
Detailed tested commands will be added after administrator access and actual
bootloader configuration have been inspected; no rollback is claimed today.

Unprivileged codec experiments are isolated in `~/n100-zram-experiment` on the
test machine. They do not alter the active ZRAM device or boot configuration.
