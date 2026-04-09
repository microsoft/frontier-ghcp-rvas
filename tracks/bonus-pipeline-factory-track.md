# Bonus Track: Pipeline Factory

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐

**Focus:** Building CI/CD pipelines from scratch, standardizing build and deploy processes, debugging broken deployments, and generating incident runbooks -- all with Copilot

## Who Is This For

- DevOps and platform engineers who set up CI/CD for development teams
- Developers responsible for their own build and deploy processes
- Teams that currently deploy manually and want to automate
- Engineers who want to practice using Copilot for infrastructure and pipeline code

## Prerequisites

- Familiarity with CI/CD concepts (build, test, deploy stages)
- Basic understanding of GitHub Actions (YAML workflow syntax)
- Comfort with shell scripting and Node.js (the application uses both)
- No cloud provider account needed -- pipelines run in GitHub Actions

## Technology Stack

- **Application:** Node.js/Express API + static HTML frontend
- **CI/CD:** GitHub Actions
- **Debugging:** A deliberately broken staging deployment with 5 bugs to find
- **Copilot features:** Agent mode, `/fix` command, custom prompts

## What You Are Working With

**TaskBoard** is a simple kanban-style task management application with two components:

- `api-service/`: A Node.js/Express REST API with an in-memory SQLite database
- `web-app/`: A static HTML/CSS/JS frontend

The application works but has no CI/CD pipeline, no automated tests, and no standardized deployment process. The only deployment mechanism is a shell script (`scripts/deploy.sh`) with commented-out commands. There is also a `stage-broken/` directory containing a copy of the API with 5 deliberate bugs that simulate configuration drift in a staging environment.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are building CI/CD pipelines for a Node.js application (API + static frontend)
- Your deployment conventions (environment naming, secret management, approval gates)
- That Copilot should generate GitHub Actions workflows following best practices (pinned action versions, minimal permissions, proper secret handling)
- Your preferred testing approach (what level of tests, coverage requirements)

### Suggested Agents

- **Pipeline Architect Agent** -- Designs GitHub Actions workflows following best practices. Knows reusable workflows, matrix builds, caching strategies, and environment protection rules.
- **Deploy Debugger Agent** -- Analyzes broken deployment configurations, mismatched environment variables, and missing dependencies. Can compare a working setup against a broken one and identify discrepancies.
- **Runbook Writer Agent** -- Takes error logs or incident descriptions and produces step-by-step runbooks for operations teams, including both diagnostic and resolution procedures.

### Open the Challenge

Navigate to `challenges/bonus-8-pipeline-factory/`. Read the [system context](../challenges/bonus-8-pipeline-factory/docs/system-context.md) first, then explore the `api-service/` and `stage-broken/` directories.

A dedicated devcontainer is provided at `.devcontainer/bonus-8-pipeline-factory/` with Node.js LTS and GitHub CLI.

---

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [CI Pipeline](bonus-pipeline-factory-track/phase-1-ci.md) | 1.5-2 hours | Create GitHub Actions workflows for build, lint, and test |
| 2 | [Debug Staging](bonus-pipeline-factory-track/phase-2-debug.md) | 1-1.5 hours | Find and fix 5 deliberate bugs in the broken staging deployment |
| 3 | [Reusable Workflows](bonus-pipeline-factory-track/phase-3-reusable.md) | 1.5-2 hours | Create reusable workflow templates for other projects |
| 4 | [Deployment Gates and Runbooks](bonus-pipeline-factory-track/phase-4-gates.md) | 2-3 hours | Add deployment gates, rollback, and incident runbook generation |

Phases 1 and 2 can be done in either order. Phases 3 and 4 build on the workflows created in Phase 1.

> **Short on time?** Focus on Phases 1 and 2. A working CI pipeline and a fixed staging environment are the most impactful deliverables.

## Tips for Using Copilot on This Track

- Use Agent mode to generate complete workflow files. Describe what you want ("a GitHub Actions workflow that builds and tests a Node.js app, runs on PRs and pushes to main, caches node_modules") and let Copilot produce the YAML.
- For the staging debugging phase, paste the broken `server.js` and the working `server.js` into chat and ask Copilot to diff them and identify issues.
- When creating reusable workflows, ask Copilot to parameterize things that differ between projects (Node version, test command, deploy target).
- Use `/fix` on the broken staging code -- it catches several of the issues directly.
- For runbook generation, give Copilot an error log and ask it to produce a step-by-step troubleshooting guide written for someone with limited technical background.

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Reusable Workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
