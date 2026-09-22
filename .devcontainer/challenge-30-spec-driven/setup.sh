#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
challenge="$repo_root/challenges/challenge-30-spec-driven"

if (( BASH_VERSINFO[0] < 4 )); then
  echo "Challenge setup requires Bash 4 or newer. Use the devcontainer or install a newer Bash." >&2
  exit 1
fi

if [[ "$(node -p 'process.versions.node.split(".")[0]')" != "22" ]]; then
  echo "Challenge 30 requires Node.js 22. Select its devcontainer or install Node.js 22." >&2
  exit 1
fi

if [[ -f "$challenge/.tools/workspace-prepared" || -d "$repo_root/.specify" ]]; then
  echo "Workspace already prepared; keeping participant customizations."
else
  bash "$repo_root/scripts/setup-challenge.sh" challenge-30-spec-driven
  mkdir -p "$challenge/.tools"
  touch "$challenge/.tools/workspace-prepared"
fi

python3 -m venv "$challenge/.tools/python"
"$challenge/.tools/python/bin/python" -m pip install --disable-pip-version-check \
  -r "$challenge/requirements-tools.txt"
npm --prefix "$challenge/.tools/copilot" install --no-audit --no-fund @github/copilot@1.0.88-1
"$challenge/.tools/python/bin/specify" version
"$challenge/.tools/copilot/node_modules/.bin/copilot" --version

cd "$challenge"
npm ci --no-audit --no-fund
npx playwright install --with-deps chromium
npm test
npm run test:ui
echo "Starter ready. Continue with Stage 1 to sign in and initialize Spec Kit."
