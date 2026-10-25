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

## Fixed observation window

--application-window-seconds 30 (with --competing-sha256) keeps the competitor
running after pressure completion until the same 30-second window has elapsed.
This tests a separate hypothesis: faster pressure completion can return CPU time
afterward even if throughput while both processes are runnable remains similar.
The first run is a harness smoke check. Pressure must finish inside the chosen
window; otherwise the attempt fails visibly rather than silently changing scope.

Record pressure completion separately from total elapsed time, fixed-window
application throughput, actual competitor nice/affinity and package energy over
the entire observation. Scheduling weights and frequency/background changes
can affect both measures. Do not compare its total energy/time directly with
historical pressure-only windows. Retain overlapping throughput as well as the
fixed-window result. Raw application batches are exported with relative timestamps.
The normal historical mode remains available without this flag.
