# Bonus Track: Technical Team Sprint

**Duration:** 8-10 hours

**Difficulty:** ⭐⭐⭐

**Focus:** End-to-end application development with a technical team -- from a provided specification to production deployment -- using GitHub Copilot across every technical role

> This track is designed for teams of up to 4 developers/engineers. It works with 2, 3, or 4 people -- smaller teams just combine roles. See the Team Composition section below.

## Who Is This For

- Teams of 2-4 developers and engineers who want to build a complete application together from a given specification
- Organizations that want to simulate a real agile sprint powered by GitHub Copilot, with no business stakeholders in the room
- Groups with strong technical skills across backend, frontend, and operations (QA is a bonus if you have the headcount)

## Team Composition

The track supports teams of 2-4 people. Each person takes one or more roles depending on team size.

| Role | Required | What They Do |
|------|----------|------------|
| Backend Developer | Yes | API design, business logic, database, server-side tests |
| Frontend Developer | Yes | UI components, routing, styling, API integration |
| QA Engineer | No | Test strategy, E2E test automation, bug reporting |
| DevOps Engineer | Yes | Devcontainer config, CI/CD, environment setup |

There is no Product Owner or Business Analyst in this track. The functional specification is provided upfront. The team self-organizes using GitHub Issues and a shared project board.

### Adapting to Your Team Size

**4 people** -- one role each, the ideal setup.

**3 people** -- drop the QA Engineer role. Developers write their own tests (unit and integration), and the DevOps engineer adds basic E2E smoke tests to the CI pipeline. Skip the QA-specific pages in each phase.

**2 people** -- one person covers both Backend and Frontend (simplify the UI scope), the other covers DevOps. Skip QA entirely. Focus on getting a working deployment with core features rather than full coverage.

A full-stack developer can also split the Backend and Frontend work however they want -- there is no strict boundary. The role pages are there to organize tasks, not to lock anyone into a lane.

## Prerequisites

Each team member needs skills matching their assigned role:

- **Backend Dev:** Experience with Node.js/Express or Python/FastAPI
- **Frontend Dev:** Experience with React, Vue, or Svelte (TypeScript preferred)
- **QA:** Familiarity with test automation frameworks (Playwright recommended)
- **DevOps:** Familiarity with CI/CD concepts and GitHub Codespaces

All participants need a GitHub account with Copilot access.

## Technology Stack

The team chooses their stack together. Recommended options:

- **Backend:** Node.js with Express (or Python with FastAPI)
- **Frontend:** React with TypeScript and Vite (or Vue/Svelte)
- **Database:** SQLite for development, PostgreSQL for production (optional)
- **Testing:** Playwright for E2E, Jest or pytest for unit tests
- **Infrastructure:** GitHub Codespaces (devcontainers), GitHub Actions
- **Collaboration:** GitHub Issues, GitHub Projects

## How This Track Works

This track differs from the Cross-Functional Team Sprint (Bonus 3) in one key way: you skip the product discovery phase. Instead, the team receives a detailed functional specification and jumps straight into technical planning.

The challenge runs as a simulated sprint cycle:

1. **Technical Planning** -- The team reads the provided functional specification, writes a technical specification, breaks work into GitHub Issues, and plans Sprint 1. Everyone sets up tooling and project scaffolding in parallel.
2. **Sprint 1** -- All roles work in parallel on their piece. Developers build core features, QA writes tests, DevOps sets up infrastructure.
3. **Sprint 2** -- The team integrates, adds advanced features, fixes bugs, and deploys.
4. **Ship and Demo** -- Production deployment, final testing, demo, retrospective.

The team self-manages the backlog throughout. Each developer triages their own domain. GitHub Issues is the primary communication channel between roles.

## The Challenge: TrailMate

Your team is building **TrailMate** -- a trail management platform for a regional parks authority. The parks department wants a web application where:

- **Hikers browse trails** with difficulty ratings, distance, elevation, and current conditions
- **Hikers report trail conditions** (fallen trees, flooding, erosion, wildlife, snow/ice)
- **Trail status is tracked** (Open, Caution, Closed) based on condition reports
- **A dashboard** shows trail statistics (trails by status, condition reports by type, recent activity)

The functional specification is in [challenges/bonus-4-tech-sprint/docs/functional-spec.md](../challenges/bonus-4-tech-sprint/docs/functional-spec.md). Read it as a team before sprint planning.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

The team should build a shared `.github/copilot-instructions.md` together. At minimum include:

- The project name (TrailMate) and what it does
- The team's chosen tech stack (backend framework, frontend framework, database)
- Code conventions the team agreed on (naming, file structure, API patterns)

Individual team members can also maintain role-specific context in their agent definitions.

### Suggested Agents

**Agents the team should consider creating together:**

- **API Architect Agent** -- Understands the TrailMate REST API conventions and data model
- **UI Component Agent** -- Knows the frontend framework, component patterns, and styling approach
- **Test Engineer Agent** -- Specializes in Playwright E2E tests with page object patterns
- **Infrastructure Agent** -- Focused on devcontainer configuration, GitHub Actions, and environment setup

Agree on shared agents during the planning phase so everyone benefits from the same project context.

### Open the Challenge

Navigate to `challenges/bonus-4-tech-sprint/`. Read the [functional specification](../challenges/bonus-4-tech-sprint/docs/functional-spec.md) as a team before starting Phase 1.

A dedicated devcontainer is provided at `.devcontainer/bonus-4-tech-sprint/` with Node.js LTS, Python 3.11, GitHub CLI, and Playwright.

---

## Phases

