# The test file the fix touches, in parallel as CI runs it, and once more with the sequence at 998.
set -euo pipefail
uv sync --locked -q
./scripts/test/stub-data.sh
uv run pytest -q -p no:cacheprovider -o addopts="--ds=main.settings" -n logical learning_resources/views_learningpath_test.py
PYTHONPATH="$1" uv run pytest -q -p no:cacheprovider -o addopts="--ds=main.settings" -p seq_998 learning_resources/views_learningpath_test.py
