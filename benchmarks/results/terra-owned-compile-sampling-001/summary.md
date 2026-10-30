# Owned compiler resident-page pilot

Only compiler child processes launched by the sampler were read. The sampler
checked the pagemap present bit before each read, kept raw pages only in process
memory, and wrote neither page contents nor addresses. Each workload compiled
one of three repository C sources using GCC -O3 with a minimal environment;
outputs were temporary. All selected pages round-tripped through independent
LZ4 and GHY decoders. The normal test validated owned-child reading, cc1-only
selection, codec round trips and same-word aggregation. Its first test launch
failed due to `tests/select.py` shadowing Python's standard library; that failed
source and error description are retained.

Run 001 sampled early compile phases. Runs 002–004 used a reservoir of eligible
present-page reads across each compiler child's lifetime, sampled separately
from anonymous private and executable file-backed mappings. Each run selected
64 pages in each class per source. Classes were deliberately sampled equally,
not weighted by resident population; executable file-backed pages may simply be
dropped on reclaim and are not evidence about swap. Shared code pages can be
sampled in more than one process. Sampling perturbs the workload and is neither
a reclaim trace nor a measurement of application responsiveness or energy.

In run 003, among 192 anonymous samples, 37 were same-word pages (which ZRAM
normally handles specially). Of the remaining pages, 78 were GZRAM-mode frames:
71 had larger logical payloads than matched 4 KiB-table LZ4, seven smaller.
Their aggregate payloads were 88,500 versus 59,848 bytes. The other 77 samples
used LZ4 fallback with eight-byte GHY framing. Run 004 independently found 93
GZRAM-mode anonymous frames among 163 non-same-word pages; 89 were larger than
LZ4 and four smaller. Its total capped logical payload was 185,614 versus 138,959
bytes (+33.57%). These are small, intentionally sampled compiler populations,
not an estimate of overall laptop or ZRAM memory use. `min(frame,4096)` is a
logical bound only; ZRAM huge-class behavior and allocator rounding are unmeasured.

A purely hypothetical zero-prefix recurrence rule, applied only to accepted
GZRAM frames above the existing one-quarter-page guard threshold, fired on five
of 46 eligible run-004 anonymous pages. All five hypothetical LZ4 fallbacks
would reduce their combined logical bytes from 8,012 to 4,609, assuming the
matched LZ4 output plus eight-byte framing. It was not implemented in that run,
and no timing, CPU or energy overhead is inferred. Across 29 retained synthetic
and executable corpora the rule fired zero times, while several fixtures had
eligible pages. This warrants careful overhead and adversarial testing rather
than an assumed win; the full aggregate results are in zero-prefix-corpus.json.

No raw user process data or pages from existing applications were collected.
These experiments do not establish a production benefit or the required 10%
real-world acceptance threshold. Browser, application, memory-pressure and
native kernel comparisons remain open.
