# Integer word paths and repeat consolidation

These additive GHY1 prototypes continue the Astra sparse-decoder experiment.
They retain the previous libraries and SOL's controls. Candidate names describe
the tested implementation, not a policy selected for routine use. Performance
and validation status belongs in the dated report, not in the hypotheses below.

| Candidate | Change from wordmixed | Question |
|---|---|---|
| wordrepeat | Expand a fixed repeat pattern into four integer words, then store bounded groups | Can scalar stores replace repeated short memcpy calls profitably? |
| ctzrepeat | wordrepeat plus ctzunpack's sparse decoder | Do the two independent decode changes retain their benefits together? |
| bitpack | Iterate set mask bits when packing scalar sparse groups; copy full masks directly | Does removing absent-lane branches improve scalar encoding? |
| mixpack | bitpack, also using scalar packing after the AVX2 scan | Is scalar packing cheaper than vector permutation plus a bounded temporary copy? |
| repeatmerge | Consolidate a page whose encoded blocks all repeat the same fixed pattern | Can existing per-block proofs recover the short-repeat ratio without another whole-page scan? |

The repeat-store decoder handles every legal GZR1 repeat length, including
noncanonical short blocks which the encoder would not produce. It initializes
only a bounded 32-byte local pattern, then writes complete 32-byte and eight-byte
groups and a possible four-byte tail. It does not overread the compressed pattern.
The AVX2 entry retains the previous mixed decoder's vector repeat helper. Thus
scalar and AVX2 labels remain distinct measured paths; neither is assumed better.
ZRAM normally bypasses compression for same-filled pages, so repeat4/repeat8
microbenchmarks cannot establish an actual ZRAM gain. The repeat16 and repeat32
fixtures exercise patterns beyond a single repeated machine word.

Bit-scan packing visits present words in increasing lane order, preserving exact
wire bytes. Empty masks produce no stores; full masks use a contiguous 32-byte
copy. No sparse/dense crossover is assumed. The new 25%, 50%, and 75% nonzero-word
fixtures deliberately include cases where the hybrid rejects GZRAM and pays for
both the trial and LZ4 fallback.

Repeat consolidation consumes only a successful frame made by the preserved
base encoder. Every block must have the same fixed-repeat tag; comparing each
block's bounded pattern with the first proves that their patterns also match.
Different patterns with identical tags must remain separate. Raw, zero and
mixed-tag frames retain the original result. The successful replacement is
smaller than its existing frame and fits the same output buffer. If that
original encoding cannot fit, the normal fallback still applies: this is not
a guarantee that the encoder succeeds with capacity equal to the smallest
possible representation.

Consolidation uses **the existing GZR1 format**, nested in GHY1, and records a
4096-byte internal block size in the frame. The requested block size controls
the initial scan but may differ from the final stored block size. Old decoders
already read that header and can decode the consolidated page. There is no new
version, cross-page dictionary, shared mutable state, queue or batch. Pages stay
independently recoverable. Processing block size is not the OS memory page size.

Correctness must cover cross-decoding in both directions, exact identity for
the first four candidates, partial final blocks, different patterns under equal
tags, exhaustive sparse masks, short repeat lengths, every truncation, guarded
capacities, malformed frames, concurrency and ASan/UBSan. These checks establish
bounds and compatibility, not kernel readiness.

The follow-up timing screen uses fresh matched controls and records the actual
calls per batch. Shortening a timing batch is an experimental-harness choice,
not a kernel batching optimization. Compare within that cohort, retain every
regression, and check sensitivity before treating small effects as stable.

## Package-energy access

`tools/with-rapl.py` opens only the package energy counter read-only. When started
through pkexec it restores the authenticating user's supplementary groups,
permanently drops real/effective/saved UIDs and GIDs, verifies zero effective
capabilities, and then executes the requested user command. Cohort 002 used this access path; cohort 001 did not.
The updated runner preserves only that explicitly verified descriptor into
benchmark children. Sysfs access
modes and the laptop's power settings remain unchanged. The codec never needs
root. Failure to obtain access remains a missing metric, not zero energy.

