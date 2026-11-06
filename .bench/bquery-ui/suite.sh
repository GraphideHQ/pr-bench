# Every test file, as CI runs them, and then each file on its own.
set -euo pipefail
bun install --frozen-lockfile >/dev/null
bun test
for f in $(find . -name "*.test.ts" -not -path "./node_modules/*" | sort); do bun test "$f" >/dev/null || { echo "alone: $f failed"; exit 1; }; done
echo "every test file passes on its own"
