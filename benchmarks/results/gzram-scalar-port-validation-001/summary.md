# Scalar GZR1 component preparation

The generated reference and ctz components passed the existing independent wire,
guard-page, malformed-input and four-thread suites in normal and ASan/UBSan
userspace builds. Exact counts, commands, hashes and logs are retained here.
The compatibility AVX2 entries use scalar code and report AVX2 unavailable.
No vector-register instructions were found in the compiled library bodies;
external userspace libc functions are outside that disassembly claim.

The adapter removes vector helpers/dispatch and changes include plumbing; scalar
algorithm bodies remain from the measured source. Removing callers can change
compiler optimization, so future kernel comparisons must include both adapted
reference and candidate. This is only a GZR1 component, not GHY1/LZ4 or a ZRAM
backend. No kernel compilation/execution, VM run, or performance claim follows.
