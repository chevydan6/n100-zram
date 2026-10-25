# Scalar small-table kernel experiment

Default-off backend `lz4-small`, private 4 KiB compression hash array, normal
-O3 scalar kernel flags, baseline kernel decoder. The original `lz4` backend is
retained for same-module comparisons. Dictionary streams keep the original
kernel ABI; only independent-block compression uses the private table layout.
Its workspace is allocated once per stream using the private size query.
No SIMD/FPU context management, batching or page-size change is introduced.

Generate in a fresh directory:

```
python3 tools/prepare-small-table-backend.py --reference /path/to/linux/drivers/block/zram --lz4-header /path/to/matching/include/linux/lz4.h --bits 12 --output /fresh/zram-small
make -j1 -C /usr/src/kernels/EXACT_RELEASE M=/fresh/zram-small CONFIG_ZRAM_BACKEND_LZ4_SMALL=y KCFLAGS=-DCONFIG_ZRAM_BACKEND_LZ4_SMALL=1 modules
```

The output includes scalar-small.patch and an input/content manifest. The
backend cannot be chosen as a default-compressor Kconfig choice. It is experimental.
Use the provided normal-stock restoration runner only after exact-module VM
validation and native recovery checks. Its --algorithms option selects the actual
compiled backends; baseline production swap is restored after each trial job.

The exact stock 7.2.8 ABI build passed diskless VM checks for lz4 and lz4-small,
eight concurrent YMM-state preservation checks, and direct I/O round trips.
Disassembly found no explicit SIMD registers in its compression object. See
benchmarks/results/scalar-small12-validation/summary.json for hashes. VM timing
is not an N100 performance result. Native I/O, pressure, energy, dictionary
fallback and broader malformed-input validation remain required before acceptance.

First native I/O attempt stopped before timing because the generic runner checked
the default algorithm's bracketed sysfs spelling literally. The failure was in
the runner, not an observed codec corruption; stock build ID, swap algorithm and
size were restored. Normalize sysfs brackets before membership checks, preserve
the failed checkpoint, and rerun into a fresh output directory. Extended-metrics
mode requests native counters and continuous thermal/frequency sampling.

## Same-module causal control

Generate the small-table tree first, then add an independently namespaced original-
size control without changing any small-table codec bytes:

```
python3 tools/prepare-small-table-backend.py --reference /fresh/zram-small --lz4-header /path/to/matching/include/linux/lz4.h --bits 14 --control --output /fresh/zram-matched
make -j1 -C /usr/src/kernels/EXACT_RELEASE M=/fresh/zram-matched CONFIG_ZRAM_BACKEND_LZ4_SMALL=y CONFIG_ZRAM_BACKEND_LZ4_CONTROL=y 'KCFLAGS=-DCONFIG_ZRAM_BACKEND_LZ4_SMALL=1 -DCONFIG_ZRAM_BACKEND_LZ4_CONTROL=1' modules
```

This retains lz4 and lz4-small and adds lz4-control with a separate private
namespace, header and workspace. Validate the resulting exact module in the
VM with all three algorithms before native use. The control is experimental,
not a default. It separates much of the cloned-API/compiler effect from the
hash-table-size comparison; actual measurements, not its name, determine validity.

The first two-clone build caught a link-time collision in LZ4_resetStream, which
was global but not EXPORT_SYMBOL and therefore escaped the original export-only
rename list. No failing module was installed. Namespace all public C definitions,
including that unexported helper, and keep a forward prototype for the workspace
query. The fixed build uses a fresh directory and retains the failed build logs.
This changes linkage isolation, not the intended scalar compression algorithm.
