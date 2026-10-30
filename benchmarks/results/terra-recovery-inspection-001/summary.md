# Current-kernel recovery inspection

Read-only inspection found current, older and rescue boot entries, but no tested
recovery path. The live reboot route is ACPI; panic, panic-on-oops, NMI watchdog,
hard-lockup panic and soft-lockup panic controls are zero. Pstore backend is
`(null)`, EFI pstore is disabled, and no `/dev/watchdog` device was observed.
The sysrq mask is 16, not evidence that a reboot can be forced during a hang.

A read-only Chrome EC capability query returned result 3, named
`EC_RES_INVALID_PARAM` in the matching kernel header. It did not arm a watchdog;
this response does not establish whether an independent hardware recovery path
exists. The existing native kernel runner requires a verified PCI reboot route,
positive panic controls and EFI pstore. Those conditions are not met now, and
historical success on a different kernel is not proof for this boot.

No reboot, experimental host module, boot entry, swap or runtime setting was
changed. Safe continuation needs an independently verified recovery path that
covers a hard hang, and a concrete plan to restore and verify any temporary
settings. Checking boot entry presence alone is insufficient. Native measurement
remains deferred; userspace or isolated-guest work can continue.
