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
#   .\scripts\setup-challenge.ps1 -Challenge challenge-11-mumps-banking
#

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Challenge
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

. (Join-Path $PSScriptRoot "_clean-common.ps1")

# Mapping tables
$ChallengeMap = @{
    "challenge-0-product-planning"    = "challenge-0-product-planning"
    "challenge-1-backend"             = "challenge-1-web-api"
    "challenge-2-data-science"        = "challenge-2-ml-ai"
    "challenge-3-devops"              = "challenge-3-devops"
    "challenge-4-frontend"            = "challenge-4-frontend"
    "challenge-5-qa"                  = "challenge-5-qa"
    "challenge-6-agentic-workflows"   = "challenge-6-agentic-workflows"
    "challenge-7-copilot-sdk"         = "challenge-7-copilot-sdk"
    "challenge-8-flight-delay"        = "challenge-8-flight-delay"
    "challenge-9-team-sprint"         = "challenge-9-team-sprint"
    "challenge-10-tech-sprint"        = "challenge-10-tech-sprint"
    "challenge-11-mumps-banking"      = "challenge-11-mumps-banking"
    "challenge-12-legacy-modernization" = "challenge-12-legacy-modernization"
    "challenge-13-living-docs"        = "challenge-13-living-docs"
    "challenge-14-pipeline-factory"   = "challenge-14-pipeline-factory"
    "challenge-15-backlog-generator"  = "challenge-15-backlog-generator"
    "challenge-16-ops-assistant"      = "challenge-16-ops-assistant"
    "challenge-17-spec-to-ship"       = "challenge-17-spec-to-ship"
    "challenge-18-cobol-banking"      = "challenge-18-cobol-banking"
    "challenge-19-wcf-banking"        = "challenge-19-wcf-banking"
    "challenge-21-azure-terraform"    = "challenge-21-azure-terraform"
}

$TrackFileMap = @{
    "challenge-0-product-planning"    = "product-owner-track"
    "challenge-1-backend"             = "backend-developer-track"
    "challenge-2-data-science"        = "data-science-ml-track"
    "challenge-3-devops"              = "devops-platform-track"
    "challenge-4-frontend"            = "frontend-developer-track"
    "challenge-5-qa"                  = "qa-tester-track"
    "challenge-6-agentic-workflows"   = "agentic-workflows-track"
    "challenge-7-copilot-sdk"         = "challenge-7-copilot-sdk-track"
    "challenge-8-flight-delay"        = "challenge-8-flight-delay-track"
    "challenge-9-team-sprint"         = "challenge-9-team-sprint-track"
    "challenge-10-tech-sprint"        = "challenge-10-tech-sprint-track"
    "challenge-11-mumps-banking"      = "challenge-11-mumps-modernization-track"
    "challenge-12-legacy-modernization" = "challenge-12-legacy-modernization-track"
    "challenge-13-living-docs"        = "challenge-13-living-docs-track"
    "challenge-14-pipeline-factory"   = "challenge-14-pipeline-factory-track"
    "challenge-15-backlog-generator"  = "challenge-15-backlog-generator-track"
    "challenge-16-ops-assistant"      = "challenge-16-ops-assistant-track"
    "challenge-17-spec-to-ship"       = "challenge-17-spec-to-ship-track"
    "challenge-18-cobol-banking"      = "challenge-18-cobol-modernization-track"
    "challenge-19-wcf-banking"        = "challenge-19-wcf-modernization-track"
    "challenge-21-azure-terraform"    = "challenge-21-azure-terraform-track"
}

