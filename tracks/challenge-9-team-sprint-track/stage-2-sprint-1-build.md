# Stage 2: Sprint 1 -- Core Features

**Duration:** 3 hours
**Focus:** Parallel development of core features -- API, UI, tests, and infrastructure

Everyone works in parallel on their assigned Sprint 1 stories. Use GitHub Issues for questions and PRs for code review. The PO stays active on the board, triaging and reviewing throughout.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | What You Build | Key Deliverable |
|------|---------------|-----------------|
| [Product Owner](stage-2-sprint-1-build/product-owner.md) | Backlog management, PR reviews, Sprint 2 prep | Board reflects reality, Sprint 2 stories written |
| [Backend Developer](stage-2-sprint-1-build/backend-developer.md) | Reports CRUD API, Events API, seed data | Working endpoints testable with curl |
| [Frontend Developer](stage-2-sprint-1-build/frontend-developer.md) | Report form, reports list, events list, navigation | Pages rendering with data |
| [QA Engineer](stage-2-sprint-1-build/qa-engineer.md) | E2E tests, API tests, exploratory testing, bug reports | Test suite and filed bugs |
| [DevOps Engineer](stage-2-sprint-1-build/devops-engineer.md) | Environment setup, process scripts, CI | Full stack running in the Codespace |
| [Business Analyst](stage-2-sprint-1-build/business-analyst.md) | Feature validation, Sprint 2 refinement *(optional role)* | Validated features, analytics spec |

## Sync Point: Mid-Sprint Standup (at ~3:00, roughly 1.5 hours into Sprint 1)

Brief 5-minute standup, either in person or asynchronous via a GitHub Issue labeled `standup`. Each person answers:

1. What did I finish since the last check-in?
2. What am I working on now?
3. Am I blocked on anything?

If anyone is blocked, resolve it immediately. If the frontend developer needs the API spec finalized, that takes priority. If QA needs seed data, the backend developer provides it.

## Copilot Tips for This Stage

**Backend -- generate CRUD fast:**

Ask Copilot to scaffold an entire router from your API spec document. Reference the spec file in your prompt for context:

```text
"Read docs/api-spec.md and generate an Express.js router for the Reports endpoints with input validation."
```

**Frontend -- mock data while waiting for the API:**

```typescript
// Generate an array of 5 sample CityPulse reports with realistic civic issues
// Include: id, title, description, category, location, status, createdAt
```

**QA -- generate page objects from the running app:**

```text
"Create a Playwright page object for the Report Submission page with selectors for title input,
description textarea, category dropdown, location input, and submit button."
```

**DevOps -- generate devcontainer config with Copilot:**

```text
"Create a devcontainer.json that includes Node 20, Python 3.11,
and PostgreSQL. Add port forwarding for the backend on 3000 and frontend on 5173."
```

---

Previous: [Stage 1: Discovery and Sprint Planning](stage-1-discovery-planning.md) | Next: [Stage 3: Sprint 2 -- Integration and Polish](stage-3-sprint-2-integration.md)

**QA Engineer:**

- [ ] At least 3 E2E tests written and passing (or pending API integration)
- [ ] At least 1 bug filed as a GitHub Issue from exploratory testing
- [ ] Test reporting configured

**DevOps Engineer:**

- [ ] All services start with a single command in the Codespace
- [ ] CI pipeline runs on PR and reports pass/fail

**Business Analyst:**

- [ ] At least 3 completed features validated against acceptance criteria
- [ ] Sprint 2 acceptance criteria refined

---

Previous: [Stage 1: Discovery and Sprint Planning](stage-1-discovery-planning.md) | Next: [Stage 3: Sprint 2 -- Integration and Polish](stage-3-sprint-2-integration.md)
