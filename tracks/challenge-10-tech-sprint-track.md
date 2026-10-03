# Challenge 10 Track: Technical Team Sprint

**Duration:** 4-6 hours (five-hour core; extended backlog is optional)

**Difficulty:** ⭐⭐⭐

**Focus:** Develop an application from a provided specification to production deployment with a technical team using GitHub Copilot

> This track supports 2-4 developers or engineers. Smaller teams combine roles as described below.

## Who is this for

- Teams of 2-4 developers and engineers who want to build a complete application together from a given specification
- Organizations that want to simulate a real agile sprint powered by GitHub Copilot, with no business stakeholders in the room
- Groups with strong technical skills across backend, frontend, and operations (QA is a bonus if you have the headcount)

## Team composition

The track supports teams of 2-4 people. Each person takes one or more roles depending on team size.

| Role | Required | What They Do |
|------|----------|------------|
| Backend Developer | Yes | API design, business logic, database, server-side tests |
| Frontend Developer | Yes | UI components, routing, styling, API integration |
| QA Engineer | No | Test strategy, E2E test automation, bug reporting |
| DevOps Engineer | Yes | Devcontainer config, CI/CD, environment setup |

There is no Product Owner or Business Analyst in this track. The functional specification is provided upfront. The team self-organizes using GitHub Issues and a shared project board.

### Adapting to your team size

With 4 people, assign one role each.

With 3 people, omit the QA Engineer role. Developers write unit and integration tests; DevOps adds basic E2E smoke tests to CI. Skip the QA-specific stage pages.

With 2 people, one covers Backend and Frontend with a smaller UI scope; the other covers DevOps. Skip the QA role and focus on deploying core features rather than full coverage.

A full-stack developer can cover both backend and frontend work. Use the role pages to organize tasks.

## Prerequisites

Each team member needs skills matching their assigned role:

- **Backend Dev:** Experience with Node.js/Express or Python/FastAPI
- **Frontend Dev:** Experience with React, Vue, or Svelte (TypeScript preferred)
- **QA:** Familiarity with test automation frameworks (Playwright recommended)
- **DevOps:** Familiarity with CI/CD concepts and GitHub Codespaces

All participants need a GitHub account with Copilot access.

## Technology stack

The team chooses their stack together. Recommended options:

- **Backend:** Node.js with Express (or Python with FastAPI)
- **Frontend:** React with TypeScript and Vite (or Vue/Svelte)
- **Database:** SQLite for development, PostgreSQL for production (optional)
- **Testing:** Playwright for E2E, Jest or pytest for unit tests
- **Infrastructure:** GitHub Codespaces (devcontainers), GitHub Actions
- **Collaboration:** GitHub Issues, GitHub Projects
- **UI review:** Impeccable, installed manually by the frontend developer

## How this track works

Unlike Challenge 9, this track starts with a provided functional specification. The team begins with technical planning instead of product discovery.

The challenge runs as a simulated sprint cycle:

1. **Technical Planning** -- The team reads the provided functional specification, writes a technical specification, breaks work into GitHub Issues, and plans Sprint 1. Everyone sets up tooling and project scaffolding in parallel.
2. **Sprint 1** -- All roles work in parallel on their piece. Developers build core features, QA writes tests, DevOps sets up infrastructure.
3. **Sprint 2** -- The team integrates, adds advanced features, fixes bugs, and deploys.
4. **Ship and Demo** -- Production deployment, final testing, demo, retrospective.

The team self-manages the backlog throughout. Each developer triages their own domain. GitHub Issues is the primary communication channel between roles.

## The Challenge: TrailMate

Build TrailMate, a trail management platform for a regional parks authority. The parks department wants a web application where:

- **Hikers browse trails** with difficulty ratings, distance, elevation, and current conditions
- **Hikers report trail conditions** (fallen trees, flooding, erosion, wildlife, snow/ice)
- **Trail status is tracked** (Open, Caution, Closed) based on condition reports
- **A dashboard** shows trail statistics (trails by status, condition reports by type, recent activity)

The functional specification is in [challenges/challenge-10-tech-sprint/docs/functional-spec.md](../challenges/challenge-10-tech-sprint/docs/functional-spec.md). Read it as a team before sprint planning.

**Core scope:** trail browsing and detail, status/severity labels, and condition
reporting, with API integration and a tested demo. Work in parallel. Keep
dashboard analytics, authentication, and agentic workflows outside the core.
Azure deployment is a stretch task if the team has not prepared an environment
before the session.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-10-tech-sprint/`. Read the [functional specification](../challenges/challenge-10-tech-sprint/docs/functional-spec.md) as a team before starting Stage 1. Everyone should skim the starter scaffolding for their own role before the team commits to any instructions or agents.

A dedicated devcontainer is provided at `.devcontainer/challenge-10-tech-sprint/` with Node.js LTS, Python 3.11, GitHub CLI, and Playwright.

### Install and use Impeccable

The frontend developer follows the [shared manual installation and discovery checks](getting-started.md#5-install-impeccable-when-your-track-uses-it)
after clean setup. Preflight a source file in the chosen frontend. In Stages
2--3, review the trail list and detail journey. Make Closed and Caution states
clear without color, and check high-severity warnings at a narrow viewport.
Keep status rules in the functional specification; the skill must not invent
a new policy.

### Repository instructions for this track

Repository instructions are shared, not role-specific. The team should build one `.github/copilot-instructions.md` together. At minimum include:

- The project name (TrailMate) and what it does
- The team's chosen tech stack (backend framework, frontend framework, database)
- Code conventions the team agreed on (naming, file structure, API patterns)
- Non-negotiable: treat the functional spec as the source of truth and flag stories that contradict it

Individual team members can also maintain role-specific context in their agent definitions.

### Suggested custom agents

Each person builds an agent for their role using the shared repository instructions:

- Backend and frontend developers each create an Engineering Conventions Agent for their layer. It should propose endpoints or components that follow TrailMate's API, data model, component, and styling conventions.
- QA and DevOps each create a Trail Delivery Agent for their responsibility. QA uses it to review tests for trail browsing, condition reporting, status transitions, and dashboard flows. DevOps uses it to review the devcontainer, GitHub Actions, and deployment requirements for those features.

Agree on the roster during the planning phase so everyone builds against the same project context.

### Suggested custom skills

Workflow skills are shared team assets, not tied to one role:

- A Spec-to-Issues Skill converts the functional spec into stories and tasks and creates matching GitHub Issues through MCP.
- A Sprint Board Sync Skill updates issue status, links the PR, and records scope changes after each merge.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "team sprint agents", "spec to issues skill", and "technical planning instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Point Copilot at the functional spec and use GitHub MCP to create Issues from its features.
- **Developers:** Describe API contracts and component props in terms of the project domain (trails, difficulty ratings, conditions) rather than generic CRUD.
- **QA:** Describe the user flow first ("submit a trail condition report, verify it appears"), then ask for the Playwright test.
- **DevOps:** State the target infrastructure (stages, base image, constraints) and let Copilot generate the manifest.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [MCP Servers Guide](../docs/mcp-servers.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-10-tech-sprint-track/stages.md)
