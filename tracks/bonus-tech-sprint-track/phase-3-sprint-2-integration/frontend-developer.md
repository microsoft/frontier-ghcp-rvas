# Phase 3: Sprint 2 -- Frontend Developer Tasks

[Back to Phase 3 Overview](../phase-3-sprint-2-integration.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: Full 2 hours**

## Tasks

1. **Connect to the real backend API** -- Replace mocked data with actual API calls. Handle loading states, errors, and empty states.

2. **Fix Sprint 1 UI bugs** filed by QA.

3. **Search and filtering UI** (if the backend supports it):
   - Search bar and filter controls on the trail list page (difficulty dropdown, status dropdown)
   - Wire to API query parameters or filter client-side

4. **Dashboard page** (if scoped):
   - Fetch stats from `GET /api/stats`
   - Display with cards and simple charts (a bar chart for trail statuses, a breakdown of report types)
   - Use a lightweight chart library or build minimal visuals with CSS

5. **Trail status indicators** -- Add visual warnings for trails with High-severity condition reports. Show status badges prominently on both the list and detail pages.

6. **Responsive design** -- Verify the app works on mobile-width screens. Fix layout issues.

7. **Open PRs** for each feature.

## Verification

- [ ] Frontend connected to the real backend (no mocked data in the critical path)
- [ ] Sprint 1 UI bugs fixed
- [ ] At least one new feature added (dashboard, search/filter, or responsive improvements)

---

Previous: [Phase 2 -- Frontend Developer Tasks](../phase-2-sprint-1-build/frontend-developer.md) | Next: [Phase 4 -- Frontend Developer Tasks](../phase-4-deploy-demo/frontend-developer.md)
