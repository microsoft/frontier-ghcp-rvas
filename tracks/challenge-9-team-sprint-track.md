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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-9-team-sprint/`. Read the [stakeholder brief](../challenges/challenge-9-team-sprint/docs/stakeholder-brief.md) as a team before starting Phase 1. Everyone should skim the starter scaffolding for their own role before the team commits to any instructions or agents.

A dedicated devcontainer is provided at `.devcontainer/challenge-9-team-sprint/` with Node.js LTS, Python 3.11, GitHub CLI, and Playwright.

### Repository Instructions for This Track

Repository instructions are shared, not role-specific. Each team member should contribute to one `.github/copilot-instructions.md`. At minimum include:

- The project name (CityPulse) and what it does
- The team's chosen tech stack (backend framework, frontend framework, database)
- Code conventions the team agreed on (naming, file structure, API patterns)
- Non-negotiable: the exported Spark handover repo is the contract -- do not roll back to Spark once development starts

Individual team members can also maintain role-specific context in their agent definitions.

### Suggested Custom Agents

Agents are role-specific -- each person builds the one matching their role, informed by the shared repository instructions above:

- **Product Strategist Agent** -- Helps the PO turn a raw idea into backlog-ready work: user stories, acceptance criteria, and release notes. Give it a feature idea or stakeholder note; it drafts the story and criteria in the team's format. Use it throughout Discovery and whenever new scope reaches the board, not for grooming code-level tasks.
- **Engineering Conventions Agent** -- Applies CityPulse's technical conventions on whichever layer its owner works: REST resource shapes, status codes, and the data model for backend developers, or component patterns and styling approach for frontend developers. Give it an endpoint or component description; it proposes the shape consistent with the rest of the app. Backend and frontend developers each build their own instance scoped to their layer; use it when designing new work, not for writing its tests.
- **Quality and Infrastructure Agent** -- Applies delivery judgment on whichever side its owner covers: Playwright E2E coverage with page object patterns for QA, or devcontainer configuration, GitHub Actions, and environment setup for DevOps. Give it a working feature or an infrastructure requirement; it proposes the test list or the pipeline/devcontainer shape. QA and DevOps each build their own instance scoped to their responsibility; use it once a feature is testable or when the environment needs to change.

Agree on the roster during sprint planning so everyone builds against the same project context.

### Suggested Custom Skills

Workflow skills are shared team assets, not tied to one role. Agree on these together so board hygiene and handoffs stay consistent no matter who does the work:

- **Sprint Board Sync Skill** -- A repeatable sequence run after every merge: update the issue's status, link the PR, and note any scope change discovered during implementation. Keeps GitHub Issues honest without a separate status meeting.
- **Discovery Handoff Skill** -- The fixed sequence for turning the Spark prototype into the development contract: export it into the repository, confirm the exported structure matches what developers need, and document anything explicitly out of scope. Run once, at the Discovery-to-Sprint 1 boundary.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "team sprint agents", "issue sync skill", and "cross-functional instructions" before you draft your own.

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
