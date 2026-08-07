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

---

Next: [Phases](challenge-9-team-sprint-track/phases.md)
