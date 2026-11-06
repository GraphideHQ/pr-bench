# The whole suite, as CI runs it.
set -euo pipefail
uv sync --locked --extra dev -q
uv run pytest -q -p no:cacheprovider
