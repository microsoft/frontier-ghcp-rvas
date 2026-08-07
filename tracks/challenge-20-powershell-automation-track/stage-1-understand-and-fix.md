# Stage 1: Understanding and Fixing Existing Scripts

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

The `scripts/` folder has three PowerShell scripts inherited from a colleague who left the team. Each one has at least one bug and no tests. Before touching them, use Copilot to understand what each script is supposed to do, then find and fix the problems.

## Tasks

Before you open the first script, use the full setup: keep your repository instructions open for your error-handling and logging conventions, bring in the PowerShell Expert agent for flagging anti-patterns, and run your script refactor skill instead of fixing issues one at a time with no consistent pass.

1. Open `scripts/Get-StaleAccounts.ps1`. Use Copilot (`/explain`) to describe what the script does and what each parameter controls. Identify the date calculation bug and fix it.
2. Open `scripts/Invoke-DiskCleanup.ps1`. Ask Copilot to list every issue it can see. Note the missing output and missing error handling -- you will fix these in Stage 2, but at minimum make the script syntactically correct and runnable.
3. Open `scripts/Set-AzureResourceTags.ps1`. Ask Copilot to explain the risk of calling `Connect-AzAccount` without a `ServicePrincipal` or managed identity context in an automated script. Note what it says for Stage 3.
4. Add comment-based help (`<# .SYNOPSIS ... #>`) to `Get-StaleAccounts.ps1` using Copilot. Verify it appears when you run `Get-Help Get-StaleAccounts`.

## Verification

- Running `Get-StaleAccounts.ps1 -DaysInactive 90` returns accounts whose `LastLogonDate` is more than 90 days in the past (not in the future)
- `Get-Help Get-StaleAccounts` shows a `.SYNOPSIS` and at least one `.PARAMETER` entry
- All three scripts parse without errors (`$null = [System.Management.Automation.Language.Parser]::ParseFile('path', [ref]$null, [ref]$null)` returns no parse errors)

## What Copilot Helps With vs. What Requires Your Judgment

Copilot will catch the date arithmetic bug and explain what `AddDays` with a positive vs. negative argument does. It will also generate comment-based help that looks correct. What it cannot tell you is whether 90 days is the right threshold for your organization's stale account policy -- that decision belongs to your IAM team.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Adding Error Handling and Logging](stage-2-error-handling.md)
