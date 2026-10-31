# Zstd histogram threshold 3072 candidate

This opt-in x86-64 candidate changes the source-size threshold for switching from simple to four-table histogram counting from 1,500 to 3,072 bytes. Fresh matched userspace zstd 1.5.7 builds and nine randomized same-round observations covered 26 corpora. Candidate and control produced identical frames on all 3,328 checked pages; independent decoding, truncated input, undersized output and canaries were checked. This is finite userspace validation, not full-codec sanitizers or a kernel gate.

The [table](tables.md) shows small, mixed paired compression changes: +0.6% on bash executable, -0.4% on git, +0.5% on libc, -1.0% on sparse words and +0.1% on mixed pages. These short measurements and their Python/ctypes overhead do not establish a broad improvement or energy benefit. This candidate is not promoted to the kernel or normal configuration.
