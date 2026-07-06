# Challenge 9 Track: Cross-Functional Team Sprint

**Duration:** 8-10 hours

**Difficulty:** ⭐⭐⭐

**Focus:** End-to-end product development in a cross-functional team -- from ideation to production deployment -- using GitHub Copilot across every role

> This track requires a team. It is not designed for solo participants. Gather 4-6 people from different disciplines and run through it together.

## Who Is This For

- Teams of 4-6 people from different disciplines who want to build a complete application together
- Organizations that want to simulate a real agile sprint powered by GitHub Copilot
- Groups with mixed experience across product, development, QA, and operations

## Team Composition

Each person takes exactly one role. The minimum viable team is 4 people.

| Role | Required | What They Do |
|------|----------|--------------|
| Product Owner | Yes | Ideation, user stories, backlog management, acceptance, demo |
| Backend Developer | Yes | API design, business logic, database, server-side tests |
| Frontend Developer | Yes | UI components, routing, styling, API integration |
| QA Engineer | Yes | Test strategy, E2E test automation, bug reporting |
| DevOps Engineer | Yes | Devcontainer config, CI/CD, environment setup |
| Business Analyst | Optional | Acceptance criteria, analytics requirements, data modeling |

If a participant has skills across multiple disciplines, they can take on more than one role. For example, a full-stack developer could cover both backend and frontend (simplify the UI scope accordingly), or the PO could absorb the BA role.

## Prerequisites

Each team member needs skills matching their assigned role:

- **PO / BA:** Familiarity with GitHub (Issues, Projects, Pull Requests). No code required.
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
- **Collaboration:** GitHub Issues, GitHub Projects, GitHub Spark

## How This Track Works

This is not a typical sequential track. The team works in parallel, like a real agile sprint.

The challenge runs as a simulated sprint cycle:

1. **Discovery** -- The PO prototypes an idea with GitHub Spark, exports the result into a GitHub repository (the handover), writes stories, and creates a backlog on GitHub Issues. The exported repo becomes the contract between the PO and the development team -- once it lands in a repo, there is no going back to Spark. Everyone else sets up tooling and project scaffolding.
2. **Sprint 1** -- All roles work in parallel on their piece. Developers build core features (using the Spark handover repo as reference), QA writes tests, DevOps sets up infrastructure, the PO manages the board and reviews PRs.
3. **Sprint 2** -- The team integrates, adds advanced features, fixes bugs, and starts deploying.
4. **Ship and Demo** -- Production deployment, final testing, demo, retrospective.

The PO and BA stay involved the entire time -- not just at the start. They manage the backlog, triage bugs, review work for acceptance criteria, and prepare the demo. GitHub Issues is the primary communication channel between roles.

## The Challenge: CityPulse

Your team is building **CityPulse** -- a civic engagement platform. A fictional city government has hired your team to build a web application where residents can:

- **Report local issues** (potholes, broken streetlights, graffiti, noise complaints)
- **Browse community events** (posted by the city or by residents)
- **Track report status** (submitted, acknowledged, in progress, resolved)
- **View a dashboard** with neighborhood statistics (open reports, events this week, response times)

The stakeholder brief is in [challenges/challenge-9-team-sprint/docs/stakeholder-brief.md](../challenges/challenge-9-team-sprint/docs/stakeholder-brief.md). Read it as a team before sprint planning.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Each team member should contribute to a shared `.github/copilot-instructions.md`. At minimum include:

- The project name (CityPulse) and what it does
- The team's chosen tech stack (backend framework, frontend framework, database)
- Code conventions the team agreed on (naming, file structure, API patterns)

Individual team members can also maintain role-specific context in their agent definitions.

### Suggested Agents

**Agents the team should consider creating together:**

- **Product Strategist Agent** -- Helps the PO write user stories, acceptance criteria, and release notes
- **API Architect Agent** -- Understands the CityPulse REST API conventions and data model
- **UI Component Agent** -- Knows the frontend framework, component patterns, and styling approach
- **Test Engineer Agent** -- Specializes in Playwright E2E tests with page object patterns
- **Infrastructure Agent** -- Focused on devcontainer configuration, GitHub Actions, and environment setup

