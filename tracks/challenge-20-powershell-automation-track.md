# Challenge 20 Track: PowerShell Automation

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Using GitHub Copilot to write, debug, test, document, and automate PowerShell scripts for real sysadmin work

## Who Is This For

- Sysadmins and IT Pros who write PowerShell as part of their daily work
- Infrastructure engineers managing Windows environments or hybrid setups
- Anyone who automates Azure resource management with PowerShell
- IT Pros curious about what Copilot can do beyond code completion

## Prerequisites

- PowerShell 7+ installed (or Windows PowerShell 5.1)
- [Pester](https://pester.dev/) installed (`Install-Module Pester -Force`)
- VS Code with the [PowerShell extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.powershell) installed
- Basic familiarity with PowerShell scripting (functions, parameters, pipelines)
- An Azure subscription is helpful for Stage 3 but not required -- you can skip the live `Connect-AzAccount` calls and work entirely with Copilot-assisted refactoring

> ⚠️ **No Active Directory?** Stages 1 and 2 use `Get-ADUser` and `Invoke-Command`. You do not need a real AD environment -- the Pester tests mock these calls. Focus on the logic and test coverage rather than live execution.

## Technology Stack

- **PowerShell 7+** -- scripting language
- **Pester 5** -- PowerShell testing framework
- **Az PowerShell module** -- Azure automation (Stage 3)
- **GitHub Actions** -- CI for script linting and Pester runs (Stage 5)
- **PSScriptAnalyzer** -- static analysis

## Getting Started

A devcontainer is provided for this track. Copy `.devcontainer/challenge-20-powershell-automation/` into `.devcontainer/` in your working repository and reopen in container. It installs PowerShell 7, Pester, PSScriptAnalyzer, the Az module, and the VS Code PowerShell extension automatically.

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-20-powershell-automation/`. The `scripts/` folder has three starter scripts with intentional gaps and bugs. The `tests/` folder has Pester scaffolds. Read through both before writing any instructions, then work through the stages in order.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- PowerShell version and edition (e.g., PowerShell 7 on Linux/macOS, or Windows PowerShell 5.1)
- Target environment (Active Directory, Azure, hybrid, standalone Windows)
- Preferred error handling pattern (`try/catch` with `Write-Error` vs `$ErrorActionPreference = 'Stop'`)
- Logging approach (structured `Write-Verbose`/`Write-Information` vs a custom log function)
- Whether you want comment-based help generated on every function
- Non-negotiable: no `Write-Host` in scripts -- use `Write-Verbose` or `Write-Output` instead

### Suggested Custom Agents

- **PowerShell Expert Agent** -- Knows PowerShell best practices, PSScriptAnalyzer rules, and Pester test patterns, and flags deprecated aliases and anti-patterns. Give it a script; it returns findings. Use it before and after any refactor.
- **Pester Test Writer Agent** -- Writes Pester 5 `Describe`/`Context`/`It` blocks with proper mocking, always covering both happy-path and error-path cases. Give it a function; it proposes the test file. Use it once a function's behavior is settled.
- **Azure Automation Agent** -- Focuses on Az module cmdlets, managed identity auth, and idempotent resource operations. Give it an automation task; it proposes the cmdlet sequence. Use it for Stage 3 work against Azure resources.

### Suggested Custom Skills

- **Script Refactor Skill** -- A fixed sequence: run PSScriptAnalyzer, fix flagged aliases and anti-patterns one at a time, then re-run analysis to confirm a clean pass before touching tests.
- **Comment-Based Help Skill** -- A repeatable workflow: for every function missing documentation, generate comment-based help matching its actual parameters and add a Pester test that verifies the help exists.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "powershell review agent", "pester test skill", and "azure automation instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Start with a comment describing what the function should do, its parameters, and what it should return. Copilot uses this as a spec, not just a hint.
- Ask Copilot to explain an existing script before asking it to fix anything. The `/explain` command on a selected block works well for unfamiliar patterns.
- When writing Pester tests, describe the scenario in plain English in the `Context` string -- Copilot will generate `It` blocks that match.
- PSScriptAnalyzer is strict about aliases (e.g., `?` instead of `Where-Object`). Ask Copilot to "rewrite this without aliases" after generating a script block.
- For Azure cmdlets, be explicit about which module version you are using. The Az module and the older AzureRM module have different cmdlet names -- ambiguity leads to wrong suggestions.
- If Copilot generates a `Write-Host` call, ask it to replace it with `Write-Verbose` or `Write-Output` and explain the difference. This is a common teaching moment.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)

---

Next: [Stages](challenge-20-powershell-automation-track/stages.md)
