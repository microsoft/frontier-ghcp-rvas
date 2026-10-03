# Challenge 9 Track: Cross-Functional Team Sprint

**Duration:** 4-6 hours (five-hour core; extended backlog is optional)

**Difficulty:** ⭐⭐⭐

**Focus:** Develop a product from ideation to production deployment with a cross-functional team using GitHub Copilot

> This track requires a team. It is not designed for solo participants. Gather 4-6 people from different disciplines and run through it together.

## Who is this for

- Teams of 4-6 people from different disciplines who want to build a complete application together
- Organizations that want to simulate a real agile sprint powered by GitHub Copilot
- Groups with mixed experience across product, development, QA, and operations

## Team composition

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

## Technology stack

The team chooses their stack together. Recommended options:

- **Backend:** Node.js with Express (or Python with FastAPI)
- **Frontend:** React with TypeScript and Vite (or Vue/Svelte)
- **Database:** SQLite for development, PostgreSQL for production (optional)
- **Testing:** Playwright for E2E, Jest or pytest for unit tests
- **Infrastructure:** GitHub Codespaces (devcontainers), GitHub Actions
- **Collaboration:** GitHub Issues, GitHub Projects, GitHub Spark
- **UI review:** Impeccable, installed manually by the frontend developer

## How this track works

The team works in parallel within each stage.

The challenge runs as a simulated sprint cycle:

1. The PO prototypes an idea with GitHub Spark, exports it to a GitHub repository, and creates stories and a backlog in GitHub Issues. The export becomes the development contract. Do not return to Spark after handover. Other roles set up tooling and project scaffolding.
2. **Sprint 1** -- All roles work in parallel on their piece. Developers build core features (using the Spark handover repo as reference), QA writes tests, DevOps sets up infrastructure, the PO manages the board and reviews PRs.
3. **Sprint 2** -- The team integrates, adds advanced features, fixes bugs, and starts deploying.
4. **Ship and Demo** -- Production deployment, final testing, demo, retrospective.

The PO and BA manage the backlog throughout the sprint. They triage bugs, review acceptance criteria, and prepare the demo. Use GitHub Issues to communicate between roles.

## The Challenge: CityPulse

Build CityPulse, a civic engagement platform for a fictional city government. Residents should be able to:

- **Report local issues** (potholes, broken streetlights, graffiti, noise complaints)
- **Browse community events** (posted by the city or by residents)
- **Track report status** (submitted, acknowledged, in progress, resolved)
- **View a dashboard** with neighborhood statistics (open reports, events this week, response times)

The stakeholder brief is in [challenges/challenge-9-team-sprint/docs/stakeholder-brief.md](../challenges/challenge-9-team-sprint/docs/stakeholder-brief.md). Read it as a team before sprint planning.

**Core scope:** report submission, readable report status, and upcoming events,
with API integration and a tested demo. Work in parallel. Keep the dashboard,
authentication, and agentic workflows outside the core. Azure deployment is a
stretch task if the team has not prepared an environment before the session.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-9-team-sprint/`. Read the [stakeholder brief](../challenges/challenge-9-team-sprint/docs/stakeholder-brief.md) as a team before starting Stage 1. Everyone should skim the starter scaffolding for their own role before the team commits to any instructions or agents.

A dedicated devcontainer is provided at `.devcontainer/challenge-9-team-sprint/` with Node.js LTS, Python 3.11, GitHub CLI, and Playwright.

### Install and use Impeccable

The frontend developer follows the [shared manual installation and discovery checks](getting-started.md#5-install-impeccable-when-your-track-uses-it)
after clean setup. Preflight a source file in the exported frontend. Use `shape`
for the report-submission journey in Stage 2, then review the working form and
reports list in Stage 3. Preserve the Spark handover contract. QA checks one
accepted improvement against the story's acceptance criteria; the dashboard
stays optional.

### Repository instructions for this track

Repository instructions are shared, not role-specific. Each team member should contribute to one `.github/copilot-instructions.md`. At minimum include:

- The project name (CityPulse) and what it does
- The team's chosen tech stack (backend framework, frontend framework, database)
- Code conventions the team agreed on (naming, file structure, API patterns)
- Non-negotiable: work from the exported Spark handover repo and do not return to Spark once development starts

Individual team members can also maintain role-specific context in their agent definitions.

### Suggested custom agents

Each person builds an agent for their role using the shared repository instructions:

- The PO and BA use a Product and Analysis Agent to draft stories, acceptance criteria, data definitions, dashboard metrics, and release notes from stakeholder input. It should follow the team's format and flag ambiguity.
- Backend and frontend developers each create an Engineering Conventions Agent for their layer. It should propose endpoints or components that follow CityPulse's API, data model, component, and styling conventions.
- QA and DevOps each create a Quality and Infrastructure Agent for their responsibility. QA uses it to review Playwright E2E coverage and page objects for working features. DevOps uses it to review devcontainers, GitHub Actions, and environment changes.

Agree on the roster during sprint planning so everyone builds against the same project context.

### Suggested custom skills

Agree on shared workflow skills to keep board updates and handoffs consistent:

- A Sprint Board Sync Skill updates issue status, links the PR, and records scope changes after each merge.
- A Discovery Handoff Skill checks the Spark export against the development team's needs and records what is out of scope before Sprint 1.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "team sprint agents", "issue sync skill", and "cross-functional instructions" before you draft your own.

---

## Tips for using Copilot on this track

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

---

Next: [Stages](challenge-9-team-sprint-track/stages.md)
