# Identical-page scalar decoder attribution

The scalar candidate is the existing LZ4 encoder with a smaller fully reset hash
table and per-stream workspace. There is no separate image scaler in this tree.
The hash table is used during compression, not decoding. A read regression
therefore needs stream/code-generation/cache evidence rather than attribution
to a hash lookup on the read path.

Build the existing private controls, then the matrix helper:

```
python3 tools/build.py --variants scalar avx2-guard
python3 tools/prepare-small-table.py
gcc -O2 -Wall -Wextra -Werror benchmarks/table-crossdecode.c -ldl -o build/small-table/benchmark
```

Use an isolated directory containing the benchmark and table12-scalar.so,
table13-scalar.so and table14-scalar.so. Under the shared N100 hardware lock,
run the bounded runner as root to obtain PMU/RAPL access:

```
python3 tools/run-table-crossdecode.py --directory /absolute/isolated-directory --output /absolute/fresh-results
```

The runner requires the N100 CPU model and pins the benchmark to CPU 0. It records
library, binary, runner and bash hashes plus kernel, governor, frequency and
thermal snapshots. Three sessions each contain six corpora and all nine
encoder/decoder combinations. Stream bytes are held constant across decoder
comparisons, and original page bytes are held constant across encoder comparisons.
The zero-tail corpora are deterministic controls, not byte-identical reproductions
of fio's nominal-compressibility fixtures. Warm-up and nine recorded rounds are
shuffled. Every page is cross-decoded and checked before timing; the final page
is checked after each batch. Previous guard, malformed and concurrency tests
continue to cover these unchanged codecs.

This experiment does not time encoding, sample concurrent application capacity,
replace kernel code or establish end-to-end ZRAM gains. It isolates possible
stream versus decoder effects in userspace. Retain all cells and sessions,
including absent/unscheduled counters. RAPL is CPU package energy over the batch
and bookkeeping/background work, not laptop power. Further kernel identical-page
controls are required before attributing the earlier fio read regression.
