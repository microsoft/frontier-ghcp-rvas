# Phase 3: Sprint 2 -- Integration and Polish

[Back to Technical Team Sprint Track](../bonus-tech-sprint-track.md)

**Duration:** 2 hours
**Focus:** Integration, advanced features, bug fixing, deployment preparation

Sprint 2 builds on the core features from Sprint 1. The priority shifts: integrate the frontend with the real backend, fix bugs that QA found, add advanced features where capacity allows, and get the first deployment working.

## Sprint 2 Planning (first 10 minutes)

Quick self-organized planning. Do not spend more than 10 minutes on this.

1. **Carry-over** -- Anything unfinished from Sprint 1 gets highest priority.
2. **Bug fixes** -- QA filed bugs. The team decides together which are Sprint 2 fixes and which go to a known-issues list.
3. **New features** -- Trail status management, search/filter, dashboard, and authentication are candidates. Pick based on what the team can realistically finish in 2 hours.
4. **Assign work** -- Each role picks their Sprint 2 Issues from the board.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | Focus This Phase | Key Deliverable |
|------|-----------------|-----------------|
| [Backend Developer](phase-3-sprint-2-integration/backend-developer.md) | Bug fixes, search/filter, stats endpoint, auth | At least one advanced feature shipped |
| [Frontend Developer](phase-3-sprint-2-integration/frontend-developer.md) | Connect to real API, dashboard, responsive design | No more mocked data in the critical path |
| [QA Engineer](phase-3-sprint-2-integration/qa-engineer.md) | Regression tests, Sprint 2 tests, cross-browser, a11y | Full E2E suite against integrated app |
| [DevOps Engineer](phase-3-sprint-2-integration/devops-engineer.md) | Reverse proxy, stack polish, CI smoke test, optional Azure | Full stack running from a single `docker compose up` |

## Sync Point: Integration Check (at ~5:30, 1 hour into Sprint 2)

A brief 5-minute check-in:

- Is the frontend connected to the real backend?
- Are there any deployment blockers?
- What will be ready for the demo vs. what will not?

This is the last chance to cut scope. If the team is behind, drop the dashboard and authentication. Focus on getting a working trail directory and condition reporting flow running end-to-end in the compose stack.

---

Previous: [Phase 2: Sprint 1 -- Core Features](phase-2-sprint-1-build.md) | Next: [Phase 4: Ship and Demo](phase-4-deploy-demo.md)
