# N100 scalar LZ4 continuation

The user has ended GZRAM development and requested an optimized scalar LZ4
compressor. This branch starts from b3463e6, preserving the GZRAM history and
all previous LZ4 experiments. Refreshed remote branches were inspected.

The existing 12-bit small-table variant and its matched 14-bit control are the
starting candidates, not accepted defaults. A prior five-trial synthetic native
ZRAM I/O comparison reported 231,369 versus 212,300 median write IOPS for
small versus matched control, with +11.07% paired median throughput and −11.16%
whole-job package energy per I/O. Results had broad intervals and older-kernel
code/layout effects; lzo-rle was faster in that test. Earlier userspace tests
showed Bash output 3,216.6 to 3,242.6 bytes/page (+0.81%) versus matched table14.
A separate scalar repeated-store decoder accelerated a half-zero case but
regressed sparse, mixed and executable cases; retain it as a tradeoff, not a
universal improvement. Sources and reports remain unchanged.

The current physical machine runs kernel 7.2.11-200.fc44.x86_64 and stock zstd
ZRAM. These settings are not directly comparable with old kernel/AC cohorts.
The next step is a fresh correctness rebuild of the matched table sizes and then
controlled N100 tests with output size, compression and decoding time, CPU and
available package energy. The independent decoder, boundaries, malformed input,
concurrency and sanitizer gates precede any kernel integration. Actual native
pressure acceptance must compare current stock zstd, LZ4 and lzo-rle with verified
recovery and restoration. No boot or normal ZRAM configuration change is authorized.

A [fresh matched physical userspace screen](../benchmarks/results/native-lz4-scalar-timing-002/findings.md)
completed after [normal and sanitizer correctness gates](../benchmarks/results/lz4-scalar-validation-001/summary.md).
The 4 KiB table improves tested compression times but adds 0.81% to Bash output;
the 8 KiB table adds 0.24% with a smaller speed gain. The fixed-order screen has
no package-energy or native-pressure evidence. Retain both candidates and assess
order-randomized diverse workloads before selecting a kernel experiment.

The [randomized package-energy screen](../benchmarks/results/native-lz4-scalar-random-energy-001/findings.md)
found the 4 KiB scalar table reduced compression time and CPU package energy
versus the matched 16 KiB table on all seven tested fixtures. Distributed Bash,
Git and libc pages were 2.81–3.55% faster and used 3.09–3.83% less package energy,
but their compressed output increased by 0.72–0.84%. The initial benchmark's
reported size totals accumulated across corpora; the raw CSVs and recovery method
are preserved, and the harness is corrected. These remain userspace results, not
whole-laptop energy or native ZRAM acceptance.

The [corrected-harness energy confirmation](../benchmarks/results/native-lz4-scalar-confirm-energy-002/findings.md) passed its audit and confirmed lower compression time and CPU package energy for 4 KiB and 8 KiB tables, with executable size penalties. The [exact-kernel build and guest gate](../benchmarks/results/lz4-scalar-kernel-gates-002/summary.md) records its actual outcome. Native recovery, pressure and responsiveness remain unproven.
