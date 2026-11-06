#!/usr/bin/env bash
# run.sh CASE BEFORE AFTER: the proof for one case. BEFORE and AFTER are checkouts of this
# repository at the commit before the fix and at the fix. The case's repro.sh must fail on
# BEFORE and pass on AFTER, and its suite.sh must pass on AFTER. Writes a table to the job
# summary and exits 0 only when all three come out as expected.
set -uo pipefail
case=$1 before=$(cd "$2" && pwd) after=$(cd "$3" && pwd)
here=$(cd "$(dirname "$0")" && pwd)
summary=${GITHUB_STEP_SUMMARY:-/dev/stdout}
row() { echo "| $1 | $2 | $3 | $4 |" >>"$summary"; }
step() { # step NAME TREE SCRIPT WANT
	echo "::group::$1"
	(cd "$2/cases/$case" && bash "$here/$case/$3" "$here/$case")
	local rc=$?
	echo "::endgroup::"
	local got=pass
	[ $rc -ne 0 ] && got="fail (exit $rc)"
	local ok=yes
	{ [ "$4" = pass ] && [ $rc -ne 0 ]; } && ok=no
	{ [ "$4" = fail ] && [ $rc -eq 0 ]; } && ok=no
	row "$1" "$4" "$got" "$ok"
	[ $ok = yes ]
}
{
	echo "## Proof: $case"
	echo
	echo "Before: \`$(git -C "$before" rev-parse --short HEAD)\`, after: \`$(git -C "$after" rev-parse --short HEAD)\`"
	echo
	echo "| Check | Expected | Got | As expected |"
	echo "|---|---|---|---|"
} >>"$summary"
all=0
step "repro, before the fix" "$before" repro.sh fail || all=1
step "repro, with the fix" "$after" repro.sh pass || all=1
step "suite, with the fix" "$after" suite.sh pass || all=1
exit $all
