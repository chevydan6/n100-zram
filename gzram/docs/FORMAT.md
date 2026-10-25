# GZRAM-AVX2 experimental format v1

Research prototype, not a standard or an installed ZRAM backend. Maximum source
length is 4096 bytes; memory page size is unchanged. Source/destination buffers
must not overlap. Blocks are independently coded without cross-page dictionaries.
No allocation or mutable codec workspace is required during a call.

Eight-byte header: ASCII GZR1, uint16 little-endian uncompressed byte count,
uint8 block_log (5..12), uint8 flags (0=coded, 1=raw). Raw frames contain exactly
the original bytes after the header. Worst encoded size is input size + 8.

Coded frames have ceil(original_size / 2^block_log) one-byte controls, followed
by block payloads in order. The final block may be shorter. No padding, implicit
safe overread or trailing bytes is permitted. Modes:

| Control | Payload and expansion |
|---|---|
| 0 | Literal block bytes. |
| 1 | No payload; fill the block with zero bytes. |
| 2 | Four-byte pattern repeated; block length divisible by four. |
| 3 | Eight-byte pattern repeated; block length divisible by eight. |
| 4 | One mask byte per 32 decoded bytes, then packed nonzero 4-byte words. |
| 5 | Sixteen-byte repeated pattern; block length divisible by sixteen. |
| 6 | Thirty-two-byte repeated pattern; block length divisible by thirty-two. |

Mode 4 requires a block length divisible by 32. Mask bit i identifies original
word lane i; present words occur in increasing lane order. Mask bytes for the
whole block precede its word payload. Bytes within words are unchanged. Every
mask group expands to eight words; absent words become zero. Noncanonical but
structurally valid encodings are accepted, including a present word holding zero.

The encoder chooses zero, shortest recognized repeat, sparse-word encoding if
smaller, then literal, and falls back to a raw frame if the final frame would not
shrink relative to raw framing. This is a bounded first experiment, not a general
LZ-style match finder. Periodic data outside recognized patterns may compress
poorly; all ratio regressions must be retained. Zero pages are normally elided
by native ZRAM, so zero-page microbenchmarks are not an end-to-end benefit claim.

Scalar and AVX2 encoders emit identical bytes. AVX2 scan compares eight 32-bit
lanes at once; pack/unpack use independently generated VPERMD index tables.
Only bytes actually present in a mask group are read or stored. CPU/OS detection
selects target-attributed AVX2 functions, otherwise scalar fallback applies.
This userspace dispatch does not provide kernel FPU safety. Kernel integration
requires independent state/context handling and evidence of profitability.

Decoder returns the decoded size or -1. Failure may modify a bounded prefix;
callers must discard failed output. Unknown modes/flags/version, bad lengths,
truncation, trailing bytes and insufficient output capacity are rejected.
