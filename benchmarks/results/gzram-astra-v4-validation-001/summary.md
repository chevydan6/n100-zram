# Block selection and combined repeat correctness checkpoint

All five new policies plus reverse wordmixed compatibility passed normal and
ASan/UBSan testing on the physical Intel N100. The source hashes were unchanged
throughout all 21 validation steps. No timing or energy result is supplied here.

Each blockpick2/3/4 policy, per build, passed 39,424 cross-decoder round trips,
39,376 guarded encoder capacities and 72 additional cutoff-boundary pages.
The pages exercise populations immediately below, at and above each aggregate
cutoff at every supported internal block length; each is encoded at all eight
block lengths. Exact output matches preserved wordmixed.

Each bitmerge/bitdirect policy and reverse wordmixed check, per build, passed
34,816 cross-decoder round trips and 34,768 guarded encoder capacities. Bitmerge
and bitdirect match repeatmergefast's exact bytes and each passed 62 direct
merge checks. Bitdirect additionally passed 560 nested-header mutation/trailing
payload checks against independent decoding and protected buffers.

Every policy/build also passed 71,680 exhaustive mask decode cases, 48,576 repeat
boundary cases, 80,000 malformed/mutated inputs and 4,000 four-thread round trips.
Independent Python and system LZ4 decoding remain part of the oracle. The full
521-variant registry passed 1,333,760 round trips per build over 20 corpora.

All 30 prior library text sections, all 20 corpus hashes and all 266,240 prior
per-page size records remain identical. The expanded screen retains 317,440
size records. No old policy or unsuccessful experiment was removed.

The GHY1/GZR1 formats are unchanged. Block selection adds no queue and leaves
pages independently decodable. Bitmerge combines sparse bit-scan encoding,
the preserved CTZ decoder and consolidated repeat frames. Bitdirect adds a
scalar repeat expansion shortcut after validating the complete nested frame.
Consolidation gives 33-byte repeat16 and 49-byte repeat32 frames (versus bitctz's
84/148 and matched LZ4's 42/58). Its processing overhead is not established by
these size checks; the extra direct-decoder checks may penalize other pages.

This checkpoint is userspace correctness and size evidence, not a kernel port,
a ZRAM pressure test, a SIMD crossover decision or production-readiness evidence.
The next experiment measures all five policies with matched controls across
all 20 corpora and retains every regression.
