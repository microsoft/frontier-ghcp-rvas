# Stage 5: Module and CI pipeline

**Difficulty:** ⭐⭐⭐ | **Time:** 45-60 min

Package the three tested scripts into a PowerShell module. Add a GitHub Actions workflow that lints and tests on every push.

## Tasks

1. Use Copilot to complete `ContosoIT.psm1`: dot-source the individual script files and export the three public functions. Ask Copilot to explain why you export specific functions rather than using `Export-ModuleMember -Function *`.
2. Generate a module manifest `ContosoIT.psd1` using `New-ModuleManifest`. Use Copilot to fill in `Author`, `Description`, `PowerShellVersion`, `FunctionsToExport`, and `RequiredModules` (include `Az` for the tagging function). Verify the manifest loads cleanly with `Test-ModuleManifest`.
3. Create `.github/workflows/pester.yml`. The workflow must check out the repo, install Pester and PSScriptAnalyzer, fail on PSScriptAnalyzer `Error` findings, and run `Invoke-Pester` with failures blocking the job. Use Copilot to draft the YAML with `pwsh` steps.
4. Push to a branch and verify the Actions run passes. If it fails, paste the failure output into Copilot Chat and ask it to diagnose the problem.

## Verification

- `Import-Module ./ContosoIT.psm1` imports without error and `Get-Module ContosoIT` shows the three exported functions
- `Test-ModuleManifest ContosoIT.psd1` passes without warnings
- The GitHub Actions workflow installs dependencies, lints, and runs Pester on push in a single `pwsh` job
- The Actions run is green

## What Copilot helps with vs. what requires your judgment

Review generated module installation steps for rate limits and conflicts with
the runner's installed versions. The Pester installation step should use
`-Force -Scope CurrentUser` and may need `-AllowClobber`. Check the YAML before
committing.

---

Previous: [Stage 4: Pester Tests and Static Analysis](stage-4-pester-tests.md)
