# Preserved bounded-trial validation failure

The normal build and preservation audit succeeded, but the first candidate test
stopped with a Python TypeError: a newly added fixture loop replaced the existing
`period` byte corpus with an integer. No codec mismatch was reported before the
exception. This is not a completed correctness gate. The failed test source,
commands, logs and hashes are retained. The corrected run reuses unchanged
normal codec artifacts after hash checks and reruns the affected test suite;
sanitizer/registry/size gates remain required.
