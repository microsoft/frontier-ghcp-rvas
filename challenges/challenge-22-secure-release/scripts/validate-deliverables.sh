#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
deliverables="$root/deliverables"

required=(
  "threat-model.md"
  "prioritized-findings.md"
  "remediation-and-tests.md"
  "dependency-and-secret-review.md"
  "residual-risk.md"
  "secure-release-checklist.md"
)

missing=0
for file in "${required[@]}"; do
  path="$deliverables/$file"
  if [[ ! -s "$path" ]]; then
    printf 'Missing or empty: deliverables/%s\n' "$file"
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

grep -Eqi 'owner|review date' "$deliverables/residual-risk.md" || {
  printf 'Residual risk record must name an owner or review date.\n'
  exit 1
}

grep -Eqi 'go|no-go|block|release' "$deliverables/secure-release-checklist.md" || {
  printf 'Release checklist must state a release decision or blocking rule.\n'
  exit 1
}

printf 'Deliverable files are present and contain release decision evidence.\n'
