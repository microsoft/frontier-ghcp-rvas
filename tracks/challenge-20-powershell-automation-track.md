# Challenge 20 track: PowerShell automation

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Use GitHub Copilot to write, debug, test, document, and automate PowerShell scripts for system administration

## Who is this for

- Sysadmins and IT Pros who write PowerShell as part of their daily work
- Infrastructure engineers managing Windows environments or hybrid setups
- Anyone who automates Azure resource management with PowerShell
- IT Pros curious about what Copilot can do beyond code completion

## Prerequisites

- PowerShell 7+ installed (or Windows PowerShell 5.1)
- [Pester](https://pester.dev/) installed (`Install-Module Pester -Force`)
- VS Code with the [PowerShell extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.powershell) installed
- Basic familiarity with PowerShell scripting (functions, parameters, pipelines)
- An Azure subscription is optional for Stage 3. Without one, skip live `Connect-AzAccount` calls and work on refactoring.

> ⚠️ **No Active Directory?** Stages 1 and 2 use `Get-ADUser` and `Invoke-Command`. The Pester tests mock these calls, so you can test the logic without a real AD environment.

## Technology stack

- **PowerShell 7+** -- scripting language
- **Pester 5** -- PowerShell testing framework
- **Az PowerShell module** -- Azure automation (Stage 3)
- **GitHub Actions** -- CI for script linting and Pester runs (Stage 5)
- **PSScriptAnalyzer** -- static analysis

## Getting started

A devcontainer is provided for this track. Copy `.devcontainer/challenge-20-powershell-automation/` into `.devcontainer/` in your working repository and reopen in container. It installs PowerShell 7, Pester, PSScriptAnalyzer, the Az module, and the VS Code PowerShell extension automatically.

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-20-powershell-automation/`. The `scripts/` folder has three starter scripts with intentional gaps and bugs. The `tests/` folder has Pester scaffolds. Read through both before writing any instructions, then work through the stages in order.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- PowerShell version and edition (e.g., PowerShell 7 on Linux/macOS, or Windows PowerShell 5.1)
- Target environment (Active Directory, Azure, hybrid, standalone Windows)
- Preferred error handling pattern (`try/catch` with `Write-Error` vs `$ErrorActionPreference = 'Stop'`)
- Logging approach (structured `Write-Verbose`/`Write-Information` vs a custom log function)
- Whether you want comment-based help generated on every function
- Require `Write-Verbose` or `Write-Output` instead of `Write-Host` in scripts

### Suggested custom agents

- **PowerShell Expert Agent** -- Knows PowerShell best practices, PSScriptAnalyzer rules, and Pester test patterns, and flags deprecated aliases and anti-patterns. Give it a script; it returns findings. Use it before and after any refactor.
- **Pester Test Writer Agent** -- Writes Pester 5 `Describe`/`Context`/`It` blocks with proper mocking, always covering both happy-path and error-path cases. Give it a function; it proposes the test file. Use it once a function's behavior is settled.
- **Azure Automation Agent** -- Focuses on Az module cmdlets, managed identity auth, and idempotent resource operations. Give it an automation task; it proposes the cmdlet sequence. Use it for Stage 3 work against Azure resources.

### Suggested custom skills

- **Script Refactor Skill** -- A fixed sequence: run PSScriptAnalyzer, fix flagged aliases and anti-patterns one at a time, then re-run analysis to confirm a clean pass before touching tests.
- **Comment-Based Help Skill** -- A repeatable workflow: for every function missing documentation, generate comment-based help matching its actual parameters and add a Pester test that verifies the help exists.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "powershell review agent", "pester test skill", and "azure automation instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Start with a comment that describes the function's behavior, parameters, and return value.
- Ask Copilot to explain an existing script before asking it to fix anything. The `/explain` command on a selected block works well for unfamiliar patterns.
- Describe each Pester scenario in the `Context` string, then check that generated `It` blocks test it.
- PSScriptAnalyzer is strict about aliases (e.g., `?` instead of `Where-Object`). Ask Copilot to "rewrite this without aliases" after generating a script block.
- Specify the module version for Azure cmdlets. The Az module and older AzureRM module use different cmdlet names.
- If Copilot generates a `Write-Host` call, ask it to replace it with `Write-Verbose` or `Write-Output`. Check that the replacement fits the intended output.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-20-powershell-automation-track/stages.md)
