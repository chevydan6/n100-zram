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
