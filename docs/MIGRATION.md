# Repository extraction

The ZRAM subtree was extracted with `git subtree split --prefix=zram` from
Fedora development checkpoint `a5298f7`. The nine ZRAM commits retain original
authors, author dates, commit messages and content trees. Commit IDs necessarily
change when the subtree becomes the repository root. The exact correspondence
is in [migration-commits.json](migration-commits.json); every extracted tree was
compared with its original `zram` tree. The original repository history was not
rewritten or deleted. Its main branch and compilation services were untouched.
The former ZRAM branch remains historical; future development happens here.

This project owns its main and feature/n100-avx2-zram branches, GitHub issues,
workflow, release policy and milestones. Builds use vendored LZ4 sources and
explicitly provided Linux source/headers, with no Fedora-project dependency.
Shared test hardware must be serialized using the configurable `--lock` option
of tools/watch-kernel-job.py; acquire the shared infrastructure lock before
starting a test, not merely afterward. A lock path is a deployment setting.
Never cancel another project's build or run concurrent swap/reboot experiments.

## Publication audit

All reachable historical file blobs and the migration working tree were scanned
for credential signatures, private keys, credential assignments, host addresses,
and machine identity values. Findings involving LZ4 token variables and source
code that reads boot IDs were reviewed as code, not leaked identities. Raw
private lab logs, credentials, crash stores, archives and perf.data are excluded.
The recorded recovery directory under /home/dan is a non-secret example path.
Authorship uses the existing GitHub noreply identity. No original Fedora files
outside the ZRAM subtree were imported. This is a best-effort publication audit,
not a guarantee against every possible secret encoding.

Existing negative results, failed experiments, complete published CSVs and
recovery reports remain in history. Private raw diagnostic artifacts remain
outside Git and should be exported only through a reviewed sanitizer.

## Verification checkpoint

The public GitHub main branch was cloned into a separate verification directory.
All nine historical trees matched the recorded originals, and the initial
independent main/feature CI runs passed. The standalone local checkout passed
3,926 round-trip inputs, 20,000 malformed inputs across 20 variants, 158,300
guard-page checks and 24,000 independent four-thread interoperability cases.
The six workspace-reuse variants passed 443,568 guarded byte-identity cases,
70,000 warm calls per variant and 24,000 independent concurrent decodes.

The final historical audit at publication covered 461 unique file blobs with
no flagged findings. The repository is public and has independent main and
feature/n100-avx2-zram branches, issues, milestones and a correctness workflow.
Private raw lab artifacts and the pre-extraction Git bundle remain preserved
outside the repository. Existing Fedora build and dispatch services were still
running after migration; no stop, restart or configuration operation was applied
to them. The old Fedora ZRAM branch is retained for provenance, not active work.
