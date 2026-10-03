# Challenge 6 Track: Agentic Workflows

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Build and operate GitHub Agentic Workflows, Markdown-defined repository automation that uses AI in GitHub Actions

> This track requires a GitHub repository with GitHub Actions enabled. Agentic workflows execute on GitHub and cannot run locally.

## Who is this for

- Developers and DevOps engineers who want to automate repository maintenance with AI
- Teams exploring "Continuous AI" as a complement to CI/CD
- Anyone comfortable with GitHub Actions, Markdown, and YAML who wants to understand how coding agents can run safely in automated pipelines

## Prerequisites

- Familiarity with GitHub (Issues, Pull Requests, Actions)
- Basic understanding of CI/CD concepts
- A GitHub account with Copilot access
- A GitHub repository with real code to work with (from a previous challenge or a fork of an open-source project)

## Technology stack

- **GitHub Agentic Workflows** (`gh-aw` CLI extension)
- **GitHub Actions** (runtime environment for agentic workflows)
- **Markdown** (workflow definition language)
- **GitHub Copilot** (or Claude/Codex as the agent engine)
- **GitHub CLI** (`gh`) for workflow management

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-6-agentic-workflows/`. Read the [functional specification](../challenges/challenge-6-agentic-workflows/docs/functional-spec.md) before starting Stage 1.

You need a GitHub repository to work in. If you do not have one ready, see the [getting started guide](../challenges/challenge-6-agentic-workflows/docs/getting-started.md) for options.

A dedicated devcontainer is provided at `.devcontainer/challenge-6-agentic-workflows/` with Node.js LTS, Python 3.11, GitHub CLI, and the `gh-aw` extension.

> **GitHub is required.** Create workflow files locally or in a Codespace, then push them to a GitHub repository to run them in GitHub Actions.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should describe:

- The repository you are adding agentic workflows to (what does the code do, what language, what frameworks)
- The types of automation you want (triage, documentation, code quality, CI monitoring)
- Security constraints: read-only permissions, safe outputs only, scoped labels
- Non-negotiable: no workflow gets write access or secrets it doesn't need for its stated purpose

### Suggested custom agents

Use the custom Copilot agents below locally to author and review workflow files. The workflows you build run unattended in GitHub Actions with an agent engine (Copilot, Claude, or Codex) configured per workflow.

- Use a Workflow Author Agent to draft and debug Markdown workflows using the `gh-aw` frontmatter schema, safe outputs, and permission model. Review its draft before compiling.
- Use a Security Reviewer Agent to check draft or compiled workflows for excessive permissions, missing safe-output limits, and prompt injection risks before pushing.

### Suggested custom skills

- A Workflow Compile and Verify Skill runs `gh aw compile` after edits and checks the lock file's permissions and triggers against the intended workflow. Run it before each push.
- A Safe-Output Audit Skill checks that issues, comments, and PRs use only the required labels and permissions. Run it when adding an output type.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "agentic workflow", "repository automation skill", and "GitHub Actions security instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Ask Copilot to generate workflow Markdown files by describing what you want in natural language: "Create an agentic workflow that triages new issues by assigning labels and posting a summary comment."
- Use the [Agentics gallery](https://github.com/githubnext/agentics) as a reference and ask Copilot to adapt a workflow for your repository.
- When writing workflow instructions, be specific about your codebase: mention the language, framework, directory structure, and naming conventions. Generic instructions produce generic results.
- Use `gh aw compile` after every change to regenerate the lock file. The lock file is what GitHub Actions actually runs.
- Review generated issues, PRs, and comments before accepting workflow output.

## Resources

- [GitHub Agentic Workflows Documentation](https://github.github.com/gh-aw/)
- [Quick Start Guide](https://github.github.com/gh-aw/setup/quick-start/)
- [The Agentics Gallery](https://github.com/githubnext/agentics)
- [Peli's Agent Factory](https://github.github.com/gh-aw/blog/2026-01-12-welcome-to-pelis-agent-factory/)
- [Security Architecture](https://github.github.com/gh-aw/introduction/architecture/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-6-agentic-workflows-track/stages.md)
