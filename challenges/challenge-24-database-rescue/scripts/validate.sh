#!/usr/bin/env bash

set -euo pipefail

CHALLENGE_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$CHALLENGE_ROOT"

python tools/verify_artifacts.py --mode starter
python -m unittest discover -s tests -p 'test_*.py'

SQLFLUFF_COMMAND=""
if command -v sqlfluff >/dev/null 2>&1; then
  SQLFLUFF_COMMAND="$(command -v sqlfluff)"
elif [[ -x "$CHALLENGE_ROOT/.venv/bin/sqlfluff" ]]; then
  SQLFLUFF_COMMAND="$CHALLENGE_ROOT/.venv/bin/sqlfluff"
fi

if [[ -n "$SQLFLUFF_COMMAND" ]]; then
  while IFS= read -r sql_file; do
    "$SQLFLUFF_COMMAND" parse --dialect tsql "$sql_file" >/dev/null
  done < <(find sql -type f -name '*.sql' ! -name '030_run_baseline.sql' | sort)
  echo "PASS: T-SQL parser"
else
  echo "SKIP: sqlfluff is not installed; Python structural checks still passed."
fi