Agree on shared agents during sprint planning so everyone benefits from the same project context.

### Open the Challenge

Navigate to `challenges/challenge-9-team-sprint/`. Read the [stakeholder brief](../challenges/challenge-9-team-sprint/docs/stakeholder-brief.md) as a team before starting Phase 1.

A dedicated devcontainer is provided at `.devcontainer/challenge-9-team-sprint/` with Node.js LTS, Python 3.11, GitHub CLI, and Playwright.

---

## Phases

| Phase | Name | Duration | What Happens |
|-------|------|----------|--------------|
| 1 | [Discovery and Sprint Planning](challenge-9-team-sprint-track/phase-1-discovery-planning.md) | 1.5 hours | PO ideates with GitHub Spark, writes stories, team plans Sprint 1 |
| 2 | [Sprint 1 -- Core Features](challenge-9-team-sprint-track/phase-2-sprint-1-build.md) | 3 hours | Parallel build: API, UI, tests, infrastructure |
| 3 | [Sprint 2 -- Integration and Polish](challenge-9-team-sprint-track/phase-3-sprint-2-integration.md) | 2 hours | Advanced features, integration, bug fixing, deployment |
| 4 | [Ship and Demo](challenge-9-team-sprint-track/phase-4-deploy-demo.md) | 1.5 hours | Production deployment, final testing, demo, retrospective |
| 5 | [Agentic Workflows](challenge-9-team-sprint-track/phase-5-agentic-workflows.md) | 1.5 hours | Add AI-powered repository automation with GitHub Agentic Workflows |

Work within each phase happens **in parallel** across roles. Each phase file has a "Jump to Your Role" table so you only read what applies to you.

> **Short on time?** Cut Sprint 2 scope: skip authentication and the dashboard, focus on deploying the core report and event features. This shaves roughly 1.5 hours off the total. Phase 5 (Agentic Workflows) is also optional and can be skipped if time is tight.

## Follow Your Role

Each phase contains detailed tasks for every role, broken into separate pages. Pick your role below to see all five phases at a glance -- or go to a specific phase and find your role there.

### Product Owner

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Discovery and Planning](challenge-9-team-sprint-track/phase-1-discovery-planning/product-owner.md) | Spark prototype, user stories, GitHub Issues, sprint planning |
| 2 | [Sprint 1](challenge-9-team-sprint-track/phase-2-sprint-1-build/product-owner.md) | PR reviews, bug triage, Sprint 2 backlog, board management |
| 3 | [Sprint 2](challenge-9-team-sprint-track/phase-3-sprint-2-integration/product-owner.md) | Bug triage, release notes, demo outline |
| 4 | [Ship and Demo](challenge-9-team-sprint-track/phase-4-deploy-demo/product-owner.md) | Final acceptance, lead demo, run retrospective |
| 5 | [Agentic Workflows](challenge-9-team-sprint-track/phase-5-agentic-workflows/product-owner.md) | Issue triage workflow, daily status report |

### Backend Developer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Discovery and Planning](challenge-9-team-sprint-track/phase-1-discovery-planning/backend-developer.md) | Scaffold project, draft API spec, custom instructions |
| 2 | [Sprint 1](challenge-9-team-sprint-track/phase-2-sprint-1-build/backend-developer.md) | Reports CRUD, Events API, seed data, tests |
| 3 | [Sprint 2](challenge-9-team-sprint-track/phase-3-sprint-2-integration/backend-developer.md) | Bug fixes, search/filter, stats endpoint, auth |
| 4 | [Ship and Demo](challenge-9-team-sprint-track/phase-4-deploy-demo/backend-developer.md) | Critical fixes, performance check, demo contribution |
| 5 | [Agentic Workflows](challenge-9-team-sprint-track/phase-5-agentic-workflows/backend-developer.md) | Code simplifier, test improver workflows |

