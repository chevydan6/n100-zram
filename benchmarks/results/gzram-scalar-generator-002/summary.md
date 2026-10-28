# Scalar port generator maintenance

Explicitly exclude the unused grouped SIMD scan branch before removing vector
helpers. Fail closed on unexpected directive nesting or function shapes; reject
external scanner-experiment macros for scalar ports.

The regenerated reference, CTZ decoder and CTZ packer libraries have exactly the
same .text hashes as the previously validated scalar ports. No SIMD register
instructions occur in those objects. All three regenerated components also pass
the independent guard/oracle/malformed/concurrency suite under ASan/UBSan.
This repairs source compatibility; it adds no kernel performance claim and does
not port the new combined SIMD encoder. Commands, manifests and logs are retained.
