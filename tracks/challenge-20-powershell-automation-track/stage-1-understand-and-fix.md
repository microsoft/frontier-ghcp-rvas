# Stage 1: Understanding and fixing existing scripts

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

The `scripts/` folder has three PowerShell scripts inherited from a colleague who left the team. Each one has at least one bug and no tests. Before touching them, use Copilot to understand what each script is supposed to do, then find and fix the problems.

## Tasks

Use your repository instructions for error-handling and logging conventions. Have the PowerShell Expert agent flag anti-patterns, then run the script refactor skill to check each change.

1. Open `scripts/Get-StaleAccounts.ps1`. Use Copilot (`/explain`) to describe what the script does and what each parameter controls. Identify the date calculation bug and fix it.
2. Open `scripts/Invoke-DiskCleanup.ps1`. Have Copilot identify issues, then check its findings. Make the script syntactically correct and runnable. Record the missing output and error handling for Stage 2.
3. Open `scripts/Set-AzureResourceTags.ps1`. Ask Copilot to explain the risk of calling `Connect-AzAccount` without a `ServicePrincipal` or managed identity context in an automated script. Note what it says for Stage 3.
4. Add comment-based help (`<# .SYNOPSIS ... #>`) to `Get-StaleAccounts.ps1` using Copilot. Verify it appears when you run `Get-Help Get-StaleAccounts`.

## Verification

- Running `Get-StaleAccounts.ps1 -DaysInactive 90` returns accounts whose `LastLogonDate` is more than 90 days in the past (not in the future)
- `Get-Help Get-StaleAccounts` shows a `.SYNOPSIS` and at least one `.PARAMETER` entry
- All three scripts parse without errors (`$null = [System.Management.Automation.Language.Parser]::ParseFile('path', [ref]$null, [ref]$null)` returns no parse errors)

## What Copilot helps with vs. what requires your judgment

Copilot can explain how positive and negative `AddDays` arguments affect the date and draft comment-based help. Verify both against the script. Your IAM team decides whether 90 days is the right stale-account threshold.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Adding Error Handling and Logging](stage-2-error-handling.md)
