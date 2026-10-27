# Benchmarks

For the latest additive GZRAM development and benchmark safety repair, see
[the Astra checkpoint](docs/GZRAM-ASTRA-20261028.md). It does not supersede
[SOL's measured results](docs/GZRAM-20261028.md) or establish a new speed gain.

## Initial N100 exploratory user-space run

Raw data: `benchmarks/results/n100-initial.csv`. These are codec timings, **not
ZRAM timings**. Kernel stock `7.0.10-201.fc44.x86_64`, Intel N100, GCC 16.2.1 (Red Hat 16.2.1-2), powersave
governor, CPU affinity to CPU 0, 4 GB physical memory. Background desktop activity
was not disabled. Initial thermal readings ranged 20–39 C across reported zones;
some sensors are not CPU package sensors. No frequency or thermal normalization
has yet been applied. This run is exploratory and does not satisfy acceptance.

The exact custom-kernel LZ4 source runs in user space. Four deterministic
synthetic corpora each contain 128 x 4096-byte pages: random, sparse (56 zero
bytes per 64-byte group), period-127, and mixed random/repeated data. There are
2 warmup rounds and 21 recorded rounds. Every operation batch has 8192 pages.
Variant order is deterministically shuffled. Clock: CLOCK_MONOTONIC_RAW.
Compression ratios are identical across variants; compressed byte counts are
recorded in every CSV row. Numbers below are medians, nanoseconds per page.

| Corpus | Operation | Scalar | SSE2 | AVX2 | AVX2 count only |
|---|---|---:|---:|---:|---:|
| random | compress | 1270.4 | 1263.6 | 1221.3 | 1187.2 |
| random | decompress | 113.9 | 114.0 | 114.3 | 113.9 |
| sparse | compress | 1818.3 | 2003.8 | 1881.3 | 1911.9 |
| sparse | decompress | 561.9 | 517.4 | 487.6 | 546.0 |
| period127 | compress | 936.4 | 666.6 | 599.9 | 592.0 |
| period127 | decompress | 224.3 | 188.7 | 217.0 | 224.5 |
| mixed | compress | 3146.6 | 3114.5 | 2962.9 | 2934.7 |
| mixed | decompress | 344.4 | 331.6 | 287.8 | 339.7 |

No energy or CPU core-cycle result is available. Perf is not installed and RAPL
energy counters require administrator access. Timing is wall time per page.
No stock-versus-custom-kernel or swap-latency comparison has occurred.
Zero/same-filled pages are correctness cases, not evidence of codec acceleration
in ZRAM, which can bypass compression for same-filled pages.

Next runs must add real executable pages, paired confidence intervals, thermal
sampling and repeated sessions. Kernel tests must include SIMD state overhead,
controlled secondary ZRAM I/O, actual memory pressure and recovery validation.

## Experiment 002: short-match guard and independent copies

Three consecutive native sessions, 21 randomized paired rounds per corpus per
session, seven variants, same toolchain/governor. Full raw CSVs are
`benchmarks/results/session-{0,1,2}.csv`; [complete summary](benchmarks/results/experiment-002-summary.md)
includes every variant and regression. Ratios below 1 mean less wall time.
`benchmarks/summarize.py` reproduces the paired log-ratio bootstrap. Its intervals
resample rounds; they do not establish independent reboot/long-term variation.
Session-level ratios are also reported to expose drift.

The 8-byte scalar-first guard changes AVX2 Bash-page compression from a ratio of
1.089 (slower) to 0.965 (faster) against scalar. Its three session ratios are
0.964, 0.969 and 0.964. It still regresses sparse compression (ratio 1.042).
AVX2 copying improves mixed/sparse decompression but does not improve Bash-page
decompression reliably. SSE2 remains faster than AVX2 on period-127 decoding.
None is yet selected for routine deployment.

The Bash corpus is the first 128 pages of `/usr/bin/bash`, full file SHA-256
`379c1bfc53d08815975c647ad7da5d19d8e8a8566ce8097c50231c8b116e5e7b`.
A user-only perf_event hardware cycle counter opened successfully, so these CSVs
also record user core cycles per page. A value of -1 means unavailable in other
environments. Energy remains unmeasured. CPU 0 sampled frequency ranged from
700 MHz (including gaps) to 3.400 GHz, median 3.400 GHz. Reported thermal zones
ranged 20–50 C; fixed 20 C is not treated as CPU temperature. Raw private telemetry
is retained outside Git. Background activity and cache working set remain
limitations; the test uses a 512 KiB input corpus per class.

An unchanged count-only decoder has small timing differences from scalar due to
code generation/layout and compiler ISA flags. This negative control cautions
against treating low single-digit differences as intrinsic-loop improvements.

## Kernel integration correctness checkpoint

The optional `lz4-n100` backend and isolated probe compile against the installed
7.2.8-n100v1 headers using GCC 16.2.1; the original kernel used GCC 16.1.1.
Objdump confirms AVX2 comparison/movemask/copy instructions in vector objects.
A diskless KVM boot of that exact kernel loaded the probe with SIMD enabled,
then loaded the experimental ZRAM module. Both lz4 and lz4-n100 completed four
2 MiB write/read/compare passes with identical compressed byte totals.
See `docs/validation/vm-001.json` for pinned input hashes. This is host-VM
correctness evidence only, not native N100 timing, stability or boot recovery.

Local ASan/UBSan suites passed for seven intrinsic variants: 3,926 round-trip
inputs, 20,000 malformed inputs, 55,405 guard checks and 8,400 independent liblz4
cross-decoding cases across four threads. Native kernel-compatible code generation
also passed, bringing native guard checks to 63,320 and interoperability to 9,600.

## Experiment 003: longer guards and scalar unrolling

[All 10-variant results](benchmarks/results/experiment-003/summary.md) and three raw
CSV sessions are preserved. This run held the existing project's exclusive native
suite lock. A 16-byte scalar guard gave Bash compression a paired time ratio of
0.953, but sparse compression regressed to 1.070. A 32-byte guard gave ratios
0.963 and 1.042 respectively. Scalar unrolling helped the long-period synthetic
case (0.710) but regressed Bash compression (1.041). None removes the need to
measure kernel state overhead and mixed real workloads. Do not select a variant
solely from its best corpus.

Native correctness for the 10 variants passed 3,926 inputs, 20,000 malformed
inputs, 79,150 guard checks and 12,000 independent cross-decoding cases. Local
ASan/UBSan also passed those suites for all 10 variants.

## Active-kernel memory-pressure baseline

[Recorded native results](benchmarks/results/stock-lzorle-pressure.json) contain
three sessions on stock 7.0.10, current lzo-rle ZRAM. Each session allocates
768 MiB of anonymous memory, fills each page with a deterministic mix of random
and repeated words, and verifies every byte through three permuted whole-working-set
passes. The cgroup resident ceiling is 384 MiB, reclaim threshold 320 MiB,
swap ceiling 1 GiB and CPU quota one core. The program refuses to run without
those observed memory limits. This creates controlled swap pressure on the
installed 4 GB system while bounding the experiment. It does not claim a full
physical-RAM saturation test or a codec-only measurement.

All three sessions passed with zero recorded OOM kills. Global swap-in counts
were 567,914–568,146 pages per session and swap-out counts 683,894–684,210 pages.
ZRAM I/O counters corroborate that these transfers used ZRAM. Verification passes
took 1.596–1.705 seconds; per-page comparison p50 was 3.812–4.255 microseconds and
p95 was 5.071–5.286 microseconds. These page-comparison latencies include faults,
copy/compare, reclaim, scheduling and cgroup throttling; they are not pure swap-in
or decompression latencies. Global counters may include background activity.
The resident ceiling also causes additional reclaim of the latency array/code.

`benchmarks/pressure.c`, `tools/run-pressure.py` and `tools/pressure-remote.py`
reproduce the bounded workload; the controller uses the shared native test lock.
`benchmarks/summarize-pressure.py` reduces private snapshots to public metrics.
No ZRAM algorithm, boot setting or installed package was changed.

Configuration SHA-256:
- Active stock config: `d29288290a10caff16ff4d40c1ebdc4617a22d08d040c80d95030bc26c481cf3`.
- Installed custom 7.2.8 config: `534ad5c5f743cff0d32a5b178ccfeebe3d7722f1e3303e056fd4792054d62c37`.

## Expanded kernel correctness

The current patch was rebuilt on the Fedora development VM using the exact
installed custom kernel-devel RPM. Its diskless test passed 2,048 differential
malformed/truncated blocks with output canaries, nested kernel-FPU fallback,
concurrent direct ZRAM readback and 2,048 syscall-level YMM state comparisons.
The final module hash is recorded in `docs/validation/vm-005.json`. Host-VM timing
is deliberately excluded from N100 performance results.

## Experiment 004: explicit Gracemont compiler scheduling

[Complete 14-variant results](benchmarks/results/experiment-004/summary.md)
include three additional native timing sessions. GCC accepts `-mtune=gracemont`;
this adjusts scheduling/cost choices without enabling SIMD in scalar objects.
The tuned scalar path is essentially unchanged in wall time on Bash pages
(ratio 1.003; session ratios 0.999, 1.000, 1.011). Tuned AVX2 guards retain sparse
compression regressions and do not improve Bash decompression. No broad win
justifies selecting the compiler flag as a validated optimization.

Native validation passed for all 14 variants: 3,926 round-trip inputs, 20,000
malformed cases, 110,810 guard checks and 16,800 independent cross-decoding cases
with four threads. Separate `.text` inspection confirmed that tuning changed
machine code, rather than silently being ignored.

## Replaying historical experiments

`benchmarks/sources/` preserves the actual variant generator and native benchmark
sources used for each experiment, with SHA-256 checksums. In a fresh isolated
checkout, copy the desired `experiment-NNN-build.py.txt` to `tools/build.py` and
`experiment-NNN-native.c.txt` to `benchmarks/native.c`, then follow the README build
commands. Keep the reference LZ4 and compatibility headers unchanged. Use the
recorded compiler and physical N100. The initial experiment has no cycle counter;
subsequent native sources include it.

The deterministic PRNG is shared between corpus generation and order shuffling,
so changing the variant set/order changes later generated sparse/mixed bytes.
Paired comparisons within a run use identical pages. Do not compare absolute
numbers across differently configured experiments as if their inputs were fixed.
The recorded source snapshots preserve the original generation/shuffle sequence.

## Kernel code footprint

With the same GCC 16.2.1 and 7.2.8 header configuration, `size` reports:

| Optional backend | Text | Data | BSS |
|---|---:|---:|---:|
| Disabled | 48,393 | 6,895 | 40 |
| Enabled | 84,105 | 8,096 | 40 |

This is an object-section footprint, not measured resident memory. The prototype
adds 35,712 bytes of text and 1,201 bytes of data, mainly from a namespaced codec
copy. Per-stream allocation follows existing LZ4 and adds no per-page allocation.
A default-disabled build contains no n100_lz4 symbols. Further code-size reduction
should follow native evidence that the additional codec earns its cost.

## Experiment 005: bounded overlap broadcasts

[Complete 16-variant results](benchmarks/results/experiment-005/summary.md) include
three native sessions. New AVX2 paths broadcast a fully initialized 8- or 16-byte
period only when the overlap distance equals that period, and copy only complete
32-byte vectors before retaining the original scalar tail. No extra allocation or
wider overrun is introduced.

Against the existing AVX2 guard, sparse decoding improves by about 2% but mixed
decoding regresses by 3.9% (three session ratios 1.040, 1.040, 1.038).
[Direct paired comparison](benchmarks/results/experiment-005/overlap-vs-guard.md)
shows the tradeoff; the
[copy-only comparison](benchmarks/results/experiment-005/overlap-vs-copy.md)
also retains the mixed-data regression. The new broadcasts are therefore retained
as a rejected research experiment and are **not** selected by prepare-kernel.py.
The optional kernel backend remains the earlier AVX2-guard prototype, not a
validated production selection.

All 16 variants passed native round trips, 20,000 malformed inputs, 126,640 guard
checks and 19,200 independent cross-decoding cases. Local ASan/UBSan passed the
same suites. A subsequent native preflight also verified byte-identical compressed
output and every decompressed byte for all 128 pages of each actual timed corpus,
including Bash executable pages. Its `--validate-only` mode preserves shuffle PRNG
advancement, so later generated corpora match the original variant sequence.
Future timing runs perform that preflight automatically. Earlier timing source
snapshots remain unchanged and explicitly preserve their original methodology.

The current prototype has reached diminishing returns in unprivileged codec
experiments: SIMD helps selected patterns but retains regressions, and compiler
tuning/extra copy branches do not establish a universal gain. The next meaningful
selection requires physical N100 kernel FPU-inclusive timings, controlled ZRAM
I/O and matched-kernel pressure tests. Those require authenticated administrator
access and verified physical recovery. Host-VM timing cannot substitute for them.

User-space corpus buffers, alignment and destination reuse also differ from the
real ZRAM stream and zsmalloc paths. These codec numbers are exploratory; the
prepared kernel probe and controlled native ZRAM tests remain necessary.

## Native stock-kernel ZRAM I/O baseline after administrator access

Authenticated administrator access enabled a separate dynamically allocated ZRAM
device. The active swap device was not reset or replaced. The smoke test and six
full trials passed complete-device CRC32C verification, and the temporary device
was removed after each run. [Public records](benchmarks/results/native-stock-7.0-io/results.json)
and [summary](benchmarks/results/native-stock-7.0-io-summary.md) retain every trial.
Raw perf recordings and host identifiers remain outside Git.

Conditions: physical N100, stock 7.0.10, fio 3.40, 64 MiB synthetic device, 4 KiB
synchronous direct I/O, one job pinned to CPU 0, nominal 50% buffer compression,
one-second warmup and five-second measured phases, three randomized trials per
algorithm. NMI watchdog was enabled. All pages contain checksum headers and mixed
data; the records include same-filled-page counts to expose bypasses.

| Backend | Random-read IOPS | Random-write IOPS | Read mean completion ns | Write mean completion ns |
|---|---:|---:|---:|---:|
| lzo-rle | 518,606 | 255,403 | 1,657 | 2,609 |
| lz4 | 413,067 | 223,040 | 2,125 | 3,148 |

Values are medians across three trials. On this workload stock LZ4 is slower than
the installed lzo-rle default; an AVX2 LZ4 implementation must be compared against
both. No experimental kernel module was loaded for these measurements.

Whole-job package energy was 12.657/27.371 microjoules per read/write I/O for
lzo-rle and 15.375/32.122 for LZ4. These RAPL measurements span the entire fio
process and include startup and background package activity; they are not isolated
codec energy. Actual trial values, CPU use, completion percentiles, allocated
memory and compression ratios are available in the records.

Kernel-only cycle sampling attributes 39.39% of sampled LZ4 random-read kernel
cycles to LZ4_decompress_safe, versus 18.40% to lzo1x_decompress_safe in the lzo-rle
run. zs_obj_read_begin and memcpy also consume material time. These profiles
identify where to investigate; they do not prove that SIMD wins after FPU costs.
The full-device workload includes longer repeated regions than earlier synthetic
short-run experiments, so any later reconsideration of overlap copying must be
reported as a new workload-specific investigation.

## Syscall-level kernel codec probe

The benchmark-only misc interface preallocates per-file input, compressed storage,
output and workspace. It compares byte-identical scalar/SIMD compression and both
decoders, and exposes one-page operations without hot-path allocations. The user
harness measures clean, SSE-dirty and YMM-dirty state on entry to each syscall,
checks distinct sentinels in all 16 YMM registers and verifies retained input data.
This addresses the optimistic state ownership of repeated calls inside one kernel
entry. The running-kernel ABI passed diskless VM checks (`vm-008.json`); physical
execution remains pending verified recovery and restored network access.

## Native kernel codec experiment 001

The exact-ABI AVX2-guard probe completed three physical N100 syscall-inclusive
sessions on stock 7.0.10. All correctness/state checks passed and cleanup was
verified. Most timings regress, including every decompression corpus; periodic
compression alone improves. The initial candidate fails performance acceptance.
See [all timing rows and repeatability intervals](benchmarks/results/native-kernel-codec-001/summary.md).
These are codec calls, not an optimized ZRAM deployment. Matched scalar/FPU
controls are the next experiment; compiler differences remain a confounder.

## Matched kernel controls

Three physical sessions each compared the rebuilt scalar clone, the same clone
with normal FPU bracketing, and SSE2-guard against stock on 7.0.10. Full byte and
register checks passed; all probes unloaded. With YMM-dirty user state, the
unbracketed scalar clone is close to stock, while FPU-bracketed scalar adds
approximately 435 ns/page across these corpora. This explains most of the
initial SIMD decoder loss. SSE2 remains slower than stock on every decoding
corpus. Tests on different variants are sequential, not interleaved; CPU0 batch
ordering within each variant is randomized. No energy claim is inferred.

Raw timings and paired session summaries: [scalar control](benchmarks/results/native-kernel-scalar-control/summary.md),
[scalar plus FPU](benchmarks/results/native-kernel-scalar-fpu/summary.md),
[SSE2](benchmarks/results/native-kernel-sse-guard/summary.md).

## Scalar long-match investigations

The distance-one memset path passed three native kernel sessions but produced
no useful timed-corpus gain. Parsing representative compressed pages showed the
half-zero long run uses offset eight; a fully zero page uses offset one, but
ZRAM normally bypasses its compressor for same-filled pages.
[Distance-one results](benchmarks/results/native-kernel-scalar-runfill/summary.md).

A subsequent wild-copy `rep stosq` path for long effective eight-byte periods
reduced median YMM-dirty half-zero decode time from 805 to 413 ns/page (48.7%).
However sparse decoding regressed 8.3%, mixed 4.3% and executable 2.3%; it is not
a broadly accepted improvement. Compression changes in this prototype are code
generation effects because the transform changes an inlined helper shared by
both codecs. The separate ZRAM backend retains the stock compressor.
[All repeated-store results](benchmarks/results/native-kernel-scalar-rep8/summary.md).

The repeated-store source passed ASan/UBSan, 3,926 input round trips, 20,000
malformed inputs, 142,470 sanitizer guard cases across 18 variants and 21,600
independent four-thread cross-decoding cases. Kernel probes passed exact-ABI VM
checks before native loading. A three-backend stock-7.2.8 module also passed
diskless block I/O and twelve concurrent helper/register checks; this is not a
native ZRAM result. A narrower match-only experiment is in progress to reduce
short-copy overhead. No production selection or optimized energy claim is made.

## Native ZRAM I/O and actual workload selection

The [installed 7.2.8 baseline](benchmarks/results/native-stock-7.2-io/summary.md)
completed three trials per algorithm. Two experimental-module comparisons kept
ordinary LZ4 as an internal control and preserved every fio result:
[first match-only copy experiment](benchmarks/results/native-zram-compare-001/summary.md)
and [first-match selective repeat](benchmarks/results/native-zram-compare-003/summary.md).
Each experimental comparison has five randomized trials per backend and full
CRC32C verification after each trial. The first controller needed separate stock
restoration; the repeat passed automated restoration with live build-id checks.

AVX2 read throughput trails its same-module LZ4 control by 16.7% and 17.3% in
these comparisons. The initial scalar copy path gains 24.7% on reads, with about
18% lower whole-job package energy per I/O, but the first-match hint loses that
gain on actual fio blocks. Fio's verification header creates several short
initial matches before the useful long run. That negative result is retained.
Default lzo-rle remains the faster overall baseline, especially on writes.

The rebuilt driver controls differ from the installed-stock driver results;
that difference is not attributed to codec changes. Frequency snapshots around
fio startup/exit do not establish sustained operating frequency. Cross-run
thermal/build effects remain a limitation. Within-module controls, ranges,
compressed/allocated sizes and raw timing rows are available in the result sets.

Kernel read profiles confirm the AVX2 path executes: its namespaced decoder
accounts for 29.45% of sampled kernel cycles, FPU restoration 10.21%, and XSAVE
6.86%. Ordinary LZ4 decoding accounts for 44.69% in its control; the initial
scalar repeated-store decoder accounts for 23.58%. These are profile shares,
not direct time savings or user-space performance claims.

The later [short-offset branch experiment](benchmarks/results/native-kernel-scalar-branchrep8/summary.md)
retains a 48.8% half-zero codec gain, with 2.7% sparse and 3.7% mixed codec
regressions. It removes first-token selection and puts an out-of-line integer
copy helper inside the existing short-offset path. Its full native ZRAM
pressure comparison is running; it is not accepted as a general improvement.

## Updated native pressure harness

A [stock 7.2.8 smoke check](benchmarks/results/native-pressure-stock72-smoke/summary.md)
passed four concurrent physical-CPU register helpers, 768 MiB of mixed memory,
three complete permuted byte-verification passes, 568,718 swap-ins and 684,720
swap-outs. Cgroup OOM counters remained zero; owned swap/device cleanup passed.
This single trial validates the harness, not an optimization claim. The workload
uses a 384 MiB resident ceiling and 320 MiB reclaim threshold on the actual 4 GiB
N100. It exercises real reclaim without exhausting the entire machine.

The mixed corpus includes random-plus-periodic tails, random-plus-zero tails,
longer-period tails and fully random pages. The older periodic-tail corpus is
also retained. The full comparison uses five trials per corpus/backend with
package energy, CPU time, swap counters, memory peaks and continuous telemetry.

The [completed forty-trial pressure comparison](benchmarks/results/native-zram-pressure-001/summary.md)
passed every byte/register/OOM/cleanup check and verified stock restoration.
Neither candidate establishes a broad speed/energy gain. LZ4's lower memory
footprint and lzo-rle's lower elapsed time form a measured tradeoff. Paired
descriptive intervals, all trials and continuous telemetry are preserved.

## Workspace reuse screening after repository separation

[Complete physical N100 screening](benchmarks/results/native-reuse-user-001/summary.md)
retains 8,064 timed rows over three sessions. Epoch reuse reduces periodic-page
compression time, but regresses executable and mixed data by roughly 48–62%
against fixed-page controls and incompressible pages by roughly 9–13%. This
tradeoff rejects unconditional integration. Small periodic gains do not establish
ZRAM gains. These are user-space tests with kernel FPU overhead excluded. No
energy measurement was captured in this run. All trial rows and sanitized
frequency/thermal telemetry are retained, including negative results.

The kernel's LZ4 directory adds -O3 even when global kernel configuration uses
-O2. The native-kernel-v2-*-O2 results are alternative optimization experiments,
not evidence that stock LZ4 itself was built at -O2.

## Smaller full-reset hash tables

[Three-session native screening](benchmarks/results/native-small-table-user-001/summary.md)
compares 8/4/2 KiB hash arrays with original scalar and AVX2-guard implementations.
All 8,064 batches, compressed sizes and sanitized telemetry are retained. This
screening suggests lower compression cost but has private-API/code-generation
confounding and worse executable compression ratio (about +0.24%, +0.81%, +1.95%
compressed bytes for 8/4/2 KiB arrays). It establishes no ZRAM gain. A second run
uses byte-identical table14 private controls to isolate this confounder. These
user-space results exclude kernel FPU overhead and energy was not recorded.

## Native scalar small-table kernel I/O

[Five-trial native comparison](benchmarks/results/native-scalar-small12-io-002/summary.md)
uses the VM-validated default-off 4 KiB-table kernel backend. Paired random-write
IOPS improved 8.20% (five-trial bootstrap interval +4.98% to +9.10%); whole-job CPU
package energy per I/O decreased 9.70% (-11.64% to -6.47%). Reads showed no clear
change. Every trial and write profile passed full CRC32C verification, and the
installed stock module/build ID and primary lzo-rle swap were restored.

This is one synthetic 64 MiB / nominal 50%-compressible block-I/O experiment,
not application responsiveness or broad workload acceptance. Whole-job energy
includes startup/background activity. LZO remained faster in this fixture.
Allocated ZRAM memory was unchanged (34.16 MiB median); compressed bytes changed
slightly. Matching compiler/control variants and memory-pressure tests remain
necessary before assigning all improvement to the table-size change or accepting
a new default. Raw CPU counters, sanitized telemetry and all trials are retained.

### Scalar small-table controlled reclaim

[Thirty-trial pressure results](benchmarks/results/native-scalar-small12-pressure-001/summary.md)
and [paired analysis](benchmarks/results/native-scalar-small12-pressure-001/paired-analysis.json)
retain five trials × two corpora × three backends. All byte checks, 120 register
helper processes and stock restoration passed. Whole-workload elapsed-time
intervals include zero, so no reclaim-speed improvement is accepted. Paired system
CPU time was about 2% lower; package energy was lower in this one shuffled run
(roughly 8–10% paired medians). Power remains CPU-package scope with background
work, frequency and thermal variability; this is not whole-laptop energy or a
cross-session generality claim. Peak ZRAM memory was essentially unchanged
versus LZ4, and lower than LZO for these inputs. The installed system has 4 GiB;
this used bounded memcg reclaim, not whole-machine exhaustion.