| Phase | Name | Duration | What Happens |
|-------|------|----------|--------------|
| 1 | [Technical Planning](bonus-tech-sprint-track/phase-1-technical-planning.md) | 1.5 hours | Read spec, write technical spec, create Issues, scaffold projects |
| 2 | [Sprint 1 -- Core Features](bonus-tech-sprint-track/phase-2-sprint-1-build.md) | 3 hours | Parallel build: API, UI, tests, infrastructure |
| 3 | [Sprint 2 -- Integration and Polish](bonus-tech-sprint-track/phase-3-sprint-2-integration.md) | 2 hours | Advanced features, integration, bug fixing, deployment |
| 4 | [Ship and Demo](bonus-tech-sprint-track/phase-4-deploy-demo.md) | 1.5 hours | Production deployment, final testing, demo, retrospective |
| 5 | [Agentic Workflows](bonus-tech-sprint-track/phase-5-agentic-workflows.md) | 1.5 hours | Add AI-powered repository automation with GitHub Agentic Workflows |

Work within each phase happens **in parallel** across roles. Each phase file has a "Jump to Your Role" table so you only read what applies to you.

> **Short on time?** Cut Sprint 2 scope: skip authentication and the dashboard, focus on deploying the core trail directory and condition reporting features. This shaves roughly 1.5 hours off the total. Phase 5 (Agentic Workflows) is also optional and can be skipped if time is tight.

## Follow Your Role

Each phase contains detailed tasks for every role, broken into separate pages. Pick your role below to see all five phases at a glance -- or go to a specific phase and find your role there.

### Backend Developer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Technical Planning](bonus-tech-sprint-track/phase-1-technical-planning/backend-developer.md) | Scaffold project, draft API spec, custom instructions |
| 2 | [Sprint 1](bonus-tech-sprint-track/phase-2-sprint-1-build/backend-developer.md) | Trails CRUD, Condition Reports API, seed data, tests |
| 3 | [Sprint 2](bonus-tech-sprint-track/phase-3-sprint-2-integration/backend-developer.md) | Bug fixes, search/filter, stats endpoint, auth |
| 4 | [Ship and Demo](bonus-tech-sprint-track/phase-4-deploy-demo/backend-developer.md) | Critical fixes, performance check, demo contribution |
| 5 | [Agentic Workflows](bonus-tech-sprint-track/phase-5-agentic-workflows/backend-developer.md) | Code simplifier, test improver workflows |

### Frontend Developer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Technical Planning](bonus-tech-sprint-track/phase-1-technical-planning/frontend-developer.md) | Scaffold project, design component hierarchy, coordinate API |
| 2 | [Sprint 1](bonus-tech-sprint-track/phase-2-sprint-1-build/frontend-developer.md) | Trail list, trail detail, condition report form, navigation |
| 3 | [Sprint 2](bonus-tech-sprint-track/phase-3-sprint-2-integration/frontend-developer.md) | Connect to real API, dashboard, responsive design |
| 4 | [Ship and Demo](bonus-tech-sprint-track/phase-4-deploy-demo/frontend-developer.md) | Critical UI fixes, visual polish, demo contribution |
| 5 | [Agentic Workflows](bonus-tech-sprint-track/phase-5-agentic-workflows/frontend-developer.md) | Documentation updater, accessibility review |

### QA Engineer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Technical Planning](bonus-tech-sprint-track/phase-1-technical-planning/qa-engineer.md) | Set up Playwright, test plan, test data requirements |
| 2 | [Sprint 1](bonus-tech-sprint-track/phase-2-sprint-1-build/qa-engineer.md) | E2E tests, API tests, exploratory testing, bug reports |
| 3 | [Sprint 2](bonus-tech-sprint-track/phase-3-sprint-2-integration/qa-engineer.md) | Regression, Sprint 2 tests, cross-browser, accessibility |
| 4 | [Ship and Demo](bonus-tech-sprint-track/phase-4-deploy-demo/qa-engineer.md) | Final regression, production smoke test, test report |
| 5 | [Agentic Workflows](bonus-tech-sprint-track/phase-5-agentic-workflows/qa-engineer.md) | CI Doctor, daily QA workflow |

### DevOps Engineer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Technical Planning](bonus-tech-sprint-track/phase-1-technical-planning/devops-engineer.md) | Devcontainer config, CI pipeline, branching strategy |
| 2 | [Sprint 1](bonus-tech-sprint-track/phase-2-sprint-1-build/devops-engineer.md) | Environment setup, process scripts, CI |
| 3 | [Sprint 2](bonus-tech-sprint-track/phase-3-sprint-2-integration/devops-engineer.md) | Reverse proxy, CI smoke tests, shareable environment |
| 4 | [Ship and Demo](bonus-tech-sprint-track/phase-4-deploy-demo/devops-engineer.md) | Verify environment, write docs, demo contribution |
| 5 | [Agentic Workflows](bonus-tech-sprint-track/phase-5-agentic-workflows/devops-engineer.md) | Issue triage, workflow security review |

## Tips for Using Copilot on This Track

- Use the GitHub MCP server to convert your functional spec into Issues quickly -- point Copilot at the spec file and ask it to break features into stories.
- **Developers:** Describe API contracts and component props in terms of the project domain (trails, difficulty ratings, conditions) rather than generic CRUD.
- **QA:** Describe the user flow first ("submit a trail condition report, verify it appears"), then ask for the Playwright test.
- **DevOps:** State the target infrastructure (stages, base image, constraints) and let Copilot generate the manifest.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [MCP Servers Guide](../docs/mcp-servers.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)
