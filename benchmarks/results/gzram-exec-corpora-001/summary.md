# Additional executable-page fixture generator

Generation validation passed 17 invalid ELF cases, independent readelf program
header checks, exact-byte checks, 128 unique selected pages each for Bash, Git
and libc, and refusal to overwrite an existing output. The manifest records
input hashes and selected offsets; raw executable bins remain local.

These evenly distributed file-backed executable-segment pages supplement the
existing first-512-KiB fixtures. They are not relocated process memory, anonymous
heap pages, or a representative reclaim distribution. EOF tails are zero-filled;
BSS-only pages are excluded. Existing corpora are unchanged. No codec timing has
yet used these additional fixtures.
