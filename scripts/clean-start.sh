#!/usr/bin/env bash
#
# clean-start.sh -- Reset the .github directory and git remote for a fresh GitHub Copilot Adoption delivery session start.
#
# What it does:
#   1. Creates an empty .github/copilot-instructions.md
#   2. Creates an empty .github/agents/ (keeps .gitkeep when present)
#   3. Creates an empty .github/skills/ (keeps .gitkeep when present)
#   4. Removes Squad workflows from .github/workflows/
#   5. Removes .github/prompts/
#   6. Removes .copilot/, .squad/, .playwright-mcp/, .gitattributes
#   7. Removes the git remote "origin" so you don't accidentally push to the template repo
#   8. Stages and commits the cleaned state so you start with a clean working tree
#
# Usage:
#   chmod +x scripts/clean-start.sh
#   ./scripts/clean-start.sh
#

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# shellcheck source=_clean-common.sh
source "$REPO_ROOT/scripts/_clean-common.sh"

echo "=== GitHub Copilot Adoption Clean Start ==="
echo ""

clean_github_and_meta

# Stage and commit the clean state
git -C "$REPO_ROOT" add -A
git -C "$REPO_ROOT" commit -m "Clean start: reset for GitHub Copilot Adoption delivery session" --quiet
echo "[OK] Committed clean state to local repo"

echo ""
echo "Done. Your repo is clean and committed locally."
echo "Next steps:"
echo "  1. Add your own remote:  git remote add origin <your-repo-url>"
echo "  2. Create repository instructions in .github/copilot-instructions.md"
echo "  3. Create a custom agent in .github/agents/"
echo "  4. Create a custom skill in .github/skills/"
echo "  5. Push when ready:      git push -u origin main"
