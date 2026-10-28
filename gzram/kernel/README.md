# Isolated scalar component gate

This self-test is an engineering gate for the userspace-validated GZR1 core.
It does not implement the GHY1 container, LZ4 fallback, a crypto registration,
ZRAM integration or a performance interface. It is not a native-use candidate.

`build-scalar-selftest.py` copies previously validated scalar port outputs,
verifies their manifest hashes, and builds separately namespaced control and
candidate objects with matched integer-only compiler flags. The build record
pins the source manifests, self-test source, module hash, compiler and vermagic.
Disassembly checks this module's instructions for SIMD register references;
external kernel routines are outside that static audit.

Each module load starts four workers with private buffers and deterministic
seeds. They check every sparse mask against independently constructed frames,
every frame truncation, output capacity 31/32, variable-length round trips,
reference/candidate wire identity, cross-decoding and mutation differentials.
Output canaries check writes beyond the advertised capacity. These canaries do
not detect out-of-bounds reads; userspace guard-page/sanitizer tests cover that
separate concern. This VM kernel is not a KASAN build. Worker completion is joined
with kthread_stop before module initialization returns, including partial launch
failures, so immediate unloading cannot leave a worker executing module text.

`vm-scalar-selftest.py` holds the existing native-validation lock and requires
2 GiB available host memory. It boots a 256 MiB, two-vCPU KVM guest with the exact
kernel image, static BusyBox and this module, without host disks or networking.
Two load/test/unload cycles must pass. Guest warnings, oopses, panics, test
failures and a 180-second deadline fail the gate; logs and input hashes remain.
AVX2 is hidden from the guest because this gate tests the scalar component.

The scripts never load a module into the host. Passing this gate would establish
bounded component correctness coverage in that guest, not native recovery,
whole-codec speed, ZRAM behavior or production readiness. Native recovery and
stock configuration checks remain required before any later host kernel trial.
