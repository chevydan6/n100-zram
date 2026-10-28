# Independent scan scheduling validation

Five candidates preserve bitdirect's GHY1/GZR1 wire format, hybrid policy,
packing and decoder. Pipe1/2/4 schedule one/two/four independent 32-byte groups;
avxbits2/4 substitute AVX bitwise operations alongside AVX2 comparisons and
scalar mask counts. These are userspace prototypes; no kernel integration,
queue, cross-page dependency, or accepted performance claim follows.

Normal and ASan/UBSan builds each passed all 681 registered variants over
26 corpora × 128 pages: 2,266,368 registry round trips per build. Each new policy
also passed 59,776 dedicated cross-path round trips, 59,728 guarded capacities,
390 repeat-breaking pipeline fixtures, 560 direct-repeat header mutations,
62 repeat-merge checks, 48,576 repeat boundary checks, 71,680 independent mask
decode cases, 80,000 malformed/mutated decodes and 4,000 four-thread round trips.
Old wordmixed decoders and an independent wire decoder remain controls.

Direct core tests bypass all hybrid selection shortcuts. Each build passed
137,568 vector encodes and 275,136 guarded capacities on 2,866 inputs, comparing
all five scanners against the original vector scanner and independent decoder.
Every pipeline position can be the lone repeat-breaking/nonzero word; partial
pipelines, all internal block sizes, and unaligned short inputs are included.

All 40 preceding library .text sections match. All 26 corpus hashes and 479,232
old size/mode records match. The 66,560 new candidate size/mode records match
bitdirect exactly (545,792 total records). Raw logs, manifests, hashes, worker
commands, disassembly, and sizes are retained here and in the adjacent size
report. No prior source/result was replaced.

The original scanner is 266 bytes; pipe1/2/4 are 264/495/665 bytes and avxbits2/4
are 478/650 bytes. The disassembly confirms AVX VXORPS/VORPS versus integer
VPXOR/VPOR and interleaved scalar bookkeeping. No vector stack references occur
in these scanner functions. This is static evidence of scheduling opportunities,
not a measurement of simultaneous execution or proof of its performance effect.

Timing uses fresh matched physical N100 controls on AC at the current unchanged
700–3400 MHz powersave policy. Prior 800 MHz battery cohorts are not comparable
absolute timings. No native module or ZRAM setting is changed.
