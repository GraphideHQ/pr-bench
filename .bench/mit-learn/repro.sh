# The bad-data test with the LearningResource id sequence at 998 (seq_998.py), so the test's
# own learning path gets id 999.
set -euo pipefail
uv sync --locked -q
./scripts/test/stub-data.sh
PYTHONPATH="$1" uv run pytest -q -p no:cacheprovider -o addopts="--ds=main.settings" -p seq_998 \
	"learning_resources/views_learningpath_test.py::test_learning_path_items_endpoint_create_item_bad_data"
