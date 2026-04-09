# Bonus Track: Spec-to-Ship Accelerator

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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are adding a billing module to an existing Node.js tenant management platform
- The project's code conventions (from the existing app: Express routes, in-memory data store pattern)
- Your team's work item format (Epic/Story/Task structure, acceptance criteria style)
- Your test specification conventions (test format, what constitutes an edge case worth testing)

### Suggested Agents

- **Requirements Analyst Agent** -- Takes a functional requirements document and produces structured work items: Epics, User Stories with Given/When/Then acceptance criteria, Technical Tasks, and Test Cases. Understands dependency ordering and can size stories.
- **Technical Analyst Agent** -- Takes a spec plus the existing codebase (`@workspace`) and produces a technical analysis: affected modules, new models needed, API design decisions, database schema changes, risk assessment, and a recommended implementation order.
- **Test Spec Agent** -- Takes user stories and produces a test specification document: test scenarios with preconditions, steps, expected results, and edge cases. Covers both happy path and failure scenarios.

### Open the Challenge

Navigate to `challenges/bonus-11-spec-to-ship/`. Read the [system context](../challenges/bonus-11-spec-to-ship/docs/system-context.md) first, then review both the spec and the existing app.

A dedicated devcontainer is provided at `.devcontainer/bonus-11-spec-to-ship/` with Node.js LTS.

---

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Spec to Backlog](bonus-spec-to-ship-track/phase-1-backlog.md) | 1.5-2 hours | Build a prompt that converts the spec into structured work items |
| 2 | [Technical Analysis](bonus-spec-to-ship-track/phase-2-analysis.md) | 1-1.5 hours | Build a prompt that generates a technical analysis from spec + existing code |
| 3 | [Code Generation](bonus-spec-to-ship-track/phase-3-code.md) | 2-2.5 hours | Use Copilot to implement the billing module from the generated stories |
| 4 | [Test Specs and Pipeline](bonus-spec-to-ship-track/phase-4-tests-pipeline.md) | 1.5-2 hours | Generate test specifications and a CI pipeline |

Each phase produces an artifact that feeds into the next. Phase 1 produces work items; Phase 2 analyzes impact; Phase 3 implements; Phase 4 validates.

> **Short on time?** Focus on Phases 1 and 2. The spec-to-backlog prompt and the technical analysis prompt are the most reusable artifacts. You can demonstrate the code generation and testing in a follow-up session.

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
