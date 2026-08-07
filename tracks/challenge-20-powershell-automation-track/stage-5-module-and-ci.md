# Stage 5: Module and CI Pipeline

**Difficulty:** ⭐⭐⭐ | **Time:** 45-60 min

The three scripts work and are tested. This stage packages them into a proper PowerShell module and adds a GitHub Actions workflow that lints and tests on every push.

## Tasks

1. Use Copilot to complete `ContosoIT.psm1`: dot-source the individual script files and export the three public functions. Ask Copilot to explain why you export specific functions rather than using `Export-ModuleMember -Function *`.
2. Generate a module manifest `ContosoIT.psd1` using `New-ModuleManifest`. Use Copilot to fill in `Author`, `Description`, `PowerShellVersion`, `FunctionsToExport`, and `RequiredModules` (include `Az` for the tagging function). Verify the manifest loads cleanly with `Test-ModuleManifest`.
3. Create `.github/workflows/pester.yml`. The workflow must: check out the repo, install Pester and PSScriptAnalyzer, run PSScriptAnalyzer and fail if any `Error` findings are found, run `Invoke-Pester` and fail if any tests fail. Use Copilot to generate the YAML -- it knows the `pwsh` shell syntax for GitHub Actions steps.
4. Push to a branch and verify the Actions run passes. If it fails, paste the failure output into Copilot Chat and ask it to diagnose the problem.

## Verification

- `Import-Module ./ContosoIT.psm1` imports without error and `Get-Module ContosoIT` shows the three exported functions
- `Test-ModuleManifest ContosoIT.psd1` passes without warnings
- The GitHub Actions workflow runs on push, installs dependencies, runs linting, and runs Pester -- all in a single `pwsh` job
- The Actions run is green

## What Copilot Helps With vs. What Requires Your Judgment

Copilot generates valid GitHub Actions YAML for PowerShell but may suggest installing modules with `Install-Module` in a way that hits rate limits or conflicts with the runner's pre-installed versions. The `pwsh` step that installs Pester should use `-Force -Scope CurrentUser` and may need `-AllowClobber`. Read the generated YAML carefully before committing -- a broken CI workflow is harder to debug than a broken script.

---

Previous: [Stage 4: Pester Tests and Static Analysis](stage-4-pester-tests.md)
