#
# setup-challenge.ps1 -- Prepare the workspace for a single challenge.
#
# Keeps the selected challenge and its guides, removing template-only material.
# Repeat setup preserves participant files and Copilot customizations.
#
# Also runs the clean-start logic (creates empty repository instructions,
# agent, and skill locations; removes samples; keeps git remotes).
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
    "challenge-20-powershell-automation" = "challenge-20-powershell-automation"
    "challenge-21-azure-terraform"    = "challenge-21-azure-terraform"
    "challenge-22-secure-release"     = "challenge-22-secure-release"
    "challenge-23-merger-architecture" = "challenge-23-merger-architecture"
    "challenge-24-database-rescue"    = "challenge-24-database-rescue"
    "challenge-25-api-guardrails"     = "challenge-25-api-guardrails"
    "challenge-26-developer-onboarding" = "challenge-26-developer-onboarding"
    "challenge-27-offline-mobile"     = "challenge-27-offline-mobile"
    "challenge-28-work-iq-workplace-assistant" = "challenge-28-work-iq-workplace-assistant"
    "challenge-29-inherit-and-evolve" = "challenge-29-inherit-and-evolve"
    "challenge-30-spec-driven"       = "challenge-30-spec-driven"
}

$TrackFileMap = @{
    "challenge-0-product-planning"    = "challenge-0-product-planning-track"
    "challenge-1-backend"             = "challenge-1-web-api-track"
    "challenge-2-data-science"        = "challenge-2-ml-ai-track"
    "challenge-3-devops"              = "challenge-3-devops-track"
    "challenge-4-frontend"            = "challenge-4-frontend-track"
    "challenge-5-qa"                  = "challenge-5-qa-track"
    "challenge-6-agentic-workflows"   = "challenge-6-agentic-workflows-track"
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
    "challenge-20-powershell-automation" = "challenge-20-powershell-automation-track"
    "challenge-21-azure-terraform"    = "challenge-21-azure-terraform-track"
    "challenge-22-secure-release"     = "challenge-22-secure-release-track"
    "challenge-23-merger-architecture" = "challenge-23-merger-architecture-track"
    "challenge-24-database-rescue"    = "challenge-24-database-rescue-track"
    "challenge-25-api-guardrails"     = "challenge-25-api-guardrails-track"
    "challenge-26-developer-onboarding" = "challenge-26-developer-onboarding-track"
    "challenge-27-offline-mobile"     = "challenge-27-offline-mobile-track"
    "challenge-28-work-iq-workplace-assistant" = "challenge-28-work-iq-workplace-assistant-track"
    "challenge-29-inherit-and-evolve" = "challenge-29-inherit-and-evolve-track"
    "challenge-30-spec-driven"       = "challenge-30-spec-driven-track"
}

