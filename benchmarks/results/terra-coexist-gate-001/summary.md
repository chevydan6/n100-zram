# Namespaced ZRAM coexistence experiment

The prototype changes module, disk, control class and debugfs names and uses a separately allocated CPU-hotplug PREPARE state. Stock ZRAM uses the fixed CPUHP_ZCOMP_PREPARE state, so changing names alone is insufficient. CPU-hotplug ordering and lifetime are part of the experiment. No host module is loaded.

The coexistence gate did not pass or was deferred: failed or deferred; preserve artifacts AssertionError('guest-fallback'). Preserve its build logs and partial guest evidence. No native use or correctness claim follows.
