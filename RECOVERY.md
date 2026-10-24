# Recovery state and procedures

## Current physical test result

Authenticated administrator access was verified. The running and default kernel
were both stock Fedora `7.0.10-201.fc44.x86_64`. No experimental module was loaded
on the physical N100. Separate ZRAM baseline devices were removed successfully.

Recovery preparation saved the stock BLS entry and grubenv under the private
`/home/dan/n100-zram-lab/recovery-setup/` directory. It kept the stock kernel as
the default and added panic/lockup recovery plus EFI pstore logging. The stock
kernel binary was not changed. The host also holds a copy of that kernel image
and all source/results outside the target.

The initial ACPI restart powered the machine off (user confirmed). After manual
power-on, switching the runtime restart method to PCI and testing a one-shot
stock 7.2.8 boot restored SSH. The controller observed the new boot in 79.6 seconds,
including preparation/timer time. The saved default remained stock 7.0.10.

A subsequent deliberate SysRq panic on stock 7.2.8 returned to saved stock 7.0.10
in 118.1 seconds, including preparation/timer time. EFI pstore archived sixteen
records, including the explicit SysRq panic signature. Those records and both
controller observations are preserved privately outside Git. This establishes
the tested PCI restart and panic recovery, not recovery from every hardware
hang or automatic timeout of an unverified kernel boot. No NanoKVM is configured.

## Changes prepared on the target

`tools/prepare-recovery.py` recorded the kernel/entry hashes and prior runtime
policy in `before.json`, copied `stock-entry.conf` and `grubenv`, and created the
lab-owned `/etc/sysctl.d/99-n100-zram-lab.conf`. Its policy is panic timeout 10,
panic on oops, NMI watchdog, and panic on hard/soft lockups. The BLS entry gained:

```text
panic=10 nmi_watchdog=1 efi_pstore.pstore_disable=0 pstore.kmsg_bytes=8192
```

The EFI pstore backend registered and archived the controlled panic after reboot. Original installed kernel/module files were preserved.
Persistent journaling was already present. Runtime NMI monitoring had been enabled
earlier in this lab session; initial inspection reported it disabled.

## Restore the saved lab configuration

After reaching a console or restoring SSH, inspect the actual running kernel,
network state and previous-boot journal first. If the lab boot/recovery settings
need reverting, the helper verifies the saved entry and kernel hashes before
restoring the saved BLS entry and removing only the unchanged lab policy file:

```sh
sudo python3 tools/restore-recovery.py --backup /home/dan/n100-zram-lab/recovery-setup
```

The helper restores the runtime values saved immediately before preparation; the
saved NMI value is 1 because monitoring had already been enabled in this session.
It leaves the boot default selection unchanged. It does not overwrite grubenv's
new runtime state. Keep raw boot IDs, root UUIDs, journals and crash recordings
outside public Git.

## PCI recovery preparation and remaining limits

`tools/prepare-pci-recovery.py` saves both stock 7.0.10 and 7.2.8 BLS entries,
entry/kernel hashes and the default under the private `recovery-pci/` directory.
It adds `reboot=pci` with the panic/pstore arguments above and verifies that the
default is unchanged. These later backups are separate from `recovery-setup/`.
The original restore helper handles only its original single-entry backup;
inspect both generations before reverting any later PCI entry changes. Do not
replace live grubenv with an old snapshot. Other kernel entries are untouched.

Tuned can disable the NMI watchdog after boot. The native runner explicitly
re-enables and checks monitoring before loading experimental code. No hardware
watchdog was exposed; the read-only Chrome EC HANG_DETECT capability query did
not establish support and did not arm a watchdog. Kernel restart/panic policy
cannot guarantee recovery from all hardware or firmware hangs.

The separate syscall codec probe does not replace active ZRAM. Its exact 7.0.10
binary passed the diskless VM and three physical sessions, then unloaded cleanly.
Place it under a dedicated matching-kernel `extra/n100-zram-lab/` directory and
run restorecon before loading from a system service: SELinux denies module_load
from user_home_t. Keep enforcement enabled; do not install autoload rules or
replace stock modules. Future experimental boot entries require their own tested
rollback path; successful recovery of stock kernels does not prove that path.
