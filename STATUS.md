# Status

## Completed research checkpoint

- Dedicated branch `feature/n100-avx2-zram`, isolated from the active build queue.
- SSH access to the physical Intel N100 verified; CPUID AVX2 and OS YMM support
  verified by the native benchmark.
- Existing custom kernel located, preserving the known-good stock default.
- Trueno-ZRAM and Aprender source inspected, with versions recorded below.
- Scalar/SSE2/AVX2/count-only variants built locally and on the N100.
- Native initial correctness suite: 3,926 inputs, cross-variant round trips,
  byte-identical compressed output, 20,000 malformed-input differential checks.
- First native exploratory timing data preserved, including regressions.
- Local and native guard-page suites each passed 31,660 checks.

## Actual target state

Fedora kernel `7.0.10-201.fc44.x86_64` is active. The installed custom
`7.2.8-n100v1.fc44` kernel has not been validated as booted. The current desktop
is Xfce. ZRAM uses lzo-rle, approximately 3.7 GiB logical size, with disk swap as
a secondary device. These differ from the mission's assumed active custom
kernel, KDE desktop and LZ4 configuration.

## Constraints and next actions

SSH is unprivileged; `sudo -n true` requires authentication. Administrator access
is needed for module loading, controlled ZRAM devices and kernel installation.
Recovery/automatic rollback is not yet verified. No experimental boot or active
swap replacement has occurred. Meanwhile continue bounded native user-space
experiments, sanitizer/boundary tests, source analysis and integration design.

Next: short-match dispatch, independent copy-width experiments, real executable
page corpus, repeated controlled runs, paired uncertainty estimates, and an
in-kernel benchmark that accounts for SIMD entry/exit overhead. No kernel or
end-to-end ZRAM performance improvement is established.
