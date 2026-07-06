#
# clean-start.ps1 -- Reset the .github directory and git remote for a fresh RVAS delivery session start.
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
#   .\scripts\clean-start.ps1
#

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

. (Join-Path $PSScriptRoot "_clean-common.ps1")

Write-Host "=== RVAS Clean Start ===" -ForegroundColor Cyan
Write-Host ""

Invoke-CleanGitHubAndMeta

# Stage and commit the clean state
git -C $RepoRoot add -A
git -C $RepoRoot commit -m "Clean start: reset for RVAS delivery session" --quiet
Write-Host "[OK] Committed clean state to local repo" -ForegroundColor Green

Write-Host ""
Write-Host "Done. Your repo is clean and committed locally." -ForegroundColor Cyan
Write-Host "Next steps:"
Write-Host "  1. Add your own remote:  git remote add origin <your-repo-url>"
Write-Host "  2. Write your .github/copilot-instructions.md"
Write-Host "  3. Push when ready:      git push -u origin main"
