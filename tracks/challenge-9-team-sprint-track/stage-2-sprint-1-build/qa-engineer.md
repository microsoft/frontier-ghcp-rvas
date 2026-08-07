# Phase 2: Sprint 1 -- QA Engineer Tasks

**Time: Full 3 hours**

Write tests in parallel with development. Start with stubs or mocks if endpoints are not ready yet. Switch to the real app as features land.

## Tasks

### Report Submission Flow

- Test filling in the report form and submitting
- Test form validation (empty title, missing category)
- Test that a submitted report appears in the reports list

### Events Browsing Flow

- Test that the events page loads and shows events
- Test event details display correctly

### API Tests

Using Playwright's API testing or a separate framework:

- `POST /api/reports` returns 201 and the created report
- `GET /api/reports` returns an array
- Validation errors return 400 with a meaningful message

### Exploratory Testing and Bug Reports

As features become available, do exploratory testing. File bugs as GitHub Issues using the template in `challenges/challenge-9-team-sprint/templates/bug-report-issue.md`. Include:

- Steps to reproduce
- Expected vs. actual behavior
- Screenshot or error message
- Labels: `bug` and a priority label

### Test Reporting

Configure Playwright's HTML reporter or a custom reporter so results can be shared with the team.

## Copilot Tip

```text
"Create a Playwright page object for the Report Submission page with selectors for title input,
description textarea, category dropdown, location input, and submit button."
```

## Verification

- [ ] Report submission tests passing (or stubbed and ready)
- [ ] Events browsing tests passing (or stubbed and ready)
- [ ] At least 1 API test written
- [ ] Test reporting configured

---

Previous: [Phase 1: Discovery and Planning -- QA Engineer Tasks](../phase-1-discovery-planning/qa-engineer.md) | Next: [Phase 3: Sprint 2 -- QA Engineer Tasks](../phase-3-sprint-2-integration/qa-engineer.md)
