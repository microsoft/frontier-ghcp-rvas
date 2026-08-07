# Phase 3: Sprint 2 -- Backend Developer Tasks

**Time: Full 2 hours**

## Tasks

1. **Fix Sprint 1 bugs** -- Any bugs filed by QA take priority over new features.

2. **Add search and filtering** (if scoped):
   - `GET /api/reports?category=pothole&status=submitted` -- Filter reports by category and status
   - `GET /api/reports?search=main+street` -- Text search on title and description

3. **Dashboard statistics endpoint** (if scoped):
   - `GET /api/stats` -- Return total reports, reports by category, reports by status, upcoming event count

4. **Add authentication** (if scoped):
   - `POST /api/auth/register` -- Create a user account
   - `POST /api/auth/login` -- Return a JWT or session token
   - Protect write endpoints behind authentication middleware

5. **Open PRs** for each feature. Keep them small and reviewable.

## Verification

- [ ] Sprint 1 bugs fixed
- [ ] At least one advanced feature shipped (search, stats, or auth)
- [ ] All PRs reviewed and merged

---

Previous: [Phase 2: Sprint 1 -- Backend Developer Tasks](../phase-2-sprint-1-build/backend-developer.md) | Next: [Phase 4: Ship and Demo -- Backend Developer Tasks](../phase-4-deploy-demo/backend-developer.md)