RAPL covers the CPU package over the entire timed batch, including measurement
bookkeeping and background work. It is not codec-only energy or laptop battery
energy. The battery telemetry is system context and cannot be assigned to short,
interleaved codec batches. Authentication and descriptor checks occur outside
timing. The original direct-sysfs path remains available for existing runners.

A launch wrapper must preserve the descriptor. `systemd-inhibit` closes unrelated
inherited descriptors, so place it outside `pkexec ... with-rapl.py`, before the
counter is opened, or use a separate bounded inhibitor. The first attempted
cohort-002 launch caught this mismatch and produced no timing data. The corrected
nice/taskset/subprocess chain was checked before the successful run.

## Third candidate set: clustered masks and composition

`ctzfull` adds a contiguous-copy shortcut for mask 255 before the sparse decoder
clears its destination. The extra branch can cost time on ordinary sparse data;
clustered full/zero groups test whether it earns that cost. `bitctz` links the
bitpack encoder with the preserved ctzunpack decoder object; `bitfull` pairs it
with ctzfull. This isolates composition from the repeat-loop code-generation
regression observed in ctzrepeat.

`select2`, `select3`, and `select4` retain the AVX2 scan and choose integer packing
for masks with at most two, three, or four present words, respectively. Denser
masks use the original vector packer. These are whole-codec crossover experiments;
no population cutoff is accepted from instruction counts or synthetic intuition.

`repeatmergefast` retains repeatmerge's exact output but rejects nonrepeat frames
earlier and compares/copies bounded patterns with integer-width operations.
The old helper already used a shift for its power-of-two division: this change
must not be described as removing a runtime division. Both helpers and their
measured overheads remain available as controls.

The appended clustered corpora retain all preceding corpus hashes. Normal and
sanitizer results and all size records are in the third validation checkpoint.
Native timing and energy remain separate acceptance gates.

For targeted energy confirmation, `run-native.py --corpora repeat16 repeat32`
selects explicitly named corpora and records them. Omitting the option clears
inherited corpus filters and retains the full set. A separate benchmark build
with `-DOPS=131072` lengthens the fast repeat batches; all controls in that run
must use the same binary and batch count. This is measurement amortization, not
kernel batching, queueing, or an accepted SIMD crossover. The full 20-corpus
cohort remains necessary to retain regressions outside those repeat cases.

## Fourth candidate set: block selection and combined repeat handling

The third timing cohort rejects per-mask packing cutoffs as general choices:
all three lose roughly 15% on clusters50, and some lose on ordinary word
populations too. `blockpick2/3/4` therefore reuse the completed scan's nonzero
word count to choose a packer once per independent internal block. The thresholds
are experimental averages of two, three or four present words per 32-byte group.
No extra scan or queue is introduced. Full/mixed masks at the same average can
still prefer different packers, so this does not assume that density alone is a
sufficient classifier. Whole-codec measurements must decide.

`bitmerge` composes the bitpack encoder, preserved CTZ decoder and the faster
repeat-consolidation helper. `bitdirect` adds an integer word-store shortcut only
to scalar decoding of a fully validated, one-block GZR1 repeat frame. It checks
nested magic, reserved field, block length, inner/outer decoded lengths, repeat
mode, divisibility and exact payload size before writing. Other frames use the
preserved decoder object; the AVX2 entry retains its existing repeat path.
The extra checks can penalize nonrepeat pages, which is why bitmerge remains a
separate control. Both candidates keep the existing GHY1/GZR1 format and match
repeatmerge's encoded bytes, now confirmed by the fourth correctness/size checkpoint.

Tests add both sides of every aggregate cutoff at all eight internal block
lengths, plus explicit nested-header mutations for the direct shortcut. The
existing independent oracle, cross-decoding, all-mask cases, repeat tails,
truncations, protected boundaries, fuzzing and concurrency remain. Build,
sanitizer, preservation and size checks precede timing; none of these new
policies has an accepted performance result yet.
