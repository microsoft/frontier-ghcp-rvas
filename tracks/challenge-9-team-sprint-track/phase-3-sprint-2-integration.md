# Phase 3: Sprint 2 -- Integration and Polish

**Duration:** 2 hours
**Focus:** Integration, advanced features, bug fixing, deployment preparation

Sprint 2 builds on the core features from Sprint 1. The priority shifts: integrate the frontend with the real backend, fix bugs that QA found, add advanced features where capacity allows, and get the first deployment working.

## Sprint 2 Planning (first 10 minutes)

Quick planning led by the PO. Do not spend more than 10 minutes on this.

1. **Carry-over** -- Anything unfinished from Sprint 1 gets highest priority.
2. **Bug fixes** -- QA filed bugs. The PO decides which are Sprint 2 fixes and which are deferred to a known-issues list.
3. **New features** -- Authentication, search/filter, and dashboard are candidates. Pick based on what the team can realistically finish in 2 hours.
4. **Assign work** -- Each role picks their Sprint 2 Issues from the board.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | Focus This Phase | Key Deliverable |
|------|-----------------|-----------------|
| [Product Owner](phase-3-sprint-2-integration/product-owner.md) | Bug triage, PR reviews, release notes, demo prep | Release notes drafted, demo outline ready |
| [Backend Developer](phase-3-sprint-2-integration/backend-developer.md) | Bug fixes, search/filter, stats endpoint, auth | At least one advanced feature shipped |
| [Frontend Developer](phase-3-sprint-2-integration/frontend-developer.md) | Connect to real API, dashboard, responsive design | No more mocked data in the critical path |
| [QA Engineer](phase-3-sprint-2-integration/qa-engineer.md) | Regression tests, Sprint 2 tests, cross-browser, a11y | Full E2E suite against integrated app |
| [DevOps Engineer](phase-3-sprint-2-integration/devops-engineer.md) | Reverse proxy, CI smoke tests, shareable environment | Full stack running reliably in Codespaces |
| [Business Analyst](phase-3-sprint-2-integration/business-analyst.md) | Acceptance tests, known issues doc *(optional role)* | All features validated, known issues listed |

## Sync Point: Integration Check (at ~5:30, 1 hour into Sprint 2)

A brief 5-minute check-in:

- Is the frontend connected to the real backend?
- Are there any deployment blockers?
- What will be ready for the demo vs. what will not?

This is the last chance to cut scope. If the team is behind, drop the dashboard and authentication. Focus on getting a working report submission flow running end-to-end in the Codespace.

---

Previous: [Phase 2: Sprint 1 -- Core Features](phase-2-sprint-1-build.md) | Next: [Phase 4: Ship and Demo](phase-4-deploy-demo.md)
