# Interrupted third energy attempt — not an accepted three-session cohort

The authenticated read-only RAPL run completed two sessions of 7,920 rows each.
The third attempt contains 5,376 partial-session rows. All are retained verbatim,
along with telemetry, metadata and logs; no accepted three-session summary or
energy improvement is derived from this incomplete cohort.

The launcher's 3,900-second outer deadline started before desktop authentication.
The long authentication wait consumed that budget, so timeout terminated the
otherwise-running benchmark during session 2. This is a controller failure,
not evidence of a codec crash or an accepted stability result.

A first standby authentication attempt was rejected. The user requested a retry,
which succeeded. That standby then attempted to resume with the registry's
variant ordering rather than the original selected-variant ordering. The
runner's strict input-identity assertion rejected it before collecting replacement
rows. The failed script and traceback are retained; no prior input metadata or
measurements were rewritten to bypass the check.

A fresh retry uses the original selected list, waits for the native lock, starts
its measurement deadline after authentication, and supervises a separate process
group so a timeout cleans up both runner and codec child. Its output is separate
and must satisfy the complete-cohort audit. These partial results do not supply
missing energy values to the completed timing-only cohort.
