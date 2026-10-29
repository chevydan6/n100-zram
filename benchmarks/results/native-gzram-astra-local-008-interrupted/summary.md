# Interrupted eighth cohort

The physical laptop suspended for approximately 41 minutes during the first
session. The 2,470.700-second telemetry gap violates the pre-existing continuity
gate. The agent stopped its producer and dependent queued workers; all completed
and partial rows remain here. These measurements are excluded from controlled
performance conclusions. No candidate correctness failure was observed.

A fresh cohort uses the same frozen binaries, corpus, controls and sample counts,
with a temporary logind idle/sleep inhibitor held only for the bounded run.
The earlier omission of this inhibitor was an experiment-launcher error.
No host ZRAM or boot setting was changed.
