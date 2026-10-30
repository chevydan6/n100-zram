# Reanalysis of namespaced ZRAM coexistence guests

The first corrected coexistence guest passed with AVX2 hidden. The AVX2-exposed
guest completed its device and CPU-hotplug operations and shut down normally,
but the launcher reported failure because a kernel printk split the second
`COEXIST_UNLOAD_PASS` marker. Both original result files and raw consoles remain
unchanged in ../terra-coexist-gate-002/.

A strict parser reconstructs timestamped printk-interleaved userspace markers,
checks one CPU1 and one stock-data marker inside each completed algorithm record,
and requires an unload after every full pass. It passed 57 interleaving positions
and four negative protocol cases. Original consoles were still independently
scanned for all failure tokens. Both guests reanalyzed successfully: ten ordered
algorithm records, ten CPU1 offline/online and pinned-I/O checks, ten independent
stock-data checks, two unload checks, four workers and 26 corpora. Exact module,
stock module, kernel, client, guest executables and all corpus hashes were
reverified. Host settings were unchanged and no experimental host module loaded.

These are diskless guest correctness results. They do not establish native
coexistence safety, hard-hang recovery, SIMD path execution in the ZRAM driver,
representative pressure, performance or energy. The previous standalone SIMD
probe independently confirmed SIMD execution, but cannot substitute for a device
path counter. CPU hotplug ordering deserves further review.
