#
# clean-start.ps1 -- Reset the .github directory and git remote for a fresh GitHub Copilot Adoption delivery session start.
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
#   .\scripts\clean-start.ps1
#

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

. (Join-Path $PSScriptRoot "_clean-common.ps1")

Write-Host "=== GitHub Copilot Adoption Clean Start ===" -ForegroundColor Cyan
Write-Host ""

Invoke-CleanGitHubAndMeta

# Stage and commit the clean state
git -C $RepoRoot add -A
git -C $RepoRoot commit -m "Clean start: reset for GitHub Copilot Adoption delivery session" --quiet
Write-Host "[OK] Committed clean state to local repo" -ForegroundColor Green

Write-Host ""
Write-Host "Done. Your repo is clean and committed locally." -ForegroundColor Cyan
Write-Host "Next steps:"
Write-Host "  1. Add your own remote:  git remote add origin <your-repo-url>"
Write-Host "  2. Create repository instructions in .github/copilot-instructions.md"
Write-Host "  3. Create a custom agent in .github/agents/"
Write-Host "  4. Create a custom skill in .github/skills/"
Write-Host "  5. Push when ready:      git push -u origin main"
