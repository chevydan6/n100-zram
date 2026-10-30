# Subsequent manual restart

The user reported that there was no new kernel entry. This project has not installed a new experimental kernel; the GZRAM ZRAM work used a separately built module only inside isolated guests, so no new GRUB entry was expected from it. The report does not establish whether an older installed kernel or rescue entry was visible or bootable.

Read-only inspection after the restart found kernel `7.2.11-200.fc44.x86_64`, stock `[zstd]` selected on `zram0`, the same 3,924,819,968-byte ZRAM disk size as the earlier preflight, and both ZRAM and hibernation swap enabled. No experimental host module test was performed. The system had just booted, so swap use naturally differed from the earlier preflight. `/sys/class/watchdog` was empty; panic, panic-on-oops, NMI-watchdog and softlockup-panic controls were all zero.

This verifies normal startup and the inspected stock configuration, not alternate-kernel bootability, automatic hard-hang recovery, pstore readiness or native experimental-module safety. The native recovery gate remains unmet. No GRUB, boot, swap, kernel or runtime setting was changed during this inspection.
