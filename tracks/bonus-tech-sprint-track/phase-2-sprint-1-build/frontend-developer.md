# Phase 2: Sprint 1 -- Frontend Developer Tasks

[Back to Phase 2 Overview](../phase-2-sprint-1-build.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: Full 3 hours**

Build the core UI pages. Use mocked data while the API is being built, then swap to real API calls when the backend is ready.

## Tasks

### Trail List Page

- Fetch and display all trails from `GET /api/trails`
- Show name, difficulty badge, distance, elevation, and status indicator per trail
- Color-coded status indicators (Open = green, Caution = yellow, Closed = red)
- Click a trail to navigate to its detail page

### Trail Detail Page

- Fetch trail details from `GET /api/trails/:id`
- Display all trail fields (description, difficulty, distance, elevation, estimated time, park, status)
- Show recent condition reports inline below the trail information
- Visual warning if the trail has High-severity reports

### Condition Report Form

- Form with fields: trail selector (or pre-filled if accessed from a trail page), type (dropdown), severity (dropdown), description (textarea)
- Client-side validation (required fields)
- Submit calls `POST /api/trails/:trailId/reports` (or logs to console as placeholder)
- Success and error feedback

### Navigation

Working nav between Home, Browse Trails, and Submit Report pages.

### Pull Requests

One PR per page or feature. Link to the GitHub Issue.

## Copilot Tip

Generate mock data while waiting for the API:

```typescript
// Generate an array of 10 sample TrailMate trails with realistic hiking data
// Include: id, name, description, difficulty, distanceKm, elevationGainM, estimatedTime, status, park
```

## Verification

- [ ] Trail list page rendering data
- [ ] Trail detail page showing trail info and condition reports
- [ ] Condition report form submitting data (to API or console)
- [ ] Navigation between pages working
- [ ] PRs opened and linked to their GitHub Issues

---

Previous: [Phase 1 -- Frontend Developer Tasks](../phase-1-technical-planning/frontend-developer.md) | Next: [Phase 3 -- Frontend Developer Tasks](../phase-3-sprint-2-integration/frontend-developer.md)
