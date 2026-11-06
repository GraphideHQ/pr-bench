# The caplog tests right after tests/test_additional_findings.py, which leaves the package's
# loggers silenced.
set -euo pipefail
uv sync --locked --extra dev -q
uv run pytest -q -p no:cacheprovider tests/test_additional_findings.py tests/test_validator_chain_guards.py "tests/test_pool_manifest.py::test_an_absent_manifest_is_never_silent"
