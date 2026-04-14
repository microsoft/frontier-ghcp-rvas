#
# setup-challenge.ps1 -- Prepare the workspace for a single challenge.
#
# Keeps only the challenge folder, track files, and devcontainer config
# needed for the given challenge. Everything else is removed so users
# see a clean, focused workspace.
#
# Also runs the clean-start logic (empties copilot-instructions.md,
# removes sample agents/skills, detaches the git remote).
#
# Usage:
#   .\scripts\setup-challenge.ps1 -Challenge <devcontainer-folder-name>
#
# Examples:
#   .\scripts\setup-challenge.ps1 -Challenge challenge-1-backend
#   .\scripts\setup-challenge.ps1 -Challenge bonus-5-mumps-banking
#

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Challenge
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

# Mapping tables
$ChallengeMap = @{
    "challenge-0-product-planning"    = "challenge-0-product-planning"
    "challenge-1-backend"             = "challenge-1-web-api"
    "challenge-2-data-science"        = "challenge-2-ml-ai"
    "challenge-3-devops"              = "challenge-3-devops"
    "challenge-4-frontend"            = "challenge-4-frontend"
    "challenge-5-qa"                  = "challenge-5-qa"
    "bonus-1-copilot-sdk"             = "bonus-1-copilot-sdk"
    "bonus-2-flight-delay"            = "bonus-2-flight-delay"
    "bonus-3-team-sprint"             = "bonus-3-team-sprint"
    "bonus-4-tech-sprint"             = "bonus-4-tech-sprint"
    "bonus-5-mumps-banking"           = "bonus-5-mumps-banking"
    "bonus-6-legacy-modernization"    = "bonus-6-legacy-modernization"
    "bonus-7-living-docs"             = "bonus-7-living-docs"
    "bonus-8-pipeline-factory"        = "bonus-8-pipeline-factory"
    "bonus-9-backlog-generator"       = "bonus-9-backlog-generator"
    "bonus-10-ops-assistant"          = "bonus-10-ops-assistant"
    "bonus-11-spec-to-ship"           = "bonus-11-spec-to-ship"
}

$TrackMap = @{
    "challenge-0-product-planning"    = "product-owner-track"
    "challenge-1-backend"             = "backend-developer-track"
    "challenge-2-data-science"        = "data-science-ml-track"
    "challenge-3-devops"              = "devops-platform-track"
    "challenge-4-frontend"            = "frontend-developer-track"
    "challenge-5-qa"                  = "qa-tester-track"
    "bonus-1-copilot-sdk"             = "bonus-copilot-sdk-track"
    "bonus-2-flight-delay"            = "bonus-flight-delay-track"
    "bonus-3-team-sprint"             = "bonus-team-sprint-track"
    "bonus-4-tech-sprint"             = "bonus-tech-sprint-track"
    "bonus-5-mumps-banking"           = "bonus-mumps-modernization-track"
    "bonus-6-legacy-modernization"    = "bonus-legacy-modernization-track"
    "bonus-7-living-docs"             = "bonus-living-docs-track"
    "bonus-8-pipeline-factory"        = "bonus-pipeline-factory-track"
    "bonus-9-backlog-generator"       = "bonus-backlog-generator-track"
    "bonus-10-ops-assistant"          = "bonus-ops-assistant-track"
    "bonus-11-spec-to-ship"           = "bonus-spec-to-ship-track"
}

# Validate input
if (-not $ChallengeMap.ContainsKey($Challenge)) {
    Write-Host "Error: unknown challenge '$Challenge'" -ForegroundColor Red
    Write-Host ""
    Write-Host "Available challenges:" -ForegroundColor Yellow
    $ChallengeMap.Keys | Sort-Object | ForEach-Object { Write-Host "  $_" }
    exit 1
}

$ChallengeDir = $ChallengeMap[$Challenge]
$TrackName = $TrackMap[$Challenge]

Write-Host "=== Challenge Setup: $Challenge ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Challenge folder: challenges/$ChallengeDir"
Write-Host "  Track:            tracks/$TrackName.md"
Write-Host "  DevContainer:     .devcontainer/$Challenge"
Write-Host ""

# Clean .github (same as clean-start.ps1)
$InstructionsFile = Join-Path $RepoRoot ".github\copilot-instructions.md"
if (Test-Path $InstructionsFile) {
    Set-Content -Path $InstructionsFile -Value "" -NoNewline
    Write-Host "[OK] Cleared .github/copilot-instructions.md" -ForegroundColor Green
}

