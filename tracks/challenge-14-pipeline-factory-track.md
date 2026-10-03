# Challenge 14 Track: Pipeline Factory

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐

**Focus:** Use Copilot to build CI/CD pipelines, standardize build and deploy processes, debug deployments, and write incident runbooks

## Who is this for

- DevOps and platform engineers who set up CI/CD for development teams
- Developers responsible for their own build and deploy processes
- Teams that currently deploy manually and want to automate
- Engineers who want to practice using Copilot for infrastructure and pipeline code

## Prerequisites

- Familiarity with CI/CD concepts (build, test, deploy stages)
- Basic understanding of GitHub Actions (YAML workflow syntax)
- Comfort with shell scripting and Node.js (the application uses both)
- No Azure account needed; pipelines run in GitHub Actions

## Technology stack

- **Application:** Node.js/Express API + static HTML frontend
- **CI/CD:** GitHub Actions
- **Debugging:** A deliberately broken staging deployment with 5 bugs to find
- **Copilot features:** Agent mode, `/fix` command, custom skills

## What you are working with

**TaskBoard** is a simple kanban-style task management application with two components:

- `api-service/`: A Node.js/Express REST API with an in-memory SQLite database
- `web-app/`: A static HTML/CSS/JS frontend

The application works but has no CI/CD pipeline, no automated tests, and no standardized deployment process. The only deployment mechanism is a shell script (`scripts/deploy.sh`) with commented-out commands. There is also a `stage-broken/` directory containing a copy of the API with 5 deliberate bugs that simulate configuration drift in a staging environment.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-14-pipeline-factory/`. Read the [system context](../challenges/challenge-14-pipeline-factory/docs/system-context.md) first, then explore the `api-service/` and `stage-broken/` directories before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-14-pipeline-factory/` with Node.js LTS and GitHub CLI.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should include:

- That you are building CI/CD pipelines for a Node.js application (API + static frontend)
- Your deployment conventions (environment naming, secret management, approval gates)
- That Copilot should generate GitHub Actions workflows following best practices (pinned action versions, minimal permissions, proper secret handling)
- Your preferred testing approach (what level of tests, coverage requirements)
- Non-negotiable: no workflow gets broader permissions than the job actually requires

### Suggested custom agents

- Use a Pipeline Architect Agent to propose GitHub Actions workflows with reusable jobs, matrix builds, caching, and environment protection.
- Use a Deploy Debugger Agent to compare working and broken configurations for mismatched variables or missing dependencies during staging debugging.
- Use a Runbook Writer Agent to draft diagnostic and resolution steps from an error log or incident description after finding the cause.

### Suggested custom skills

- A Config Drift Diff Skill compares `api-service/` with `stage-broken/` and classifies discrepancies as configuration, dependency, or code drift.
- A Pipeline Stage Addition Skill adds jobs with configurable inputs and required secrets, then checks them with a dry run before merging.
- An Incident Runbook Skill turns evidence into diagnostic checks and escalation criteria. Use it with the Runbook Writer agent in Stage 4 and test it against Stage 2 failures. Separate unconfirmed options from known fixes.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "CI/CD pipeline agent", "deployment drift skill", and "GitHub Actions instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Use Agent mode to generate complete workflow files. Describe what you want ("a GitHub Actions workflow that builds and tests a Node.js app, runs on PRs and pushes to main, caches node_modules") and let Copilot produce the YAML.
- For the staging debugging phase, paste the broken `server.js` and the working `server.js` into chat and ask Copilot to diff them and identify issues.
- When creating reusable workflows, ask Copilot to parameterize things that differ between projects (Node version, test command, deploy target).
- Try `/fix` on the broken staging code and verify each proposed change.
- Give the incident runbook skill an error log, then check that its troubleshooting guide is usable by someone with limited technical background.

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Reusable Workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-14-pipeline-factory-track/stages.md)
