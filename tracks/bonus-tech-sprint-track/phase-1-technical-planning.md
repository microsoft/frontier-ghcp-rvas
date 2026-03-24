# Phase 1: Technical Planning

[Back to Technical Team Sprint Track](../bonus-tech-sprint-track.md)

**Duration:** 1.5 hours
**Focus:** Read the specification, create a technical spec, set up tooling, break work into Issues, plan Sprint 1

This phase replaces the product discovery step found in other team tracks. The functional specification is already written -- your job is to turn it into a technical plan and get everything ready to build.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | Time | Summary |
|------|------|---------|
| [Backend Developer](phase-1-technical-planning/backend-developer.md) | ~1 hr setup + 30 min planning | Scaffold backend, finalize API spec, custom instructions |
| [Frontend Developer](phase-1-technical-planning/frontend-developer.md) | ~1 hr setup + 30 min planning | Scaffold frontend, design component hierarchy, coordinate with backend |
| [QA Engineer](phase-1-technical-planning/qa-engineer.md) | ~1 hr setup + 30 min planning | Set up Playwright, write test plan, define test data needs |
| [DevOps Engineer](phase-1-technical-planning/devops-engineer.md) | ~1 hr setup + 30 min planning | Dockerfile, docker-compose, CI pipeline, branching strategy |

## Before You Start

Everyone reads the functional specification together:

1. Open `challenges/bonus-4-tech-sprint/docs/functional-spec.md`
2. Read through the entire document as a team (10 minutes)
3. Discuss any questions or ambiguities -- resolve them now, not mid-sprint
4. Assign one person to fill in `challenges/bonus-4-tech-sprint/docs/technical-spec-template.md` during Phase 1, with contributions from everyone

## Creating the Backlog

Since there is no Product Owner, the team creates the GitHub Issues together. During the first 20 minutes:

1. One person creates a GitHub Project board with columns: Backlog, Sprint 1, In Progress, Review, Done
2. Each developer reads the spec section closest to their role and writes 3-5 user stories as GitHub Issues using the template in `challenges/bonus-4-tech-sprint/templates/user-story-issue.md`
3. Label each Issue with its epic, priority, and size
4. The team reviews the Issues together and resolves any overlaps or gaps

Use Copilot to speed this up -- paste the functional spec into chat and ask it to generate user stories for each epic.

## Sync Point: Sprint Planning Meeting (at ~1:00)

At the 1-hour mark, everyone pauses setup and joins a 30-minute planning session:

1. Walk through the GitHub Project board and review the Issues (10 min)
2. Each role picks their Sprint 1 stories (10 min)
3. Resolve blockers and dependencies -- for example, the frontend needs the API spec, QA needs seed data (5 min)
4. Agree on a mid-sprint standup time (5 min)

After planning, everyone should have clear tasks and an unblocked path into Sprint 1.

---

Next: [Phase 2: Sprint 1 -- Core Features](phase-2-sprint-1-build.md)
