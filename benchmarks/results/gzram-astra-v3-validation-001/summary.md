# Clustered masks and selective packing correctness checkpoint

Seven additive policies plus reverse wordmixed compatibility passed normal and
ASan/UBSan tests on the physical Intel N100. Each policy/build passed 34,816
cross-decoder round trips, 34,768 guarded encoder capacities, 71,680 exhaustive
mask decode checks, 48,576 repeat boundary checks, 80,000 malformed/mutated
inputs and 4,000 four-thread round trips. Repeatmergefast also passed 62 direct
merge checks. Independent Python/system-LZ4 decoding checks the frame contents.

The 441-variant registry passed 1,128,960 round trips per build across 20 corpora.
The appended clusters25/50/75 corpora vary the fraction of full 32-byte groups
among zero groups. All 17 earlier corpus hashes and all 165,376 earlier per-page
size records are unchanged; the expanded screen contains 266,240 size records.
All 23 preceding library text sections remain byte-identical. Reusing compiled
private LZ4 objects reduces build duplication and does not change those sections.

A host restart stopped the first validation service after seven normal policy
checks. Its journal, partial log and original worker are preserved. The resumed
worker verified frozen source hashes, kept completed steps, and finished reverse
compatibility, full-registry validation, sanitizer builds/tests and size checks.
This was not a completed native timing run, a codec crash or evidence of kernel
stability. No experimental kernel module was loaded on the host.

The new policies are ctzfull, bitctz, bitfull, select2/3/4 and repeatmergefast.
The three packing cutoffs remain hypotheses pending matched native timing.
These results establish correctness coverage and byte counts, not performance.
