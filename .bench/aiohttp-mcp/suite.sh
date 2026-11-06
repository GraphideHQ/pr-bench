# The whole suite, as CI runs it.
set -euo pipefail
python -m venv /tmp/venv-$$ && . /tmp/venv-$$/bin/activate
pip install -q -r requirements.txt
pytest -q -p no:cacheprovider
