# Bitdirect scalar kernel correctness gate

The exact 7.2.11-200.fc44.x86_64 module contains the validated bitmerge control
and bitdirect candidate, both with explicit private LZ4 workspace. There is no
ZRAM registration, module installation, native host load or SIMD codec code.
Module SHA256: 5c396105c7a57f9975df6857c07a9ecbdd351b7a94a2f142d0b549e648be3bc3.

Two diskless VM load/test/unload cycles passed, each with four concurrent workers
and 321,855 total assertions. Existing workspace rejection, independent raw/LZ4
frames, all mask cases, guarded output, generated pages, cross-decoding and
mutation differential checks remain. The new independent nested-repeat cases
cover all four periods, short/tail/full-page lengths, every truncation, one-byte
undersized output and every bit of each outer/nested header byte. The direct
shortcut and old decoder agree on acceptance, output and bounded failures.

The guest used the current host kernel, 256 MiB and two vCPUs, with no disks or
network. Complete logs, commands, generated kernel sources, compiler stack-frame
estimates and input hashes are retained. Kernel code generation contains no SIMD
register instructions. This is not a KASAN kernel; canaries and differential
checks complement, rather than replace, the separate userspace sanitizer gates.
Two existing noinline attribute tokens were normalized to __noinline__ for the
kernel macro namespace, with before/after hashes recorded as in earlier gates.

Host CPU/ZRAM setting hashes match the previous checkpoint and no experimental
host module is loaded. This establishes isolated kernel correctness for the
listed cases only. Native timing, energy, current recovery verification, actual
ZRAM memory pressure, responsiveness and stability validation remain outstanding.
