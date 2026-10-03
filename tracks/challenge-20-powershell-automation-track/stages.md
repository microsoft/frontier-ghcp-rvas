# PowerShell automation: Stages

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Understanding and Fixing Existing Scripts](stage-1-understand-and-fix.md) | ⭐⭐ | 45-60 min | Bug-free scripts with inline explanations |
| 2 | [Adding Error Handling and Logging](stage-2-error-handling.md) | ⭐⭐ | 45-60 min | Scripts with structured error handling and verbose logging |
| 3 | [Azure Automation and Compliance](stage-3-azure-automation.md) | ⭐⭐⭐ | 45-60 min | Refactored tagging script with idempotency, validation, and dry-run mode |
| 4 | [Pester Tests and Static Analysis](stage-4-pester-tests.md) | ⭐⭐⭐ | 45-60 min | Passing Pester tests and clean PSScriptAnalyzer output |
| 5 | [Module and CI Pipeline](stage-5-module-and-ci.md) | ⭐⭐⭐ | 45-60 min | PowerShell module with manifest and GitHub Actions CI |

Check generated PowerShell and Pester tests against your AD schema and Azure
naming rules. In Stage 3, you decide which tag differences require a change and
test that repeated runs make no unnecessary updates.

> **Short on time?** Complete Stages 1 and 2 for a solid introduction, then pick either Stage 4 (testing) or Stage 5 (CI) based on what matters more to your team.

---

Previous: [Track Overview](../challenge-20-powershell-automation-track.md) | Next: [Stage 1: Understanding and Fixing Existing Scripts](stage-1-understand-and-fix.md)
