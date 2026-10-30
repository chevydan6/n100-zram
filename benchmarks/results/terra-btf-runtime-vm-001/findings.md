# Guest runtime BTF check

The revised `7.2.11-n100-gzram-btf` image exposes nonempty `/sys/kernel/btf/vmlinux` in a diskless AVX2-enabled KVM guest. The guest also passed two ZRAM round-trip passes each for GHY bitdirect and LZ4-GHY, with 24,197 client checks per pass. The raw guest serial log and manifest are retained. The launcher now has an optional `--require-btf` gate; previous behavior is unchanged when it is absent.

This verifies runtime exposure in the minimal guest, not systemd's ability to attach its BPF policy, physical hardware behavior, security equivalence, native performance, or recovery. Host stock ZRAM settings remained unchanged according to the runner's hashes. The revised physical kernel remains unbooted.

A negative control booted the earlier kernel built without BTF with `--require-btf`; the guest emitted the failure marker, the manifest reports no BTF marker and failed status, and the launcher returned exit 1. Thus the new gate is checked for both presence and absence. This deliberately failing isolated guest did not change the active host swap.
