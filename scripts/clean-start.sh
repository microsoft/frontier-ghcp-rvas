#!/usr/bin/env bash
#
# clean-start.sh -- Reset the .github directory and git remote for a fresh RVAS delivery session start.
#
# What it does:
#   1. Empties .github/copilot-instructions.md
#   2. Removes all custom agents from .github/agents/ (keeps .gitkeep)
#   3. Removes all custom skills from .github/skills/
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

echo "=== RVAS Clean Start ==="
echo ""

clean_github_and_meta

# Stage and commit the clean state
git -C "$REPO_ROOT" add -A
git -C "$REPO_ROOT" commit -m "Clean start: reset for RVAS delivery session" --quiet
echo "[OK] Committed clean state to local repo"

echo ""
echo "Done. Your repo is clean and committed locally."
echo "Next steps:"
echo "  1. Add your own remote:  git remote add origin <your-repo-url>"
echo "  2. Write your .github/copilot-instructions.md"
echo "  3. Push when ready:      git push -u origin main"
