# Optimistic speed/size frontier for renderer-page selection

This analysis reuses the [audited renderer userspace observations](../terra-renderer-energy-audited-001/findings.md) to ask how much compression wall time an ideal selector between scalar LZ4 and the existing GHY hybrid could save on those pages, subject to a logical-byte budget. It caps each recorded output at 4,096 bytes for a simple raw-page model and sums the measured per-page batch-average wall times. The comparisons have perfect after-the-fact knowledge, no selection or additional framing cost, and cannot predict a practical policy. Selecting the fastest of noisy single observations can itself exaggerate speed gains.

With no size limit, choosing the faster recorded encoder page by page gives an apparent **13.1%, 13.9%, and 18.4%** reduction in summed compression time in trials 1–3, but increases capped logical bytes by **17.2%, 19.4%, and 28.9%**, respectively, versus scalar LZ4. This is an artificial upper bound based on the measured tasks, not a throughput, application, energy or native ZRAM result.

For a size-constrained bound, the calculation first gives the selector all available size savings from size-reducing choices for free, even when those choices are slower, then permits fractional selection of pages ordered by measured time saved per extra byte. Both relaxations make the result at least as favorable as any actual whole-page selector using those particular recorded results. The byte budgets are relative to the capped scalar LZ4 totals.

| Allowed increase in logical bytes | Trial 1 maximum time reduction | Trial 2 maximum | Trial 3 maximum |
|---:|---:|---:|---:|
| 0% | 1.85% | 0.00% | 0.71% |
| 1% | 3.65% | 2.28% | 2.69% |
| 5% | 7.14% | 6.16% | 6.45% |
| 10% | 10.28% | 9.44% | 9.93% |

For these particular samples and measured tasks, even this optimistic bound is below 7.2% time reduction if capped logical size may increase by no more than 5%. The figures do not justify assuming the 10% real-world target is reachable without a meaningful space tradeoff. They also do not rule out a useful selector on other data, other codec candidates, or actual allocator-rounded memory: size and time are workload-dependent, and the inputs are small, biased, present renderer pages rather than actual reclaim traffic. Userspace Python/ctypes, warm-buffer batching, package background activity and nonindependent samples limit the source measurements; no energy saving follows from this calculation.

`analyze.py` validates recorded page/codec coverage and source audit status, hashes its inputs, and regenerates `bounds.json`. Its fractional bound was also checked against exhaustive whole-page selection for 200 generated seven-page cases, including negative size changes; the bound was never below the exact optimum. These checks validate the calculation, not the representativeness or repeatability of the source observations.
