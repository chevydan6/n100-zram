# Targeted long-batch harness check

The optional corpus selector preserves all 20 original corpus byte sequences.
Selecting repeat16/repeat32 with LZ4 and repeatmergefast AVX2 passed 512 round
trips and reports only those corpora. A wholly unknown selection is rejected.
The runner additionally rejects partial/duplicate unknown requests and clears
inherited corpus selection when none is requested; these are source-reviewed
checks, not separately executed runner tests in this checkpoint.

The separately built benchmark has 131,072 calls per batch. No performance or
energy result is recorded here. This enables longer matched confirmation of
fast repeat cases, whose 8,192-call energy batches were noisy. It is a userspace
measurement loop, not a kernel batching policy or a measured queueing crossover.
The broad third cohort continues to use frozen 1ee0e34 sources and 8,192 calls.
