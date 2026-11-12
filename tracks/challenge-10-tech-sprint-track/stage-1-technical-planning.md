# Stage 1: Technical Planning

**Duration:** 60 minutes for the core; role-page estimates cover the extended backlog
**Focus:** Read the specification, create a technical spec, set up tooling, break work into Issues, plan Sprint 1

Turn the functional specification into a technical plan and set up the development environment.

Before setup, check that `.github/copilot-instructions.md` describes TrailMate for all roles. Agree on one shared skill, such as spec-to-issues or sprint board sync, to keep handoffs consistent.

## Jump to Your Role

Pick your role for the detailed task list:

| Role | Time | Summary |
|------|------|---------|
| [Backend Developer](stage-1-technical-planning/backend-developer.md) | ~1 hr setup + 30 min planning | Scaffold backend, finalize API spec, custom instructions |
| [Frontend Developer](stage-1-technical-planning/frontend-developer.md) | ~1 hr setup + 30 min planning | Scaffold frontend, design component hierarchy, coordinate with backend |
| [QA Engineer](stage-1-technical-planning/qa-engineer.md) | ~1 hr setup + 30 min planning | Set up Playwright, write test plan, define test data needs |
| [DevOps Engineer](stage-1-technical-planning/devops-engineer.md) | ~1 hr setup + 30 min planning | Devcontainer config, CI pipeline, branching strategy |

## Before You Start

Read the functional specification together:

1. Open `challenges/challenge-10-tech-sprint/docs/functional-spec.md`
2. Read the whole document as a team (10 minutes)
3. Resolve open questions before the sprint
4. Assign one person to fill in `challenges/challenge-10-tech-sprint/docs/technical-spec-template.md` during Stage 1, with contributions from everyone

## Creating the Backlog

There is no Product Owner, so the team creates the GitHub Issues together in the first 20 minutes:

1. One person creates a GitHub Project board with columns: Backlog, Sprint 1, In Progress, Review, Done
2. Each developer reads the spec section closest to their role and writes 3-5 user stories as GitHub Issues using the template in `challenges/challenge-10-tech-sprint/templates/user-story-issue.md`
3. Label each Issue with its epic, priority, and size
4. Review the Issues together and resolve overlaps and gaps

Ask Copilot to draft user stories from the functional spec. Use GitHub MCP Server to create the Issues.

## Sync Point: Sprint Planning Meeting (at ~1:00)

At the 1-hour mark, pause setup for a 30-minute planning session:

1. Walk through the GitHub Project board and review the Issues (10 min)
2. Each role picks their Sprint 1 stories (10 min)
3. Resolve blockers and dependencies, such as the frontend's API spec and QA's seed data (5 min)
4. Agree on a mid-sprint standup time (5 min)

After planning, everyone knows their Sprint 1 tasks and has no blockers.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Sprint 1 -- Core Features](stage-2-sprint-1-build.md)
