# Empty kernel FPU section: correctness gate, no performance result

The probe now exposes a separate empty kernel_fpu_begin()/kernel_fpu_end()
control, guarded by irq_fpu_usable(). Scalar codec operations do not enter that
section. The original no-op remains a matched interface control. No vector
compression, queue, batch of pages or ZRAM registration is introduced.

The exact-kernel build and two isolated gates passed with AVX2 available to the
userspace callers. Each gate loaded, tested and unloaded the module twice:

- Interface client: all 20 preserved corpus hashes, 101,073 assertions per cycle,
  shared-file and separate-file concurrency including the empty FPU operation,
  invalid pointers/lengths/commands and post-operation integrity.
- Measurement client: all 20 corpora, 29,084 assertions per cycle, preservation of
  all sixteen YMM registers plus deliberately nondefault MXCSR and x87 control
  values around each operation. Original controls are restored before returning
  from the check. Explicit attempts to collect VM timings were rejected.

All eight preceding codec object text sections remain byte-identical to the
non-FPU probe build. The new module references all three required kernel FPU
APIs and contains no codec SIMD-register instructions. The preliminary client
build, before strengthening control-register checks, is retained separately;
only the second client build was used for these gates.

--fpu-control opts the measurement client into the eighth operation, reported
as variant interface-fpu / operation noop. It shuffles that control with the
ordinary interface and six codec/direction combinations under the same three
userspace vector conditions. --ops controls repeated one-page syscalls, not
pages compressed within a kernel FPU section. No timing or energy crossover,
optimal batch size or FPU amortization result has been measured or inferred.
No-op values must remain separate; do not subtract them to claim codec-only
latency. Later native results still include mutex/cursor and scheduling costs.

The guest used the exact 7.2.11 kernel, 256 MiB and two vCPUs, no disks/network,
and bounded runs. Only expected unsigned/out-of-tree taint messages appeared;
no warning/oops/panic occurred. It is not a KASAN kernel. These checks cover the
listed state components and interface cases, not every CPU state or failure mode.
Host ZRAM/CPU hashes are unchanged and no experimental host module was loaded.
Current recovery verification and controlled physical measurements remain open.
