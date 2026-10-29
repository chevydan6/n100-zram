# Scalar LZ4 isolated harness validation

Four scalar LZ4 hash-table variants use the same decoder entry while retaining
separate independently decodable compressed frames. The harness randomizes all
compression and decompression tasks each round and restores frames to common
addresses before timing. Seven corpora including three distributed executable
page sets passed 128-page round trips. A 128-call bookkeeping smoke test checked
216 unique rows and random task permutations across three corpora and nine
rounds. Smoke timings are not performance evidence. The separate small-table
normal and sanitizer gates include guarded outputs and independent decoding.