### Frontend Developer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Discovery and Planning](challenge-9-team-sprint-track/phase-1-discovery-planning/frontend-developer.md) | Scaffold project, review Spark prototype, coordinate API |
| 2 | [Sprint 1](challenge-9-team-sprint-track/phase-2-sprint-1-build/frontend-developer.md) | Report form, reports list, events list, navigation |
| 3 | [Sprint 2](challenge-9-team-sprint-track/phase-3-sprint-2-integration/frontend-developer.md) | Connect to real API, dashboard, responsive design |
| 4 | [Ship and Demo](challenge-9-team-sprint-track/phase-4-deploy-demo/frontend-developer.md) | Critical UI fixes, visual polish, demo contribution |
| 5 | [Agentic Workflows](challenge-9-team-sprint-track/phase-5-agentic-workflows/frontend-developer.md) | Documentation updater, accessibility review |

### QA Engineer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Discovery and Planning](challenge-9-team-sprint-track/phase-1-discovery-planning/qa-engineer.md) | Set up Playwright, test plan, test data requirements |
| 2 | [Sprint 1](challenge-9-team-sprint-track/phase-2-sprint-1-build/qa-engineer.md) | E2E tests, API tests, exploratory testing, bug reports |
| 3 | [Sprint 2](challenge-9-team-sprint-track/phase-3-sprint-2-integration/qa-engineer.md) | Regression, Sprint 2 tests, cross-browser, accessibility |
| 4 | [Ship and Demo](challenge-9-team-sprint-track/phase-4-deploy-demo/qa-engineer.md) | Final regression, production smoke test, test report |
| 5 | [Agentic Workflows](challenge-9-team-sprint-track/phase-5-agentic-workflows/qa-engineer.md) | CI Doctor, daily QA workflow |

### DevOps Engineer

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Discovery and Planning](challenge-9-team-sprint-track/phase-1-discovery-planning/devops-engineer.md) | Devcontainer config, CI pipeline, branching strategy |
| 2 | [Sprint 1](challenge-9-team-sprint-track/phase-2-sprint-1-build/devops-engineer.md) | Environment setup, process scripts, CI |
| 3 | [Sprint 2](challenge-9-team-sprint-track/phase-3-sprint-2-integration/devops-engineer.md) | Reverse proxy, CI smoke tests, local networking |
| 4 | [Ship and Demo](challenge-9-team-sprint-track/phase-4-deploy-demo/devops-engineer.md) | Verify environment, write docs, demo contribution |
| 5 | [Agentic Workflows](challenge-9-team-sprint-track/phase-5-agentic-workflows/devops-engineer.md) | Workflow security, permissions review |

### Business Analyst (optional)

| Phase | Link | Focus |
|-------|------|-------|
| 1 | [Discovery and Planning](challenge-9-team-sprint-track/phase-1-discovery-planning/business-analyst.md) | Acceptance criteria, data model, dashboard metrics |
| 2 | [Sprint 1](challenge-9-team-sprint-track/phase-2-sprint-1-build/business-analyst.md) | Feature validation, analytics events, Sprint 2 refinement |
| 3 | [Sprint 2](challenge-9-team-sprint-track/phase-3-sprint-2-integration/business-analyst.md) | Acceptance tests, known issues, release notes help |
| 4 | [Ship and Demo](challenge-9-team-sprint-track/phase-4-deploy-demo/business-analyst.md) | Final walkthrough, known issues, retro notes |
| 5 | [Agentic Workflows](challenge-9-team-sprint-track/phase-5-agentic-workflows/business-analyst.md) | Weekly summary, discussion task miner |

## Tips for Using Copilot on This Track

- **PO:** Write a rough story first, then ask Copilot to sharpen it. Use the GitHub MCP server to batch-create Issues from your stories file.
- **Developers:** Describe the API contract or component structure in a comment before generating. The specifics (field names, status codes, prop types) matter more than length.
- **QA:** Describe the user flow you want to test, then ask for Playwright code. One sentence of intent beats a detailed template.
- **DevOps:** State the target ("devcontainer with Node 20, Python 3.11, and PostgreSQL") and let Copilot fill in the details.
- Each role benefits from anchoring prompts in the project domain (reports, categories, locations) rather than generic CRUD terms.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [MCP Servers Guide](../docs/mcp-servers.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)
