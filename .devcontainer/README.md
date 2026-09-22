# DevContainer Configurations

This folder contains dedicated DevContainer configurations for each GitHub Copilot Adoption challenge.

## Available Configurations

Select the configuration that matches the challenge you are working on.

### [Challenge 0: Product Planning](./challenge-0-product-planning/)

**For:** Product Owners, Business Analysts, Project Managers.

- **Tools:** GitHub CLI, Node.js LTS
- **Extensions:** Markdown All in One, Mermaid, markdownlint

### [Challenge 1: Backend Developer](./challenge-1-backend/)

**For:** Node.js or Python API development.

- **Tools:** Node.js LTS, Python 3.11
- **Extensions:** Python, ESLint, REST Client

### [Challenge 2: Data Science & ML](./challenge-2-data-science/)

**For:** Jupyter Notebooks and ML models.

- **Tools:** Python 3.11, Jupyter, Pandas, Scikit-learn
- **Extensions:** Jupyter, Pylance

### [Challenge 3: DevOps & Platform](./challenge-3-devops/)

**For:** Infrastructure as Code and Containerization.

- **Tools:** Terraform, Docker (DinD), Kubectl, Helm
- **Extensions:** Terraform, Docker, Kubernetes, YAML

### [Challenge 4: Frontend Developer](./challenge-4-frontend/)

**For:** React and TypeScript development.

- **Tools:** Node.js 20
- **Extensions:** ESLint, Prettier, Tailwind CSS

### [Challenge 5: QA & Test Automation](./challenge-5-qa/)

**For:** Testing the eShopOnWeb (.NET) application.

- **Tools:** .NET 8.0 SDK, Playwright
- **Extensions:** C# Dev Kit, Playwright Test

### [Challenge 6: Agentic Workflows](./challenge-6-agentic-workflows/)

**For:** Building AI-powered repository automation with GitHub Agentic Workflows.

- **Tools:** Node.js LTS, Python 3.11, GitHub CLI, `gh-aw` extension
- **Extensions:** Markdown lint, YAML, Mermaid

### [Challenge 20: PowerShell Automation](./challenge-20-powershell-automation/)

**For:** Sysadmins and IT Pros writing PowerShell to manage Windows environments or Azure resources.

- **Tools:** PowerShell 7 (Linux), Azure CLI, GitHub CLI, Pester 5, PSScriptAnalyzer, Az module
- **Extensions:** PowerShell, Pester Test Explorer

### [Challenge 21: Azure Terraform](./challenge-21-azure-terraform/)

**For:** Cloud and platform engineers building Azure infrastructure with Terraform.

- **Tools:** Terraform, Azure CLI, GitHub CLI
- **Extensions:** Terraform, YAML

### [Challenge 29: Inherit and Evolve an Application](./challenge-29-inherit-and-evolve/)

**For:** C# developers taking over an unfamiliar application.

- **Tools:** .NET 10 SDK, GitHub CLI, Docker CLI using the host engine
- **Extensions:** C# Dev Kit, GitHub Copilot, REST Client, markdownlint
- **Application:** Equipment booking on port 5080, with local SQLite storage

Setup prepares a challenge-only workspace and runs the starter tests. Use a
disposable clone: setup removes unrelated challenges and organizer files.
The [track guide](../tracks/challenge-29-inherit-and-evolve-track.md) covers startup
and the separate application container.

### [Challenge 30: Spec-Driven Feature Delivery with GitHub Spec Kit](./challenge-30-spec-driven/)

**For:** Developers adopting a spec-driven workflow with Copilot CLI.

- **Tools:** Node.js 22, Python 3.12, uv, Spec Kit 1.0.9, Copilot CLI 1.0.88-1
- **Application:** Service Desk on port 5080, with in-memory demo data

Select this configuration directly; keep `setup.sh` in its challenge subfolder.
First-time setup removes unrelated content and installs the pinned tools.
Rebuilding a prepared workspace preserves participant customizations. Setup
checks the starter but leaves Spec Kit initialization to
[Stage 1](../tracks/challenge-30-spec-driven-track/stage-1-baseline.md).

## How to Use

1. **Copy the Folder**: Copy the contents of the specific challenge folder (e.g., `.devcontainer/challenge-1-backend/`) into the `.devcontainer/` folder of your own repository.
   - *Example*: `cp -r .devcontainer/challenge-1-backend/* .devcontainer/`

2. **Reopen in Container**: Open VS Code, press `F1`, and select **Dev Containers: Reopen in Container**.
