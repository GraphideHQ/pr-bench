# The cache eviction test with 30 ms added to each HTTP request (slow_http.py), as on a loaded
# runner: the "short" token's 50 ms life ends before the test checks the cache.
set -euo pipefail
python -m venv /tmp/venv-$$ && . /tmp/venv-$$/bin/activate
pip install -q -r requirements.txt
PYTHONPATH="$1" pytest -q -p no:cacheprovider -p slow_http "tests/test_validators.py::test_introspection_cache_eviction"
