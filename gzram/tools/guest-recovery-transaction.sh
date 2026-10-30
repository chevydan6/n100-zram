#!/bin/busybox sh
# SPDX-License-Identifier: GPL-2.0-only
# Guest-only transaction prototype. Never use it as a host recovery policy.
set -eu
[ -f /isolated-recovery-guest ] || { echo RECOVERY_GUEST_REFUSED; exit 3; }
grep -q hypervisor /proc/cpuinfo || { echo RECOVERY_GUEST_REFUSED; exit 3; }
[ "$#" = 1 ] || exit 2
case "$1" in normal|inject|term) ;; *) exit 2;; esac
old_panic=$(cat /proc/sys/kernel/panic)
old_oops=$(cat /proc/sys/kernel/panic_on_oops)
old_soft=$(cat /proc/sys/kernel/softlockup_panic)
restore() {
 trap - EXIT HUP INT TERM
 failed=0
 echo "$old_soft" > /proc/sys/kernel/softlockup_panic || failed=1
 echo "$old_oops" > /proc/sys/kernel/panic_on_oops || failed=1
 echo "$old_panic" > /proc/sys/kernel/panic || failed=1
 [ "$(cat /proc/sys/kernel/panic)" = "$old_panic" ] || failed=1
 [ "$(cat /proc/sys/kernel/panic_on_oops)" = "$old_oops" ] || failed=1
 [ "$(cat /proc/sys/kernel/softlockup_panic)" = "$old_soft" ] || failed=1
 if [ "$failed" != 0 ]; then echo RECOVERY_RESTORE_FAILED; exit 1; fi
 echo RECOVERY_RESTORED mode="$1"
}
mode=$1
trap 'restore "$mode"' EXIT
trap 'exit 128' HUP INT TERM
echo 10 > /proc/sys/kernel/panic
[ "$(cat /proc/sys/kernel/panic)" = 10 ]
if [ "$mode" = inject ]; then echo RECOVERY_INJECTED_FAILURE; exit 42; fi
if [ "$mode" = term ]; then echo RECOVERY_SIGNAL_SENT; kill -TERM "$$"; exit 99; fi
echo 1 > /proc/sys/kernel/panic_on_oops
echo 1 > /proc/sys/kernel/softlockup_panic
[ "$(cat /proc/sys/kernel/panic_on_oops)" = 1 ]
[ "$(cat /proc/sys/kernel/softlockup_panic)" = 1 ]
echo RECOVERY_POLICY_APPLIED
