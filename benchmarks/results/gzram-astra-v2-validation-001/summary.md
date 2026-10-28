# Follow-up word-path correctness checkpoint

Five additive candidates and reverse wordmixed compatibility passed normal and
ASan/UBSan tests on the physical N100. Each of the six policy tests per build
passed 34,240 cross-decoder round trips, 34,192 guarded encoder capacities,
71,680 exhaustive sparse-mask decode checks, 48,576 repeat/truncation/capacity
checks, 80,000 malformed/mutated decodes and 4,000 four-thread round trips.
Repeatmerge additionally passed 62 direct consolidated-frame checks per build.
Every frame was checked against an independent Python/system-LZ4 decoder.

The complete 329-variant registry passed 715,904 round trips per build over
17 corpora. All eighteen preserved library .text sections are identical to
astra-v1, and artifact hashes match their manifests. The 165,376 per-page size
records retain all 114,688 preceding records unchanged and preserve all sixteen
preceding corpus hashes. These are correctness and size results, not speed or
energy measurements. Raw logs, commands, flags and manifests are retained here.

The sanitizer runtime was privately extracted from verified Fedora RPMs; no
system package was installed. The benchmark uses 8,192 calls per timed batch;
validation does not time these loops. This new batch count is not kernel batching.

A live read-only RAPL handoff succeeded after permanent privilege drop to UID
1000 with zero effective capabilities. A first energy launch failed before
creating timing output because systemd-inhibit closed/reused that descriptor;
the runner rejected the target mismatch. The failure log is retained. A separate
bounded inhibitor avoids this handoff, and a synthetic descriptor test passed
through nice, taskset and nested subprocesses. Synthetic file reads are not
energy data. The next actual cohort must confirm RAPL availability in its rows.
