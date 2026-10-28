# Recovery state and procedures

## Current Astra environment, 2026-10-28

The local N100 now runs stock `7.2.11-200.fc44.x86_64` with zstd ZRAM. A
[read-only review](docs/validation/astra-recovery-review-20261028.json) found all
five panic/lockup runtime settings at zero, ACPI restart, no recovery boot
arguments and no exposed hardware watchdog. The historical backup directory is
not present at its documented location. Unprivileged `grubby --default-kernel`
returned `/boot` with status zero; that is not a kernel image and does not verify
the boot default. No settings were changed by this review.

A [fresh unprivileged inventory](docs/validation/astra-native-inventory-unprivileged-20261028.json)
captures the explicit permission errors for `/boot/grub2/grubenv` and the BLS
directory. The `/boot` return is therefore not accepted as a boot default and
does not indicate a broken boot configuration. `gzram/tools/inspect-native.py`
can repeat this read-only inventory with privileged visibility; it prints JSON,
never arms recovery or opens watchdog devices, and retains failures explicitly.
Its full output includes identifying boot/process information and should be
reviewed before publication.

The historical PCI/panic tests below remain useful evidence for their recorded
kernels and configurations. They do not satisfy the current native kernel gate.
The scalar GZR1 component has passed an isolated exact-kernel VM correctness
test; no experimental GZRAM module has been loaded on this current host. Inspect
and verify current boot/recovery/restoration before progressing to native kernel
trials. Userspace codec development and measurements continue independently.

## Historical physical test result

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

## Controlled native module trials

`tools/run-kernel-zram.py` verifies the exact ABI, previously VM-tested module
hash, recovery policy, unused extra devices, disk-swap headroom and the live
stock module's GNU build-id note before replacement. Fedora stock 7.2.8 omits
srcversion, so that field alone cannot identify the running module.

The controller temporarily masks only `dev-zram0.swap` and
`systemd-zram-setup@zram0.service` under `/run`, drains primary swap, explicitly
resets the drained device and waits for udev before bounded unload retries.
Without these masks systemd can automatically reactivate the recreated device.
Masking/reloading a unit can also remove its ordinary stop/reset command; the
explicit drained-device reset handles that case. No force-unload is used.

The experimental module is inserted by its explicit lab path without replacing
or indexing over the installed stock module. At completion the controller removes
its owned devices, reloads installed stock code, removes its own runtime masks,
restarts managed swap and checks live build-id, original algorithm and size.
The masks disappear on reboot as well. A failed controller is retained as failed,
even if a subsequent recovery succeeds. Inspect /proc/swaps and the checkpoint
before touching any device; only lab-owned devices may be reset or removed.

Kernel-pressure trials wait/retry bounded EBUSY results from transient udev/blkid
opens. The nested workload's logs use private `/var/log/n100-zram-lab/` files,
and compiled helpers use `/usr/local/libexec/n100-zram-lab/`. Passing a writable
home-directory file descriptor to PID 1 was denied by SELinux; normal locations
and labels resolved that denial without changing policy or enforcement.

The separate controller service on the development machine holds the project's
native-validation lock and observes the persistent root job over pinned SSH.
Use `--timeout-seconds` to cover the root service's bounded maximum runtime. SSH
failures are retried while the lock is retained. If a running unit vanishes, the
watcher reports failure rather than treating a reboot as a successful test.

For an interrupted pressure experiment, use a fresh outer controller output and
`--resume-pressure /previous/output/pressure`. The inner harness verifies its
kernel, module build-id, binary/helper hashes, script hash and trial settings
before skipping completed trials. It preserves failed attempts separately.
Changed inputs require a new experiment. Raw kernel logs, crash records and
private checkpoints remain outside public Git.
