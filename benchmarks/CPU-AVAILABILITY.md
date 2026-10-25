# Controlled CPU availability probe

The pressure runner accepts --competing-sha256 (also forwarded by the experimental
module runner). The unchanged pressure binary retains the 768 MiB working set,
three full byte checks, bounded memory/swap cgroup and pre-trial register checks.
A separate checked SHA256 process on CPU0 competes with the pressure worker.
It allocates a fixed 1 MiB hash input outside the pressure cgroup and reports
16-hash batch times. Only batches wholly inside the launcher window contribute
the reported throughput; whole-probe CPU time includes startup/tails.

Compare matched kernel controls and preserve both pressure completion time and
application throughput. A faster competing process can slow pressure completion;
report both rather than selecting one favorable metric. RAPL includes both
workloads, startup and background work. This is a CPU-contention experiment,
not interactive responsiveness, real application acceptance or whole-laptop energy.
The first native run is a harness smoke check, not a repeatability conclusion.

The probe is bounded to 200 seconds; pressure remains bounded to 180 seconds.
Cleanup terminates and waits only for the owned process. Startup, exact digest
checks and graceful SIGTERM termination have been tested locally. No native
performance inference is made before the queued smoke check completes.
