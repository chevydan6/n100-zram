# Post-authentication experiment supervisor

Eight fixture cases passed: successful exit, nonzero exit, inherited read-only
counter descriptor, occupied-lock rejection, timeout process-group cleanup,
signal process-group cleanup, initial status creation and status reuse rejection.
The timeout/signal cases include a descendant that ignores SIGTERM; it was
terminated by group cleanup. Private fixture locks and a read-only ordinary file
were used. No native benchmark, RAPL access or machine setting was involved.

The first fixture invocation failed before entering the supervisor because its
bootstrap deferred removal of an argument inside a lambda. Its log is retained.
The corrected bootstrap captures the fixture directory before invoking the tool.
This was a test-harness failure, not a completed experiment or codec failure.

The supervisor must run after authentication and privilege drop. Its measurement
deadline begins when the child starts, independently of authentication and lock
waiting. The runner still acquires the existing exclusive lock atomically; a
competing acquisition can safely reject the launch. This tool neither infers
resume arguments nor overwrites earlier status records or benchmark outputs.

Use the order systemd-inhibit → pkexec → with-rapl.py → supervise.py → run-native.py.
Do not put systemd-inhibit between the counter-opening helper and its child:
it closes inherited descriptors. No new native energy run has yet used this
reusable wrapper; the completed third cohort used the preserved corrected
experiment-specific supervisor.
