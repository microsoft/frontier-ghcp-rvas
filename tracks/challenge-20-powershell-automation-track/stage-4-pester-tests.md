# Stage 4: Pester tests and static analysis

**Difficulty:** ⭐⭐⭐ | **Time:** 45-60 min

The `tests/` folder has Pester scaffold files with empty `It` blocks. Fill them in and add PSScriptAnalyzer to your local workflow.

## Tasks

1. Open `tests/Get-StaleAccounts.Tests.ps1`. Use Copilot to generate mock data for `Get-ADUser` using `Mock`. Fill in each `It` block so that all three `Context` blocks have at least one passing assertion. Run the tests with `Invoke-Pester`.
2. Open `tests/Invoke-DiskCleanup.Tests.ps1`. Mock `Invoke-Command`, `Remove-Item`, `Stop-Service`, and `Start-Service`. Write a test that verifies the script returns a result object with `Status = 'Failed'` when `Invoke-Command` throws.
3. Install PSScriptAnalyzer (`Install-Module PSScriptAnalyzer -Force`) and run `Invoke-ScriptAnalyzer -Path scripts/ -Recurse`. Ask Copilot to fix every warning and error it reports. Common findings: use of `Write-Host`, undefined variables, missing mandatory parameter attributes.
4. Aim for zero `Error` and zero `Warning` severity findings from PSScriptAnalyzer across all three scripts.

## Verification

- `Invoke-Pester -Path tests/` runs without infrastructure dependencies and all tests pass
- The test for the "unreachable machine" scenario returns `Status = 'Failed'` without throwing
- `Invoke-ScriptAnalyzer -Path scripts/ -Severity Warning,Error` returns no results

## What Copilot helps with vs. what requires your judgment

Copilot can draft Pester `Mock` setups. Check which cmdlets the remote
`Invoke-Command` blocks actually call and mock those dependencies. Mocks inside
`BeforeAll` do not automatically apply inside `Invoke-Command` scriptblocks.

---

Previous: [Stage 3: Azure Automation and Compliance](stage-3-azure-automation.md) | Next: [Stage 5: Module and CI Pipeline](stage-5-module-and-ci.md)
