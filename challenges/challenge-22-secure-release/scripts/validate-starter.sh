#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

dotnet restore SecureReleaseReview.sln
dotnet build SecureReleaseReview.sln --no-restore
dotnet test SecureReleaseReview.sln --no-build
dotnet list SecureReleaseReview.sln package --vulnerable --include-transitive || true

printf 'Starter validation completed.\n'
