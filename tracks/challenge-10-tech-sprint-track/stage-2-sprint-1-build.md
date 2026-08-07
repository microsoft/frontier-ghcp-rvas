# Stage 2: Sprint 1 -- Core Features

**Duration:** 3 hours
**Focus:** Parallel development of core features -- API, UI, tests, and infrastructure

Everyone works in parallel on their assigned Sprint 1 stories. Use GitHub Issues for questions and PRs for code review. Without a dedicated PO, the team self-manages: developers review each other's PRs and each person manages their own Issues on the board.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | What You Build | Key Deliverable |
|------|---------------|-----------------|
| [Backend Developer](stage-2-sprint-1-build/backend-developer.md) | Trails CRUD API, Condition Reports API, seed data | Working endpoints testable with curl |
| [Frontend Developer](stage-2-sprint-1-build/frontend-developer.md) | Trail list, trail detail, condition report form, navigation | Pages rendering with data |
| [QA Engineer](stage-2-sprint-1-build/qa-engineer.md) | E2E tests, API tests, exploratory testing, bug reports | Test suite and filed bugs |
| [DevOps Engineer](stage-2-sprint-1-build/devops-engineer.md) | Environment setup, process scripts, CI | Full stack running in the Codespace |

## Sync Point: Mid-Sprint Standup (at ~3:00, roughly 1.5 hours into Sprint 1)

Brief 5-minute standup, either in person or asynchronous via a GitHub Issue labeled `standup`. Each person answers:

1. What did I finish since the last check-in?
2. What am I working on now?
3. Am I blocked on anything?

If anyone is blocked, resolve it immediately. If the frontend developer needs the API spec finalized, that takes priority. If QA needs seed data, the backend developer provides it.

## Verification

**Backend Developer:**

- [ ] Trails CRUD API working (testable with curl or a REST client)
- [ ] Condition Reports API working
- [ ] Seed data script or endpoint available for the team
- [ ] Backend tests passing

**Frontend Developer:**

- [ ] Trail list page rendering data
- [ ] Trail detail page showing trail info and condition reports
- [ ] Condition report form submitting data (to API or console)
- [ ] Navigation between pages working

**QA Engineer:**

- [ ] At least 3 E2E tests written and passing (or pending API integration)
- [ ] At least 1 bug filed as a GitHub Issue from exploratory testing
- [ ] Test reporting configured

**DevOps Engineer:**

- [ ] All services start with a single command in the Codespace
- [ ] CI pipeline runs on PR and reports pass/fail

---

Previous: [Stage 1: Technical Planning](stage-1-technical-planning.md) | Next: [Stage 3: Sprint 2 -- Integration and Polish](stage-3-sprint-2-integration.md)