$TrackDirMap = @{
    "challenge-0-product-planning"    = "product-owner-track"
    "challenge-1-backend"             = "backend-developer-track"
    "challenge-2-data-science"        = "data-science-ml-track"
    "challenge-3-devops"              = "devops-platform-track"
    "challenge-4-frontend"            = "frontend-developer-track"
    "challenge-5-qa"                  = "qa-tester-track"
    "challenge-6-agentic-workflows"   = "agentic-workflows-track"
    "challenge-7-copilot-sdk"         = "challenge-7-copilot-sdk-track"
    "challenge-8-flight-delay"        = "challenge-8-flight-delay-track"
    "challenge-9-team-sprint"         = "challenge-9-team-sprint-track"
    "challenge-10-tech-sprint"        = "challenge-10-tech-sprint-track"
    "challenge-11-mumps-banking"      = "challenge-11-mumps-modernization-track"
    "challenge-12-legacy-modernization" = "challenge-12-legacy-modernization-track"
    "challenge-13-living-docs"        = "challenge-13-living-docs-track"
    "challenge-14-pipeline-factory"   = "challenge-14-pipeline-factory-track"
    "challenge-15-backlog-generator"  = "challenge-15-backlog-generator-track"
    "challenge-16-ops-assistant"      = "challenge-16-ops-assistant-track"
    "challenge-17-spec-to-ship"       = "challenge-17-spec-to-ship-track"
    "challenge-18-cobol-banking"      = "challenge-18-cobol-modernization-track"
    "challenge-19-wcf-banking"        = "challenge-19-wcf-modernization-track"
    "challenge-21-azure-terraform"    = "challenge-21-azure-terraform-track"
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
$TrackFileName = $TrackFileMap[$Challenge]
$TrackDirName = $TrackDirMap[$Challenge]
$TrackFilePath = Join-Path $RepoRoot "tracks/$TrackFileName.md"
$TrackDirPath = Join-Path $RepoRoot "tracks/$TrackDirName"
$TrackAssetsPresent = (Test-Path $TrackFilePath) -or (Test-Path $TrackDirPath)

Write-Host "=== Challenge Setup: $Challenge ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Challenge folder: challenges/$ChallengeDir"
Write-Host "  Track file:       tracks/$TrackFileName.md"
Write-Host "  Track folder:     tracks/$TrackDirName"
Write-Host "  DevContainer:     .devcontainer/$Challenge"
Write-Host ""

# Clean .github and non-participant artifacts
Invoke-CleanGitHubAndMeta

# Remove unrelated challenge folders
$ChallengesDir = Join-Path $RepoRoot "challenges"
Get-ChildItem -Path $ChallengesDir -Directory | ForEach-Object {
    if ($_.Name -ne $ChallengeDir) {
        Remove-Item -Path $_.FullName -Recurse -Force
        Write-Host "[CLEAN] Removed challenges/$($_.Name)" -ForegroundColor DarkGray
    }
}

# Remove unrelated track files and folders
$TracksDir = Join-Path $RepoRoot "tracks"

if ($TrackAssetsPresent) {
    $KeepTrackFiles = @("getting-started.md", "$TrackFileName.md")

    Get-ChildItem -Path $TracksDir | ForEach-Object {
        $ItemName = $_.Name

        # Keep the track subfolder
        if ($ItemName -eq $TrackDirName -and $_.PSIsContainer) { return }

        # Keep shared files
        if ($KeepTrackFiles -contains $ItemName) { return }

        Remove-Item -Path $_.FullName -Recurse -Force
        Write-Host "[CLEAN] Removed tracks/$ItemName" -ForegroundColor DarkGray
    }
}
else {
    Write-Host "[WARN] Track content for $Challenge is not in tracks/ yet -- leaving tracks/ intact" -ForegroundColor Yellow
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

# Preserve facilitator-facing reference material
# byoc/ (Bring Your Own Challenge authoring kit) is
# reference material for facilitators to understand the outcome-driven
# model and adapt challenges. It is intentionally preserved in the
# workspace for context, not removed to minimize participant clutter.

# Replace root README with a focused version
$RootReadme = Join-Path $RepoRoot "README.md"

if ($TrackAssetsPresent) {
@"
# GitHub Copilot Adoption

This workspace is set up for your challenge. Everything you don't need
has been removed so you can focus on the task at hand.

## Your Track

**[Start here: tracks/$TrackFileName.md](tracks/$TrackFileName.md)**

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
}
else {
@"
# GitHub Copilot Adoption

This workspace is set up for your challenge. The starter files are ready
under `challenges/$ChallengeDir/`, and the shared docs were left in place
because the dedicated track guide has not been added to `tracks/` yet.

## Start Here

1. Open `challenges/$ChallengeDir/`
2. Read [Getting Started](tracks/getting-started.md)
3. Use the shared docs in `docs/` if you need Copilot or Azure setup help

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
}
Write-Host "[OK] Replaced root README.md" -ForegroundColor Green

Write-Host ""
Write-Host "Done. Your workspace is ready for: $Challenge" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Read tracks/$TrackFileName.md for the full challenge walkthrough"
Write-Host "  2. Start with tracks/getting-started.md if this is your first time"
