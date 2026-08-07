# Phase 2: Sprint 1 -- Backend Developer Tasks

**Time: Full 3 hours**

Build the core API endpoints. Open a separate PR for each logical feature and link it to the relevant GitHub Issue.

## Tasks

### Reports API

- `POST /api/reports` -- Create a new report (title, description, category, location; status defaults to "submitted")
- `GET /api/reports` -- List all reports, sorted by newest first
- `GET /api/reports/:id` -- Get a single report by ID
- `PATCH /api/reports/:id` -- Update report status or details
- Input validation on all endpoints (reject missing required fields with 400)

### Events API

- `POST /api/events` -- Create a new event (title, description, date, location)
- `GET /api/events` -- List upcoming events, sorted by date
- `GET /api/events/:id` -- Get a single event by ID

### Seed Data

Create a script or endpoint that populates the database with sample reports and events. QA and the frontend developer both need this.

### Tests

Write unit/integration tests for each endpoint. Cover happy paths and validation errors.

### Pull Requests

One PR per feature (Reports API, Events API, seed data). Link each to its GitHub Issue. Request review from the PO for acceptance and from DevOps for any infrastructure concerns.

## Copilot Tip

```text
"Read docs/api-spec.md and generate an Express.js router for the Reports endpoints with input validation."
```

## Verification

- [ ] Reports CRUD API working (testable with curl or a REST client)
- [ ] Events API working
- [ ] Seed data script or endpoint available for the team
- [ ] Backend tests passing
- [ ] PRs opened and linked to their GitHub Issues

---

Previous: [Phase 1: Discovery and Planning -- Backend Developer Tasks](../phase-1-discovery-planning/backend-developer.md) | Next: [Phase 3: Sprint 2 -- Backend Developer Tasks](../phase-3-sprint-2-integration/backend-developer.md)
