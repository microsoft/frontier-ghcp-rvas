# Phase 2: Sprint 1 -- Backend Developer Tasks

[Back to Phase 2 Overview](../phase-2-sprint-1-build.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: Full 3 hours**

Build the core API endpoints. Open a separate PR for each logical feature and link it to the relevant GitHub Issue.

## Tasks

### Trails API

- `GET /api/trails` -- List all trails with optional filters (`?difficulty=Hard&status=Open&search=eagle`)
- `GET /api/trails/:id` -- Get a single trail by ID, including its recent condition reports
- `POST /api/trails` -- Create a new trail (used for seeding and admin)
- `PATCH /api/trails/:id` -- Update a trail (primarily for status changes)
- Input validation on all endpoints (reject missing required fields with 400)

### Condition Reports API

- `POST /api/trails/:trailId/reports` -- Submit a condition report for a trail
- `GET /api/trails/:trailId/reports` -- List condition reports for a trail, sorted by newest first
- Input validation (valid trail ID, required fields, valid type and severity enums)

### Seed Data

Create a script or endpoint that populates the database with sample trails and condition reports. The functional spec calls for at least 10 trails and 15-20 reports. QA and the frontend developer both need this.

### Tests

Write unit/integration tests for each endpoint. Cover happy paths and validation errors.

### Pull Requests

One PR per feature (Trails API, Condition Reports API, seed data). Link each to its GitHub Issue. Request review from another team member.

## Copilot Tip

```text
"Read docs/api-spec.md and generate an Express.js router for the Trails endpoints with input validation."
```

## Verification

- [ ] Trails API working (testable with curl or a REST client)
- [ ] Condition Reports API working
- [ ] Seed data script or endpoint available for the team
- [ ] Backend tests passing
- [ ] PRs opened and linked to their GitHub Issues

---

Previous: [Phase 1 -- Backend Developer Tasks](../phase-1-technical-planning/backend-developer.md) | Next: [Phase 3 -- Backend Developer Tasks](../phase-3-sprint-2-integration/backend-developer.md)
