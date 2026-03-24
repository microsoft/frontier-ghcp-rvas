# Phase 2: Sprint 1 -- Core Features

[Back to Technical Team Sprint Track](../bonus-tech-sprint-track.md)

**Duration:** 3 hours
**Focus:** Parallel development of core features -- API, UI, tests, and infrastructure

Everyone works in parallel on their assigned Sprint 1 stories. Use GitHub Issues for questions and PRs for code review. Without a dedicated PO, the team self-manages: developers review each other's PRs and each person manages their own Issues on the board.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | What You Build | Key Deliverable |
|------|---------------|-----------------|
| [Backend Developer](phase-2-sprint-1-build/backend-developer.md) | Trails CRUD API, Condition Reports API, seed data | Working endpoints testable with curl |
| [Frontend Developer](phase-2-sprint-1-build/frontend-developer.md) | Trail list, trail detail, condition report form, navigation | Pages rendering with data |
| [QA Engineer](phase-2-sprint-1-build/qa-engineer.md) | E2E tests, API tests, exploratory testing, bug reports | Test suite and filed bugs |
| [DevOps Engineer](phase-2-sprint-1-build/devops-engineer.md) | Frontend Dockerfile, full docker-compose, CI, IaC | Full stack running in containers |

## Sync Point: Mid-Sprint Standup (at ~3:00, roughly 1.5 hours into Sprint 1)

Brief 5-minute standup, either in person or asynchronous via a GitHub Issue labeled `standup`. Each person answers:

1. What did I finish since the last check-in?
2. What am I working on now?
3. Am I blocked on anything?

If anyone is blocked, resolve it immediately. If the frontend developer needs the API spec finalized, that takes priority. If QA needs seed data, the backend developer provides it.

## Copilot Tips for This Phase

**Backend -- generate CRUD fast:**

Ask Copilot to scaffold an entire router from your API spec document. Reference the spec file in your prompt for context:

```text
"Read docs/api-spec.md and generate an Express.js router for the Trails endpoints with input validation."
```

**Frontend -- mock data while waiting for the API:**

```typescript
// Generate an array of 10 sample TrailMate trails with realistic hiking data
// Include: id, name, description, difficulty, distanceKm, elevationGainM, estimatedTime, status, park
```

**QA -- generate page objects from the spec:**

```text
"Create a Playwright page object for the Trail List page with selectors for the search input,
difficulty filter dropdown, status filter, and trail cards."
```

**DevOps -- generate Dockerfiles with Copilot:**

```text
"Create a multi-stage Dockerfile for a React app built with Vite.
Build stage uses Node 20, production stage uses nginx:alpine."
```

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

- [ ] docker-compose runs the full stack locally
- [ ] CI pipeline runs on PR and reports pass/fail
- [ ] Infrastructure-as-code started (Terraform or Bicep files created)

---

Previous: [Phase 1: Technical Planning](phase-1-technical-planning.md) | Next: [Phase 3: Sprint 2 -- Integration and Polish](phase-3-sprint-2-integration.md)
