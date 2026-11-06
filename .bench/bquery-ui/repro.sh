# The form-submission test file on its own, so no earlier file has registered bq-switch.
set -euo pipefail
bun install --frozen-lockfile >/dev/null
bun test tests/form-submission.test.ts
