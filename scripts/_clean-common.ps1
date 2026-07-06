#
# _clean-common.ps1 -- Shared cleanup logic for clean-start.ps1 and setup-challenge.ps1.
#
# This file is meant to be dot-sourced, not executed directly.
# Requires $RepoRoot to be set before sourcing.

function Invoke-CleanGitHubAndMeta {
    # ── Clean .github ───────────────────────────────────────────────────

    $InstructionsFile = Join-Path $RepoRoot ".github\copilot-instructions.md"
    if (Test-Path $InstructionsFile) {
        Set-Content -Path $InstructionsFile -Value "" -NoNewline
        Write-Host "[OK] Cleared .github/copilot-instructions.md" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .github/copilot-instructions.md not found" -ForegroundColor Yellow
    }

    $AgentsDir = Join-Path $RepoRoot ".github\agents"
    if (Test-Path $AgentsDir) {
        Get-ChildItem -Path $AgentsDir -File -Recurse |
            Where-Object { $_.Name -ne ".gitkeep" } |
            Remove-Item -Force
        Write-Host "[OK] Removed custom agents from .github/agents/" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .github/agents/ not found" -ForegroundColor Yellow
    }

    $SkillsDir = Join-Path $RepoRoot ".github\skills"
    if (Test-Path $SkillsDir) {
        Get-ChildItem -Path $SkillsDir -Recurse | Remove-Item -Recurse -Force
        Write-Host "[OK] Removed custom skills from .github/skills/" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .github/skills/ not found" -ForegroundColor Yellow
    }

    $WorkflowsDir = Join-Path $RepoRoot ".github\workflows"
    if (Test-Path $WorkflowsDir) {
        Remove-Item -Path $WorkflowsDir -Recurse -Force
        Write-Host "[OK] Removed .github/workflows/" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .github/workflows/ not found" -ForegroundColor Yellow
    }

    $PromptsDir = Join-Path $RepoRoot ".github\prompts"
    if (Test-Path $PromptsDir) {
        Remove-Item -Path $PromptsDir -Recurse -Force
        Write-Host "[OK] Removed .github/prompts/" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .github/prompts/ not found" -ForegroundColor Yellow
    }

    # ── Clean non-participant top-level directories and files ───────────

    # Note: byoc/ (Bring Your Own Challenge kit) is intentionally
    # NOT removed here. It is facilitator-facing reference material and is
    # preserved by design in participant workspaces for context about the
    # outcome-driven model.

    $CopilotDir = Join-Path $RepoRoot ".copilot"
    if (Test-Path $CopilotDir) {
        Remove-Item -Path $CopilotDir -Recurse -Force
        Write-Host "[OK] Removed .copilot/" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .copilot/ not found" -ForegroundColor Yellow
    }

    $SquadDir = Join-Path $RepoRoot ".squad"
    if (Test-Path $SquadDir) {
        Remove-Item -Path $SquadDir -Recurse -Force
        Write-Host "[OK] Removed .squad/" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .squad/ not found" -ForegroundColor Yellow
    }

    $PlaywrightDir = Join-Path $RepoRoot ".playwright-mcp"
    if (Test-Path $PlaywrightDir) {
        Remove-Item -Path $PlaywrightDir -Recurse -Force
        Write-Host "[OK] Removed .playwright-mcp/" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .playwright-mcp/ not found" -ForegroundColor Yellow
    }

    $GitattributesFile = Join-Path $RepoRoot ".gitattributes"
    if (Test-Path $GitattributesFile) {
        Remove-Item -Path $GitattributesFile -Force
        Write-Host "[OK] Removed .gitattributes" -ForegroundColor Green
    } else {
        Write-Host "[SKIP] .gitattributes not found" -ForegroundColor Yellow
    }

    # ── Remove git remote origin ────────────────────────────────────────

    try {
        $RemoteUrl = git -C $RepoRoot remote get-url origin 2>$null
        if ($LASTEXITCODE -eq 0) {
            git -C $RepoRoot remote remove origin
            Write-Host "[OK] Removed git remote 'origin' (was: $RemoteUrl)" -ForegroundColor Green
        } else {
            Write-Host "[SKIP] No git remote 'origin' found" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "[SKIP] No git remote 'origin' found" -ForegroundColor Yellow
    }
}
