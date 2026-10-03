# Challenge 17 track: Spec-to-ship accelerator

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Use Copilot skills and agents to take functional requirements through implementation, testing, and deployment

## Who is this for

- Tech leads and senior developers who manage the full cycle from spec intake to production deployment
- Teams where multiple manual handoffs (PM to dev to QA to ops) slow down time-to-market
- Developers who write technical analysis documents, create work items, generate tests, and configure pipelines
- Anyone who wants a reusable Copilot workflow for feature delivery

## Prerequisites

- Experience with the full software development lifecycle (requirements, design, implementation, testing, deployment)
- Familiarity with user stories, acceptance criteria, and test specification formats
- Working knowledge of Node.js (the existing app) or willingness to learn the basics
- Understanding of CI/CD concepts and GitHub Actions

## Technology stack

- **Source material:** Functional requirements document for a billing module
- **Existing app:** Node.js/Express tenant management API
- **Copilot features:** Custom skills, custom agents, Agent mode, `@workspace`
- **CI/CD:** GitHub Actions
- **Output:** Work items, technical analysis, code, test specs, pipeline config

## What you are working with

The starter has two parts:

1. `specs/billing-module-requirements.md` describes a billing module for an existing multi-tenant SaaS platform. It covers subscription plans, usage metering, invoice generation, and payment processing, with API endpoints, business rules, authorization, and data retention requirements.

2. `existing-app/` contains a tenant management API that handles tenant and user CRUD. Integrate the billing module with this codebase.

Build the billing module and the **reusable skills and agents** that carry work between stages. Your team should be able to use them for a later feature.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-17-spec-to-ship/`. Read the [system context](../challenges/challenge-17-spec-to-ship/docs/system-context.md) first, then review both the spec and the existing app before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-17-spec-to-ship/` with Node.js LTS.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should include:

- That you are adding a billing module to an existing Node.js tenant management platform
- The project's code conventions (from the existing app: Express routes, in-memory data store pattern)
- Your team's work item format (Epic/Story/Task structure, acceptance criteria style)
- Your test specification conventions (test format, what constitutes an edge case worth testing)
- Non-negotiable: every stage's output must be reusable for the next feature, not a one-off for the billing module

### Suggested custom agents

- **Requirements Analyst Agent** -- Takes a functional requirements document and produces structured work items: Epics, Stories with Given/When/Then criteria, Tasks, and Test Cases, with dependency ordering and sizing. Give it the requirements doc; it drafts the work items. Use it as Stage 1's first pass.
- **Technical Analyst Agent** -- Takes a spec plus the existing codebase (`@workspace`) and produces a technical analysis: affected modules, new models, API decisions, schema changes, and risk. Give it the spec and repo access; it proposes an implementation order. Use it once work items exist.
- **Test Spec Agent** -- Takes user stories and produces a test specification: scenarios with preconditions, steps, expected results, and edge cases, covering happy path and failure. Give it a story; it drafts the spec. Use it before implementation starts on that story.

### Suggested custom skills

- **Spec-to-Backlog Skill** -- Convert a functional requirements document into work items in the team's format, then check coverage and dependency order. Use it in Stage 1 with the Requirements Analyst agent.
- **Story-to-Code Handoff Skill** -- A repeatable workflow: take one story's acceptance criteria, generate the implementation against the existing codebase's conventions, and confirm it against the criteria before moving to the next story.
- **Pipeline Generation Skill** -- A workflow for turning finished test specs into CI/CD scaffolding (test job plus deploy gate), applied the same way for each new feature.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "requirements analyst agent", "spec to code skill", and "reusable workflow instructions" before you draft your own.

---

## Tips for using Copilot on this track

- For Stage 1, give the backlog skill your team's work item conventions so its outputs use a consistent format.
- For Stage 2, use `@workspace` to point Copilot at the existing app. Review the affected modules and proposed implementation order against the spec.
- In Stage 3, work story by story. Feed Copilot one story's acceptance criteria at a time and let it generate the implementation. Review before moving to the next.
- In Stage 4, describe the test scenarios and use Agent mode to scaffold test files and pipeline YAML.
- Save each skill under `.github/skills/<skill-name>/SKILL.md` as you go. Keep its inputs clear enough for another team member to use it.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-17-spec-to-ship-track/stages.md)
