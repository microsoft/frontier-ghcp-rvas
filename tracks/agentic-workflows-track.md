# Agentic Workflows Track

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Build and operate GitHub Agentic Workflows -- Markdown-defined, AI-powered repository automation running in GitHub Actions

> This track requires a GitHub repository with GitHub Actions enabled. All work happens on GitHub -- agentic workflows cannot run locally.

## Who Is This For

- Developers and DevOps engineers who want to automate repository maintenance with AI
- Teams exploring "Continuous AI" as a complement to CI/CD
- Anyone comfortable with GitHub Actions, Markdown, and YAML who wants to understand how coding agents can run safely in automated pipelines

## Prerequisites

- Familiarity with GitHub (Issues, Pull Requests, Actions)
- Basic understanding of CI/CD concepts
- A GitHub account with Copilot access
- A GitHub repository with real code to work with (from a previous challenge or a fork of an open-source project)

## Technology Stack

- **GitHub Agentic Workflows** (`gh-aw` CLI extension)
- **GitHub Actions** (runtime environment for agentic workflows)
- **Markdown** (workflow definition language)
- **GitHub Copilot** (or Claude/Codex as the agent engine)
- **GitHub CLI** (`gh`) for workflow management

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should describe:

- The repository you are adding agentic workflows to (what does the code do, what language, what frameworks)
- The types of automation you want (triage, documentation, code quality, CI monitoring)
- Security constraints: read-only permissions, safe outputs only, scoped labels

### Suggested Agents

- **Workflow Author Agent** -- Knows the GitHub Agentic Workflows frontmatter schema, safe-output types, and permission model. Helps write and debug workflow Markdown files.
- **Security Reviewer Agent** -- Reviews agentic workflow files for permission creep, missing safe-output constraints, and potential prompt injection vectors.

### Open the Challenge

Navigate to `challenges/challenge-6-agentic-workflows/`. Read the [functional specification](../challenges/challenge-6-agentic-workflows/docs/functional-spec.md) before starting Stage 1.

You need a GitHub repository to work in. If you do not have one ready, see the [getting started guide](../challenges/challenge-6-agentic-workflows/docs/getting-started.md) for options.

> **GitHub is required.** Agentic workflows run as GitHub Actions -- all workflow files must be pushed to a GitHub repository. You will create workflow files locally (or in a Codespace), but they only execute on GitHub after you push.

---

## Stages

| Stage | Name | Duration | What You Build |
|-------|------|----------|---------------|
| 1 | [Setup and First Workflow](agentic-workflows-track/stage-1-setup-first-workflow.md) | 1 hour | Install `gh-aw`, create a daily status report workflow |
| 2 | [Issue and PR Management](agentic-workflows-track/stage-2-issue-pr-management.md) | 1.5 hours | Issue triage, PR review workflows |
| 3 | [Code Quality and Documentation](agentic-workflows-track/stage-3-code-quality-docs.md) | 1.5 hours | Code simplifier, test improver, documentation updater |
| 4 | [CI Monitoring and ChatOps](agentic-workflows-track/stage-4-ci-monitoring-chatops.md) | 1.5 hours | CI Doctor, ChatOps commands |
| 5 | [Security and Advanced Patterns](agentic-workflows-track/stage-5-security-advanced.md) | 1.5 hours | Security scan, custom workflow, workflow optimization |

Each stage builds on the previous one. By Stage 5, you will have a repository with a comprehensive suite of agentic workflows covering triage, quality, documentation, CI, and security.

> **Short on time?** Complete Stages 1-3 for a solid foundation. Stages 4-5 add depth but are not required for the core experience.

## Tips for Using Copilot on This Track

- Ask Copilot to generate workflow Markdown files by describing what you want in natural language: "Create an agentic workflow that triages new issues by assigning labels and posting a summary comment."
- Use the [Agentics gallery](https://github.com/githubnext/agentics) as a reference -- paste a gallery workflow into chat and ask Copilot to adapt it for your repository.
- When writing workflow instructions, be specific about your codebase: mention the language, framework, directory structure, and naming conventions. Generic instructions produce generic results.
- Use `gh aw compile` after every change to regenerate the lock file. The lock file is what GitHub Actions actually runs.
- Always review workflow output (issues, PRs, comments) before trusting it. Agentic workflows are powerful but not perfect -- human review is part of the design.

## Resources

- [GitHub Agentic Workflows Documentation](https://github.github.com/gh-aw/)
- [Quick Start Guide](https://github.github.com/gh-aw/setup/quick-start/)
- [The Agentics Gallery](https://github.com/githubnext/agentics)
- [Peli's Agent Factory](https://github.github.com/gh-aw/blog/2026-01-12-welcome-to-pelis-agent-factory/)
- [Security Architecture](https://github.github.com/gh-aw/introduction/architecture/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)