$AgentsDir = Join-Path $RepoRoot ".github\agents"
if (Test-Path $AgentsDir) {
    Get-ChildItem -Path $AgentsDir -File -Recurse |
        Where-Object { $_.Name -ne ".gitkeep" } |
        Remove-Item -Force
    Write-Host "[OK] Removed sample agents from .github/agents/" -ForegroundColor Green
}

$SkillsDir = Join-Path $RepoRoot ".github\skills"
if (Test-Path $SkillsDir) {
    Get-ChildItem -Path $SkillsDir -Recurse | Remove-Item -Recurse -Force
    Write-Host "[OK] Removed sample skills from .github/skills/" -ForegroundColor Green
}

try {
    $RemoteUrl = git -C $RepoRoot remote get-url origin 2>$null
    if ($RemoteUrl) {
        git -C $RepoRoot remote remove origin
        Write-Host "[OK] Removed git remote 'origin'" -ForegroundColor Green
    }
} catch {}

# Remove unrelated challenge folders
$ChallengesDir = Join-Path $RepoRoot "challenges"
Get-ChildItem -Path $ChallengesDir -Directory | ForEach-Object {
    if ($_.Name -ne $ChallengeDir) {
        Remove-Item -Path $_.FullName -Recurse -Force
        Write-Host "[CLEAN] Removed challenges/$($_.Name)" -ForegroundColor DarkGray
    }
}

# Remove unrelated track files and folders
$KeepTrackFiles = @("getting-started.md", "$TrackName.md")
$TracksDir = Join-Path $RepoRoot "tracks"

Get-ChildItem -Path $TracksDir | ForEach-Object {
    $ItemName = $_.Name

    # Keep the track subfolder
    if ($ItemName -eq $TrackName -and $_.PSIsContainer) { return }

    # Keep shared files
    if ($KeepTrackFiles -contains $ItemName) { return }

    Remove-Item -Path $_.FullName -Recurse -Force
    Write-Host "[CLEAN] Removed tracks/$ItemName" -ForegroundColor DarkGray
}

# Remove unrelated devcontainer configs
$DevcontainerDir = Join-Path $RepoRoot ".devcontainer"
Get-ChildItem -Path $DevcontainerDir -Directory | ForEach-Object {
    if ($_.Name -ne $Challenge) {
        Remove-Item -Path $_.FullName -Recurse -Force
        Write-Host "[CLEAN] Removed .devcontainer/$($_.Name)" -ForegroundColor DarkGray
    }
}

# Update .devcontainer/README.md
$ReadmePath = Join-Path $DevcontainerDir "README.md"
@"
# DevContainer Configuration

This workspace is configured for **$Challenge**.

The devcontainer setup has already installed all prerequisites and
cleaned up files from other challenges.
"@ | Set-Content -Path $ReadmePath
Write-Host "[OK] Updated .devcontainer/README.md" -ForegroundColor Green

# Remove files that are not for participants
foreach ($RemoveFile in @("FACILITATOR_GUIDE.md", "CONTRIBUTING.md")) {
    $RemovePath = Join-Path $RepoRoot $RemoveFile
    if (Test-Path $RemovePath) {
        Remove-Item -Path $RemovePath -Force
        Write-Host "[CLEAN] Removed $RemoveFile" -ForegroundColor DarkGray
    }
}

# Replace root README with a focused version
$RootReadme = Join-Path $RepoRoot "README.md"
@"
# GitHub Copilot Enterprise Hackathon

This workspace is set up for your challenge. Everything you don't need
has been removed so you can focus on the task at hand.

## Your Track

**[Start here: tracks/$TrackName.md](tracks/$TrackName.md)**

If this is your first time, read [Getting Started](tracks/getting-started.md) first.

## Quick Copilot Check

Before you begin, verify Copilot is working:

1. Look at the bottom-right of VS Code -- the Copilot icon should say "Ready"
2. Press ``Ctrl+Shift+I`` (or ``Cmd+Shift+I`` on Mac) to open Chat
3. Ask: "Hello, are you working?"

## Resources

- [Copilot Guide](docs/copilot-guide.md)
- [Prompt Engineering Guide](docs/prompt-engineering.md)
- [MCP Servers Guide](docs/mcp-servers.md)
- [Troubleshooting](TROUBLESHOOTING.md)
"@ | Set-Content -Path $RootReadme
Write-Host "[OK] Replaced root README.md" -ForegroundColor Green

Write-Host ""
Write-Host "Done. Your workspace is ready for: $Challenge" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Read tracks/$TrackName.md for the full challenge walkthrough"
Write-Host "  2. Start with tracks/getting-started.md if this is your first time"
