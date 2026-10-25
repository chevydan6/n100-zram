# Releases and milestones

main tracks reviewed research checkpoints; feature/n100-avx2-zram holds active
experiments. This repository has independent issues, CI and milestones. CI tests
correctness on hosted hardware and makes no N100 performance claims.

No production release is currently validated. A tagged release requires passing
round-trip, malformed-input, guarded-buffer and concurrency validation; native
N100 baseline comparisons with variability; verified stock restoration and
recovery; documented ABI/configuration; and an audited source artifact. Kernel
prototypes must never become the production boot default solely because CI passes.
All unsuccessful trials and material regressions remain documented.