$TrackDirMap = @{
    "challenge-0-product-planning"    = "challenge-0-product-planning-track"
    "challenge-1-backend"             = "challenge-1-web-api-track"
    "challenge-2-data-science"        = "challenge-2-ml-ai-track"
    "challenge-3-devops"              = "challenge-3-devops-track"
    "challenge-4-frontend"            = "challenge-4-frontend-track"
    "challenge-5-qa"                  = "challenge-5-qa-track"
    "challenge-6-agentic-workflows"   = "challenge-6-agentic-workflows-track"
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
    "challenge-20-powershell-automation" = "challenge-20-powershell-automation-track"
    "challenge-21-azure-terraform"    = "challenge-21-azure-terraform-track"
    "challenge-22-secure-release"     = "challenge-22-secure-release-track"
    "challenge-23-merger-architecture" = "challenge-23-merger-architecture-track"
    "challenge-24-database-rescue"    = "challenge-24-database-rescue-track"
    "challenge-25-api-guardrails"     = "challenge-25-api-guardrails-track"
    "challenge-26-developer-onboarding" = "challenge-26-developer-onboarding-track"
    "challenge-27-offline-mobile"     = "challenge-27-offline-mobile-track"
    "challenge-28-work-iq-workplace-assistant" = "challenge-28-work-iq-workplace-assistant-track"
    "challenge-29-inherit-and-evolve" = "challenge-29-inherit-and-evolve-track"
    "challenge-30-spec-driven"       = "challenge-30-spec-driven-track"
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
$ChallengePath = Join-Path $RepoRoot "challenges/$ChallengeDir"
$DevcontainerPath = Join-Path $RepoRoot ".devcontainer/$Challenge"
$PreparedPath = Join-Path $RepoRoot ".devcontainer/.workspace-prepared"

if (Test-Path -LiteralPath $PreparedPath) {
    if (-not (Test-Path -LiteralPath $PreparedPath -PathType Leaf)) {
        throw "Invalid workspace marker at '$PreparedPath'."
    }
    $PreparedChallenge = Get-Content -LiteralPath $PreparedPath -Raw
    if ([string]::IsNullOrWhiteSpace($PreparedChallenge)) {
        throw "Invalid workspace marker at '$PreparedPath'."
    }
    $PreparedChallenge = $PreparedChallenge.Trim()
    if ($PreparedChallenge -ne $Challenge) {
        throw "This workspace is prepared for '$PreparedChallenge'. Use a fresh clone for '$Challenge'."
    }
    Write-Host "[SKIP] Workspace already prepared for $Challenge; keeping participant files and customizations."
    exit 0
}

$MissingPaths = @()
if (-not (Test-Path $ChallengePath -PathType Container)) {
    $MissingPaths += "challenges/$ChallengeDir"
}
if (-not (Test-Path $TrackFilePath -PathType Leaf)) {
    $MissingPaths += "tracks/$TrackFileName.md"
}
if (-not (Test-Path $TrackDirPath -PathType Container)) {
    $MissingPaths += "tracks/$TrackDirName"
}
if (-not (Test-Path $DevcontainerPath -PathType Container)) {
    $MissingPaths += ".devcontainer/$Challenge"
}

if ($MissingPaths.Count -gt 0) {
    Write-Host "Error: setup files are missing for '$Challenge':" -ForegroundColor Red
    $MissingPaths | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    exit 1
}

# Older setup versions removed these files without writing a marker.
if (-not (Test-Path (Join-Path $RepoRoot "tracks/README.md")) -and
    -not (Test-Path (Join-Path $RepoRoot "CONTRIBUTING.md"))) {
    [System.IO.File]::WriteAllText($PreparedPath, "$Challenge`n")
    Write-Host "[SKIP] Existing participant workspace detected; keeping files and customizations."
    exit 0
}

Write-Host "=== Challenge Setup: $Challenge ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Challenge folder: challenges/$ChallengeDir"
Write-Host "  Track file:       tracks/$TrackFileName.md"
Write-Host "  Track folder:     tracks/$TrackDirName"
Write-Host "  DevContainer:     .devcontainer/$Challenge"
Write-Host ""

git -C $RepoRoot rev-parse --verify HEAD *> $null
if ($LASTEXITCODE -ne 0) {
    throw "Setup requires a Git checkout with at least one commit. No cleanup was performed."
}

$ChallengeId = $Challenge.Split("-")[1]
$BranchSuffix = [Guid]::NewGuid().ToString("N").Substring(0, 12)
$WorkBranch = "challenge-$ChallengeId-$BranchSuffix"
git -C $RepoRoot switch --no-track -c $WorkBranch
if ($LASTEXITCODE -ne 0) {
    throw "Could not create work branch '$WorkBranch'. No cleanup was performed."
}
Write-Host "[OK] Created work branch '$WorkBranch'; git remotes are unchanged." -ForegroundColor Green

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

Setup keeps the selected challenge and its guides.
Git remotes are unchanged. Work starts on ``$WorkBranch``.
Rebuilding preserves your current branch, files, and Copilot customizations.
"@ | Set-Content -Path $ReadmePath
Write-Host "[OK] Updated .devcontainer/README.md" -ForegroundColor Green

# Remove files that are not for participants
foreach ($RemoveDir in @("web", "byoc")) {
    $RemovePath = Join-Path $RepoRoot $RemoveDir
    if (Test-Path -LiteralPath $RemovePath) {
        Remove-Item -LiteralPath $RemovePath -Recurse -Force
        Write-Host "[CLEAN] Removed $RemoveDir/" -ForegroundColor DarkGray
    }
}

foreach ($RemoveFile in @(
    "CONTRIBUTING.md", "AGENTS.md", "CONTEXT.md", "FACILITATOR_GUIDE.md",
    "learning-paths.json", "role-collections.json", "docs/index.md",
    "docs/challenges", "docs/tracks",
    "scripts/setup-challenge.test.mjs"
)) {
    $RemovePath = Join-Path $RepoRoot $RemoveFile
    if (Test-Path -LiteralPath $RemovePath) {
        Remove-Item -LiteralPath $RemovePath -Force
        Write-Host "[CLEAN] Removed $RemoveFile" -ForegroundColor DarkGray
    }
}

# Replace root README with a focused version
$RootReadme = Join-Path $RepoRoot "README.md"

@"
# GitHub Copilot Adoption

**[Start your challenge](tracks/$TrackFileName.md)**.

Your track explains the stages and links to the starter in
``challenges/$ChallengeDir/``.

Setup created ``$WorkBranch`` and kept your Git remotes.
Check ``git remote -v`` before pushing. Setup does not push or commit changes.

## Setup and Help

- [Shared setup](tracks/getting-started.md)
- [Copilot Guide](docs/copilot-guide.md)
- [Prompt Engineering Guide](docs/prompt-engineering.md)
- [MCP Servers Guide](docs/mcp-servers.md)
- [Troubleshooting](TROUBLESHOOTING.md)
"@ | Set-Content -Path $RootReadme
Write-Host "[OK] Replaced root README.md" -ForegroundColor Green

[System.IO.File]::WriteAllText($PreparedPath, "$Challenge`n")

Write-Host ""
Write-Host "Done. Your workspace is ready for: $Challenge" -ForegroundColor Green
Write-Host ""
Write-Host "Start with tracks/$TrackFileName.md."
