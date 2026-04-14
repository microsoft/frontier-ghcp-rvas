# GitHub Agentic Workflows -- Functional Specification

## Overview

This challenge is about building a suite of GitHub Agentic Workflows for repository automation. Unlike other challenges where you build an application, here you build the automation layer that keeps a repository healthy, documented, and well-maintained -- using AI agents that run inside GitHub Actions.

You will work with the **TrailMate** codebase (or any existing repository with real code, tests, and issues). Your goal is to add agentic workflows that handle triage, code quality, documentation, CI monitoring, security, and reporting -- all defined in plain Markdown.

## What Are GitHub Agentic Workflows

GitHub Agentic Workflows let you describe repository automation tasks in Markdown files placed in `.github/workflows/`. A coding agent (GitHub Copilot, Claude, or OpenAI Codex) executes these instructions inside a sandboxed GitHub Actions run with read-only permissions and controlled outputs.

Each workflow has:

- **Frontmatter** -- YAML configuration for triggers, permissions, safe outputs, and tools
- **Markdown body** -- Natural language instructions describing what the agent should do

The agent cannot write to the repository directly. Instead, it produces structured outputs (create an issue, open a PR, add a comment) that pass through a gated safe-output layer with constraints you define.

## Required Capabilities

Your repository should have the following agentic workflows by the end of the challenge:

### 1. Issue Triage (event-triggered)

- Triggers when a new issue is opened
- Reads the issue title and body
- Assigns one type label (bug, feature, question, documentation) and one priority label (P0-P3)
- Posts a triage summary comment

### 2. Daily Repository Status Report (scheduled)

- Runs on a daily schedule
- Creates a GitHub Issue summarizing recent activity: new issues, merged PRs, open blockers
- Includes trend observations and action items

### 3. Code Simplifier (scheduled)

- Runs daily or weekly
- Analyzes recently modified source files
- Opens a pull request with targeted simplifications (dead code removal, reduced nesting, extracted helpers)

### 4. Documentation Updater (scheduled)

- Runs daily
- Checks for recent code changes (merged PRs)
- Opens a pull request updating documentation to reflect those changes

### 5. CI Doctor (event-triggered)

- Triggers when a CI workflow run completes with a failure
- Analyzes the failure logs
- Posts a comment with root cause diagnosis and a suggested fix

### 6. ChatOps Command (comment-triggered)

- Triggers when a maintainer posts a specific command in an issue or PR comment (e.g., `/plan`, `/diagnose`, `/summarize`)
- Performs the requested action and replies with the result

## Security Requirements

All workflows must follow these constraints:

- **Read-only permissions by default** -- the agent token must not have write access
- **Safe outputs only** -- all write operations (issue creation, PR creation, comment posting) go through the safe-output layer
- **Scoped outputs** -- every safe output must have title prefixes, label constraints, and maximum counts
- **No secrets in agent scope** -- API keys and tokens must only exist in the post-agent write job

## Stretch Goals

If you finish the six required workflows:

- Add a **Grumpy Reviewer** workflow that provides opinionated code review on new PRs
- Add a **Duplicate Code Detector** that identifies repeated patterns and suggests refactoring
- Add a **Weekly Research** workflow that collects industry trends relevant to your project
- Add a **Security Scanner** that checks recent code changes for suspicious patterns
- Create a **custom workflow** that solves a problem specific to your repository

## References

- [GitHub Agentic Workflows Documentation](https://github.github.com/gh-aw/)
- [Quick Start Guide](https://github.github.com/gh-aw/setup/quick-start/)
- [The Agentics Gallery](https://github.com/githubnext/agentics)
- [Peli's Agent Factory](https://github.github.com/gh-aw/blog/2026-01-12-welcome-to-pelis-agent-factory/)
- [Security Architecture](https://github.github.com/gh-aw/introduction/architecture/)
- [Safe Outputs Reference](https://github.github.com/gh-aw/reference/safe-outputs/)
- [Design Patterns (ChatOps, DailyOps, IssueOps)](https://github.github.com/gh-aw/patterns/chatops/)
