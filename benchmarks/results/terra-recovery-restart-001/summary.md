# Manual recovery boot-menu check

The user restarted the physical laptop and reported that no kernel entry was
shown in GRUB. A changed boot ID confirmed a restart; the machine booted the
same 7.2.11-200.fc44.x86_64 kernel. Stock zstd ZRAM and the previous ZRAM disk
size matched the saved preflight, and the hibernation swap file and ZRAM swap
were present. The exclusive native-test lock was unowned. No older kernel was
booted, so the alternate-boot recovery check remains incomplete.

Read-only GRUB inspection showed `GRUB_TIMEOUT=5`, `GRUB_DEFAULT=saved`, and
BLS entries enabled. Authenticated `grubby --info=ALL` enumerated three on-disk
entries: current kernel, older 6.19.10 kernel and rescue. The generated GRUB
configuration contains BLS import and menu-auto-hide handling. Grubenv did not
report a `menu_auto_hide` value at inspection; boot_success and boot_indeterminate
were both 0. Enumeration proves entries exist on disk, not that GRUB displays or
can boot them. The precise screen observed and why choices were absent remain
unconfirmed. No GRUB, boot, swap, or runtime setting was changed by this check.

No automatic hard-hang recovery has been demonstrated. Native experimental
module testing remains gated. A subsequent attempt should first establish what
screen appeared and use only documented temporary menu access; preserve defaults.
