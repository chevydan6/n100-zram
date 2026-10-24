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

The controlled reboot did **not** restore SSH within five minutes. Read-only LAN
discovery did not find the target's pinned SSH identity at a new address. No CCD
serial device is attached. The cause is unknown; the user has been asked what
appears on the laptop screen. This does not prove a kernel boot failure: network,
login or service state must be distinguished through a console.

No further native module load or reboot should run until this test is resolved.
NanoKVM is optional. A physical console or another working, verified recovery
route is sufficient. Successful diskless VM tests do not establish physical boot
recovery.

## Changes prepared on the target

`tools/prepare-recovery.py` recorded the kernel/entry hashes and prior runtime
policy in `before.json`, copied `stock-entry.conf` and `grubenv`, and created the
lab-owned `/etc/sysctl.d/99-n100-zram-lab.conf`. Its policy is panic timeout 10,
panic on oops, NMI watchdog, and panic on hard/soft lockups. The BLS entry gained:

```text
panic=10 nmi_watchdog=1 efi_pstore.pstore_disable=0 pstore.kmsg_bytes=8192
```

The EFI pstore backend registered successfully before reboot; post-reboot logging
has not been inspected. Original installed kernel/module files were preserved.
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

## Required next verification

Confirm a normal stock boot returns to SSH, inspect pstore/journal behavior, then
test bounded automatic crash recovery. A one-shot alternate-kernel boot also
needs tested timeout/rollback handling. Preserve the stock entry and installed
modules, and do not repeatedly boot an unverified experimental kernel.

The syscall codec probe is a separate benchmark-only module. It does not register
a ZRAM backend or replace the active swap driver. Its new misc interface has
passed VM validation on the exact 7.0.10 ABI, including all-register state checks;
physical loading remains pending recovery verification.
