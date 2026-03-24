# Phase 2: Sprint 1 -- QA Engineer Tasks

[Back to Phase 2 Overview](../phase-2-sprint-1-build.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: Full 3 hours**

Write tests in parallel with development. Start with stubs or mocks if endpoints are not ready yet. Switch to the real app as features land.

## Tasks

### Trail Browsing Flow

- Test that the trail list page loads and shows trails
- Test filtering by difficulty or status
- Test clicking a trail to view its detail page

### Condition Report Submission Flow

- Test selecting a trail and filling in the condition report form
- Test form validation (missing required fields)
- Test that a submitted report appears on the trail detail page

### API Tests

Using Playwright's API testing or a separate framework:

- `GET /api/trails` returns an array of trails
- `GET /api/trails/:id` returns a single trail with condition reports
- `POST /api/trails/:trailId/reports` returns 201 and the created report
- Validation errors return 400 with a meaningful message

### Exploratory Testing and Bug Reports

As features become available, do exploratory testing. File bugs as GitHub Issues using the template in `challenges/bonus-4-tech-sprint/templates/bug-report-issue.md`. Include:

- Steps to reproduce
- Expected vs. actual behavior
- Screenshot or error message
- Labels: `bug` and a priority label

### Test Reporting

Configure Playwright's HTML reporter or a custom reporter so results can be shared with the team.

## Copilot Tip

```text
"Create a Playwright page object for the Trail List page with selectors for the search input,
difficulty filter dropdown, status filter, and trail cards."
```

## Verification

- [ ] Trail browsing tests passing (or stubbed and ready)
- [ ] Condition report submission tests passing (or stubbed and ready)
- [ ] At least 1 API test written
- [ ] Test reporting configured

---

Previous: [Phase 1 -- QA Engineer Tasks](../phase-1-technical-planning/qa-engineer.md) | Next: [Phase 3 -- QA Engineer Tasks](../phase-3-sprint-2-integration/qa-engineer.md)
