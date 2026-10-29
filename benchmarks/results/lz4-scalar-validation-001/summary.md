# Fresh scalar LZ4 small-table correctness gate

The 16, 8, 4 and 2 KiB private hash-table candidates passed 64,864 guarded
capacity cases and 32,000 independent concurrent decoding checks, both normally
and with ASan/UBSan. The existing test suite also includes AVX2 counterparts as
controls; scalar remains the development target. Independent liblz4 decoding and
matched 16 KiB byte identity were checked. The original source hashes and logs
are retained. This is userspace correctness, not native kernel stability.

The first fresh timing launcher compiled the benchmark but failed before
measurement because Python's uname result lacks `_asdict`. The failure and both
launcher scripts are retained. The corrected launch reused that compiled binary,
recorded its hash and source hash, and completed the physical run separately.
