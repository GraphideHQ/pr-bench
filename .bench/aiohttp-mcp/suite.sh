# The whole suite as CI runs it, then once more with every HTTP request slowed by 30 ms.
set -euo pipefail
python -m venv /tmp/venv-$$ && . /tmp/venv-$$/bin/activate
pip install -q -r requirements.txt
pytest -q -p no:cacheprovider
PYTHONPATH="$1" pytest -q -p no:cacheprovider -p slow_http tests/test_validators.py
