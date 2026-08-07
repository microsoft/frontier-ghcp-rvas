# Challenge 6 Track: Agentic Workflows

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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-6-agentic-workflows/`. Read the [functional specification](../challenges/challenge-6-agentic-workflows/docs/functional-spec.md) before starting Stage 1.

You need a GitHub repository to work in. If you do not have one ready, see the [getting started guide](../challenges/challenge-6-agentic-workflows/docs/getting-started.md) for options.

A dedicated devcontainer is provided at `.devcontainer/challenge-6-agentic-workflows/` with Node.js LTS, Python 3.11, GitHub CLI, and the `gh-aw` extension.

> **GitHub is required.** Agentic workflows run as GitHub Actions -- all workflow files must be pushed to a GitHub repository. You will create workflow files locally (or in a Codespace), but they only execute on GitHub after you push.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should describe:

- The repository you are adding agentic workflows to (what does the code do, what language, what frameworks)
- The types of automation you want (triage, documentation, code quality, CI monitoring)
- Security constraints: read-only permissions, safe outputs only, scoped labels
- Non-negotiable: no workflow gets write access or secrets it doesn't need for its stated purpose

### Suggested Custom Agents

The agents below are custom Copilot agents you run locally to help author and review workflow files. They are not the agentic workflows themselves -- those run unattended in GitHub Actions using an agent engine (Copilot, Claude, or Codex) you configure per workflow, and building them is what this track has you do.

- **Workflow Author Agent** -- Knows the `gh-aw` frontmatter schema, safe-output types, and permission model well enough to help draft and debug workflow Markdown files. Give it a description of the automation you want; it proposes frontmatter and structure for you to review. Use it while authoring, before you compile.
- **Security Reviewer Agent** -- Applies a permissions lens to a finished workflow file: scope creep, missing safe-output constraints, and prompt injection exposure from untrusted input. Give it a draft or compiled workflow; it returns findings. Use it before pushing a workflow to GitHub.

### Suggested Custom Skills

- **Workflow Compile and Verify Skill** -- A fixed sequence after every edit: run `gh aw compile` to regenerate the lock file, diff the generated permissions against what you intended, and confirm the trigger conditions match the automation's purpose. Run it before every push.
- **Safe-Output Audit Skill** -- A repeatable pass over a workflow's outputs (issues, comments, PRs) that checks each one is scoped to the minimum labels and permissions needed. Use it whenever a workflow gains a new output type.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "agentic workflow", "repository automation skill", and "GitHub Actions security instructions" before you draft your own.

---

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

---

Next: [Stages](challenge-6-agentic-workflows-track/stages.md)
