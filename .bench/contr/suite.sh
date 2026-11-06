# The package's tests with the race detector, three times, as CI runs them (go test -race).
set -euo pipefail
go test -race -count=3 ./internal/app/ghostty/
go vet ./internal/app/ghostty/
