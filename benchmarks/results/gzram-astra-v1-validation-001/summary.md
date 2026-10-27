# GZRAM additive candidate validation

Correctness and code-generation checks only, on the physical N100 with Fedora
7.2.11 and GCC 16.2.1. No timing, CPU-usage, PMU or energy result is claimed.
The local zstd ZRAM and boot configuration were preserved. See metadata.json
for build/source fingerprints and the matching extracted sanitizer RPM hashes.

| Check, per candidate and build | Passed cases |
|---|---:|
| Cross-path and cross-policy round trips | 29,312 |
| Guarded capacity cases | 29,264 |
| All 256 sparse masks, every truncation and output boundary | 71,680 |
| Malformed/mutated decodes | 80,000 |
| Four-thread round trips | 4,000 |

Both outlinetail and ctzunpack passed all rows in normal and ASan/UBSan builds.
Their encodings were checked byte-for-byte against wordmixed and splittail.
Independent decoding used the Python GZR1 oracle and system liblz4.
The original 16 library text sections remain identical; complete artifact hashes
match their build manifests. Corpus hashes retain the original twelve inputs.

The full registry passed normal and sanitizer validation: 249 variants, sixteen
corpora, 128 pages each (509,952 round trips per build). All variants, including
preserved controls, are exercised. This does not test kernel integration or
AVX2-disabled VM fallback. Hosted CI has not been claimed to pass.

The original harness failed UBSan at index 185 of order[185] when all 217
original variants were enabled. The repaired harness passed those 217 controls
too. SOL's published selected cohorts were smaller and are not invalidated.
An initial normal candidate run was interrupted by a concurrent artifact
inspection rewriting a loaded library; its private core and logs are retained.
The safe audit now works on copies, and the isolated normal repeat passed.
That interrupted run is not counted as a pass. The separate size exporter also
retains a failed initial GZR2-oracle configuration attempt outside public data.
