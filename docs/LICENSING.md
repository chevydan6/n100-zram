# Licensing and attribution

New experimental code is GPL-2.0-only as indicated by SPDX headers; COPYING
contains GPL version 2. The Linux-derived LZ4 files retain their original BSD
2-clause copyright and license notices, including upstream LZ4 authorship.
Keep those notices when redistributing derived source or generated patches.
Linux integration follows the kernel's GPL-compatible licensing requirements.

Trueno-ZRAM and Aprender were research references. Their Rust implementation
was not copied. Workspace epoch reuse was informed by upstream LZ4's
LZ4_prepareTable/fast-reset approach; this repository's adaptation targets the
vendored kernel implementation and its private 4 KiB experiment API.
Reference: https://github.com/lz4/lz4/blob/dev/lib/lz4.c (BSD-2-Clause).
Benchmark inputs are deterministic generated data; no user memory was captured.
