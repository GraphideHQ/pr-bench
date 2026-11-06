# The two watch tests with a 50 ms pause before the test gives the view's size, as a loaded
# machine can pause there: without the fix the first attach goes out at the default 80x24.
set -euo pipefail
f=internal/app/ghostty/conn_test.go
cp "$f" /tmp/conn_test.go.orig
trap 'cp /tmp/conn_test.go.orig "$f"' EXIT
awk '/^func TestWatch(KeepsTheCoreSize|TakesOverOnTheFirstKey)\(/ {inside=1} inside && /c, st, scr := startWatch/ {print; print "\ttime.Sleep(50 * time.Millisecond) // pr-bench repro: a loaded machine pauses here"; inside=0; next} {print}' /tmp/conn_test.go.orig >"$f"
grep -c 'pr-bench repro' "$f"
go test -count=1 -run '^(TestWatchKeepsTheCoreSize|TestWatchTakesOverOnTheFirstKey)$' ./internal/app/ghostty/
