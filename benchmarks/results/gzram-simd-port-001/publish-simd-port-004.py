import hashlib,json,pathlib,shutil
r=pathlib.Path('/home/dan/n100-zram');d=r/'benchmarks/results/gzram-simd-port-001';d.mkdir()
for src,label in [('astra-simd-port-004-validation','userspace'),('astra-simd-policy-004-validation','policy'),('astra-simd-kernel-001','kernel-build-failed'),('astra-simd-kernel-002','kernel-build')]:
 p=r/'build'/src;target=d/label;target.mkdir()
 if label in ['userspace','policy']:assert json.loads((p/'result.json').read_text())['status']=='passed'
 if label=='kernel-build':assert json.loads((p/'result.json').read_text())['status']=='built'
 for file in p.iterdir():
  if file.is_file() and (file.suffix in ['.json','.log','.py','.asm'] or file.name in ['dispatch.c','selftest.c','adapters.c','module-prototypes.h','Makefile']):shutil.copy2(file,target/file.name)
for n in ['001','002','003','004']:
 p=r/'build'/('astra-simd-port-'+n);target=d/('generation-'+n);target.mkdir()
 for file in p.iterdir():
  if file.is_file() and (file.name=='manifest.json' or file.suffix=='.py'):shutil.copy2(file,target/file.name)
failure=d/'port-build-failed';failure.mkdir()
for p in (r/'build/astra-simd-port-003-validation').iterdir():
 if p.is_file() and p.suffix in ['.json','.log']:shutil.copy2(p,failure/p.name)
for name in ['validate-simd-port-004.py','validate-simd-policy-004.py','run-simd-vm-001.py','publish-simd-port-004.py']:shutil.copy2(r/'build/astra-audit'/name,d/name)
vm=json.loads((r/'build/astra-audit/simd-vm-001-queue.json').read_text());(d/'vm-status.json').write_text(json.dumps(vm,indent=2)+'\n')
for mode in ['fallback','avx2']:
 p=r/('build/astra-simd-vm-001-'+mode)
 if p.exists():
  target=d/('guest-'+mode);target.mkdir()
  for file in p.iterdir():
   if file.is_file() and file.suffix in ['.json','.log']:shutil.copy2(file,target/file.name)
(d/'summary.md').write_text('''# Guarded SIMD workspace port: correctness and build checkpoint

The measured V8 cutoff-2 grouped AVX-bitwise scanner/direct packer now has an
explicit-workspace port. It retains the CTZ sparse decoder and AVX repeat
expansion. A scalar dispatcher checks CPU/OS support and kernel SIMD usability;
only the tentative GZRAM compression and mode-1 decode run inside kernel FPU
entry/exit. Rejected encoding uses private scalar LZ4 after FPU exit. Raw/LZ4
decode and feature-unavailable contexts use the validated scalar path. There is
no cross-page state, queue or format change, and no guessed SIMD crossover.

The general port gate passed normal and ASan/UBSan byte-identity, independent
mask/repeat decoding, truncation/malformed input, guarded boundaries, caller-owned
workspace misuse/reuse and four-thread tests. Both normal dispatch and a forced
feature-unavailable build were tested. Scalar dispatcher/fallback objects have
no SIMD register instructions; only the three designated vector objects do.
Additional runs under policy-specific library names enable the existing test
suite's cutoff/scanner/compact-repeat fixtures. Their exact counts and logs are
retained in policy/. This supplements the earlier general gate rather than
mistaking its generic-name coverage for the full policy suite.

The exact 7.2.11-200.fc44 kernel module builds and passes object isolation audits.
Kernel vector objects use CC_FLAGS_FPU plus AVX2; GCC intrinsic allocation helpers
are excluded, and compiler/header hashes are recorded. The build has no BTF
because matching vmlinux/pahole are unavailable; this does not establish BTF or
compiler portability. Per-function stack reports are not whole-call-chain peaks.
Vector object unresolved symbols contain no LZ4 or kernel FPU entry calls; the
scalar dispatcher owns the FPU boundary. Correctness-only atomic path counters
and a hypervisor gate are added by the builder: this module refuses bare-metal
execution and cannot serve as a native performance module.

Earlier generation/build attempts remain preserved: a source-split newline
assertion, a reviewed mixed-decoder entry correction, signed-pointer declarations
in the extracted LZ4 call, and missing kernel function prototypes. None is
represented as a successful test. Existing SOL/Astra codecs are unchanged.

See vm-status.json for the exact guest gate status. Native SIMD state cost,
user-register preservation across syscall/preemption, critical-section duration,
recovery, energy, allocator-rounded memory and real ZRAM pressure are unproven.
The current stock zstd configuration remains untouched. The next steps are
exact-kernel SIMD/fallback guest gates when headroom permits, a register-state
probe, and recovered native measurement with fresh controls. No speed or energy
claim is made for this generated kernel port.
''')
print(d)
