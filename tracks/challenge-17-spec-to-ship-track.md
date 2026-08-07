# Challenge 17 Track: Spec-to-Ship Accelerator

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Compressing the full development lifecycle -- from functional requirements to deployed code -- using Copilot prompts and agents at every stage

## Who Is This For

- Tech leads and senior developers who manage the full cycle from spec intake to production deployment
- Teams where multiple manual handoffs (PM to dev to QA to ops) slow down time-to-market
- Developers who write technical analysis documents, create work items, generate tests, and configure pipelines
- Anyone who wants to build a reusable Copilot-powered workflow that accelerates future feature delivery

## Prerequisites

- Experience with the full software development lifecycle (requirements, design, implementation, testing, deployment)
- Familiarity with user stories, acceptance criteria, and test specification formats
- Working knowledge of Node.js (the existing app) or willingness to learn the basics
- Understanding of CI/CD concepts and GitHub Actions

## Technology Stack

- **Source material:** Functional requirements document for a billing module
- **Existing app:** Node.js/Express tenant management API
- **Copilot features:** Custom prompts, custom agents, Agent mode, `@workspace`
- **CI/CD:** GitHub Actions
- **Output:** Work items, technical analysis, code, test specs, pipeline config

## What You Are Working With

Two pieces:

1. **A functional requirements document** (`specs/billing-module-requirements.md`) -- A detailed spec for adding a billing module (subscription plans, usage metering, invoice generation, payment processing) to an existing multi-tenant SaaS platform. The spec includes API endpoints, business rules, authorization, and data retention requirements.

2. **An existing application** (`existing-app/`) -- A simple tenant management API that already handles tenant and user CRUD. The billing module needs to integrate with this existing codebase.

The challenge is not just to build the billing module. It is to build the **tooling and workflow** -- the prompts and agents that convert each stage into the next -- so the approach is reusable for any future feature.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-17-spec-to-ship/`. Read the [system context](../challenges/challenge-17-spec-to-ship/docs/system-context.md) first, then review both the spec and the existing app before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-17-spec-to-ship/` with Node.js LTS.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are adding a billing module to an existing Node.js tenant management platform
- The project's code conventions (from the existing app: Express routes, in-memory data store pattern)
- Your team's work item format (Epic/Story/Task structure, acceptance criteria style)
- Your test specification conventions (test format, what constitutes an edge case worth testing)
- Non-negotiable: every stage's output must be reusable for the next feature, not a one-off for the billing module

### Suggested Custom Agents

- **Requirements Analyst Agent** -- Takes a functional requirements document and produces structured work items: Epics, Stories with Given/When/Then criteria, Tasks, and Test Cases, with dependency ordering and sizing. Give it the requirements doc; it drafts the work items. Use it as Phase 1's first pass.
- **Technical Analyst Agent** -- Takes a spec plus the existing codebase (`@workspace`) and produces a technical analysis: affected modules, new models, API decisions, schema changes, and risk. Give it the spec and repo access; it proposes an implementation order. Use it once work items exist.
- **Test Spec Agent** -- Takes user stories and produces a test specification: scenarios with preconditions, steps, expected results, and edge cases, covering happy path and failure. Give it a story; it drafts the spec. Use it before implementation starts on that story.

### Suggested Custom Skills

- **Spec-to-Work-Items Skill** -- A reusable sequence: given any functional requirements document, produce Epics/Stories/Tasks in the team's format, checking dependency order and sizing consistently every time.
- **Story-to-Code Handoff Skill** -- A repeatable workflow: take one story's acceptance criteria, generate the implementation against the existing codebase's conventions, and confirm it against the criteria before moving to the next story.
- **Pipeline Generation Skill** -- A workflow for turning finished test specs into CI/CD scaffolding (test job plus deploy gate), applied the same way for each new feature.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "requirements analyst agent", "spec to code skill", and "reusable workflow instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- For Phase 1, include an example of a well-formed Epic, Story, and Task in your prompt. Copilot produces much better structured output when it has a template to follow.
- For Phase 2, use `@workspace` to point Copilot at the existing app. Ask it: "Given this spec and the existing codebase, what modules are affected, what new code is needed, and what order should we implement in?"
- In Phase 3, work story by story. Feed Copilot one story's acceptance criteria at a time and let it generate the implementation. Review before moving to the next.
- Agent mode is strong for Phase 4 -- describe the test scenarios and let Copilot scaffold the test files and pipeline YAML.
- Save your prompts in `.github/prompts/` as you go. The whole point is building reusable artifacts.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Phases](challenge-17-spec-to-ship-track/phases.md)
