# Matched LZ4/GHY userspace comparison harness gate

Four scalar LZ4 table sizes share the table14 scalar decoder; scalar and AVX2
entries of the existing bounded GHY combined codec use their own corresponding
decoders. All six entries passed 128 independent page round trips in seven
corpora in normal and ASan/UBSan builds. The prior candidate-specific independent
decoding, malformed-input, capacity, repeat and concurrency gates remain relevant.

A 128-call bookkeeping smoke on three corpora checked 324 unique recorded rows
and each randomized 12-task permutation. This smoke preceded the final addition
of an AVX2/OS-availability check; the measurement source and both final validation
builds include that check. Smoke timing is not performance evidence. GHY includes
container framing while direct LZ4 does not, and allocated ZRAM memory cannot be
inferred from these userspace bytes. Task order is randomized and frames are
restored to common addresses, but the two GHY decoder entries are distinct.
