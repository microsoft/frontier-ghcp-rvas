# Phase 2: Sprint 1 -- Frontend Developer Tasks

**Time: Full 3 hours**

Build the core UI pages. Use mocked data while the API is being built, then swap to real API calls when the backend is ready.

## Tasks

### Report Submission Form

- Form with fields: title (text), description (textarea), category (dropdown), location (text)
- Client-side validation (required fields, character limits)
- Submit calls `POST /api/reports` (or logs to console as a placeholder until the API exists)
- Success and error feedback

### Reports List Page

- Fetch and display all reports from `GET /api/reports`
- Show title, category, status, and submission date per report
- Color-coded status badges (submitted = yellow, in progress = blue, resolved = green)
- Click a report to view its details

### Events List Page

- Fetch and display upcoming events from `GET /api/events`
- Show title, date, location, and description
- Sort by date

### Navigation

Working nav between Home, Report Issue, View Reports, and Events pages.

### Pull Requests

One PR per page or feature. Link to the GitHub Issue.

## Copilot Tip

Generate mock data while waiting for the API:

```typescript
// Generate an array of 5 sample CityPulse reports with realistic civic issues
// Include: id, title, description, category, location, status, createdAt
```

## Verification

- [ ] Report form submitting data (to API or console)
- [ ] Reports list page rendering data
- [ ] Events list page rendering data
- [ ] Navigation between pages working
- [ ] PRs opened and linked to their GitHub Issues

---

Previous: [Phase 1: Discovery and Planning -- Frontend Developer Tasks](../phase-1-discovery-planning/frontend-developer.md) | Next: [Phase 3: Sprint 2 -- Frontend Developer Tasks](../phase-3-sprint-2-integration/frontend-developer.md)
