# Embedded-controller hang-detection status query

On the physical N100 running `7.2.11-n100-gzram-btf`, the retained root-only helper issued one version-0 `EC_CMD_HANG_DETECT` GET_STATUS request to `/dev/cros_ec`, following the command and structures in this kernel's `cros_ec_wdt.c` and headers. The transport returned zero bytes and EC result 1 (`EC_RES_INVALID_COMMAND`). The request did not arm, cancel, reload or clear a watchdog; no status was returned. The helper and exact result are retained.

This is evidence that the attempted version-0 status request is unsupported or rejected on this EC endpoint; it does not rule out another firmware interface, endpoint, or recovery mechanism. In particular it does not justify arming a watchdog, changing panic settings, or bypassing the native-test recovery gate. Stock zstd remains selected and no GZRAM native test was run.
