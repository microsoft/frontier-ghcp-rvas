# Challenge 14 Track: Pipeline Factory

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
- **Copilot features:** Agent mode, `/fix` command, custom skills

## What You Are Working With

**TaskBoard** is a simple kanban-style task management application with two components:

- `api-service/`: A Node.js/Express REST API with an in-memory SQLite database
- `web-app/`: A static HTML/CSS/JS frontend

The application works but has no CI/CD pipeline, no automated tests, and no standardized deployment process. The only deployment mechanism is a shell script (`scripts/deploy.sh`) with commented-out commands. There is also a `stage-broken/` directory containing a copy of the API with 5 deliberate bugs that simulate configuration drift in a staging environment.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-14-pipeline-factory/`. Read the [system context](../challenges/challenge-14-pipeline-factory/docs/system-context.md) first, then explore the `api-service/` and `stage-broken/` directories before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-14-pipeline-factory/` with Node.js LTS and GitHub CLI.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are building CI/CD pipelines for a Node.js application (API + static frontend)
- Your deployment conventions (environment naming, secret management, approval gates)
- That Copilot should generate GitHub Actions workflows following best practices (pinned action versions, minimal permissions, proper secret handling)
- Your preferred testing approach (what level of tests, coverage requirements)
- Non-negotiable: no workflow gets broader permissions than the job actually requires

### Suggested Custom Agents

- **Pipeline Architect Agent** -- Designs GitHub Actions workflows following best practices: reusable workflows, matrix builds, caching, and environment protection rules. Give it a build/deploy requirement; it proposes the workflow structure. Use it when designing or restructuring a pipeline.
- **Deploy Debugger Agent** -- Analyzes broken deployment configurations, mismatched environment variables, and missing dependencies by comparing a working setup against a broken one. Give it both configurations; it identifies discrepancies. Use it during the staging debugging phase.
- **Runbook Writer Agent** -- Takes an error log or incident description and produces a step-by-step runbook with diagnostic and resolution procedures. Give it a log excerpt; it drafts the runbook. Use it once an incident is understood, not while still diagnosing it.

### Suggested Custom Skills

- **Config Drift Diff Skill** -- A fixed sequence: compare the working `api-service/` against `stage-broken/` file by file, list every discrepancy, and classify each as configuration, dependency, or code drift.
- **Pipeline Stage Addition Skill** -- A repeatable workflow for adding a new CI/CD stage: define the job, parameterize what differs from prior stages, wire required secrets, and verify with a dry run before merging.
- **Incident Runbook Skill** -- Turn incident evidence into a runbook with diagnostic checks and escalation criteria. Use it with the Runbook Writer agent in Stage 4 and test the output against the failures from Stage 2. Keep unconfirmed resolution options separate from known fixes.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "CI/CD pipeline agent", "deployment drift skill", and "GitHub Actions instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Use Agent mode to generate complete workflow files. Describe what you want ("a GitHub Actions workflow that builds and tests a Node.js app, runs on PRs and pushes to main, caches node_modules") and let Copilot produce the YAML.
- For the staging debugging phase, paste the broken `server.js` and the working `server.js` into chat and ask Copilot to diff them and identify issues.
- When creating reusable workflows, ask Copilot to parameterize things that differ between projects (Node version, test command, deploy target).
- Use `/fix` on the broken staging code -- it catches several of the issues directly.
- Give the incident runbook skill an error log, then check that its troubleshooting guide is usable by someone with limited technical background.

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Reusable Workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-14-pipeline-factory-track/stages.md)
