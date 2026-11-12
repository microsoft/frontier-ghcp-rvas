# Stage 3: Sprint 2 -- Integration and Polish

**Duration:** 90 minutes for core integration and review
**Focus:** Integration, advanced features, bug fixing, deployment preparation

Connect the frontend to the backend and fix bugs from Sprint 1. Add advanced features only if time allows, then prepare the first deployment.

## Sprint 2 Planning (first 10 minutes)

Hold a 10-minute planning session.

1. **Carry-over** -- Unfinished Sprint 1 work comes first.
2. **Bug fixes** -- Decide which of QA's bugs are Sprint 2 fixes and which go to a known-issues list.
3. **New features** -- Trail status management, search/filter, dashboard, and authentication are candidates. Pick what the team can finish in 2 hours.
4. **Assign work** -- Each role picks their Sprint 2 Issues from the board.

## Jump to Your Role

Pick your role for the detailed task list:

| Role | Focus This Stage | Key Deliverable |
|------|-----------------|-----------------|
| [Backend Developer](stage-3-sprint-2-integration/backend-developer.md) | Bug fixes, search/filter, stats endpoint, auth | At least one advanced feature shipped |
| [Frontend Developer](stage-3-sprint-2-integration/frontend-developer.md) | Connect to real API, dashboard, responsive design | No more mocked data in the critical path |
| [QA Engineer](stage-3-sprint-2-integration/qa-engineer.md) | Regression tests, Sprint 2 tests, cross-browser, a11y | Full E2E suite against integrated app |
| [DevOps Engineer](stage-3-sprint-2-integration/devops-engineer.md) | Reverse proxy, environment polish, CI smoke test | Full stack running reliably in Codespaces |

## Sync Point: Integration Check (at ~5:30, 1 hour into Sprint 2)

A 5-minute check-in:

- Is the frontend connected to the real backend?
- Are there any deployment blockers?
- What will and won't be ready for the demo?

This is the last chance to cut scope. If you're behind, drop the dashboard and authentication and get the trail directory and condition reporting flow working end to end in the Codespace.

If repository instructions or the sprint board sync skill give roles conflicting guidance, fix them together before the demo. Check that backend and frontend use the same trail data model.

---

Previous: [Stage 2: Sprint 1 -- Core Features](stage-2-sprint-1-build.md) | Next: [Stage 4: Ship and Demo](stage-4-deploy-demo.md)
