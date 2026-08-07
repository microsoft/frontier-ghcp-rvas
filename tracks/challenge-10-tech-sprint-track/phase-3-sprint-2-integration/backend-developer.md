# Phase 3: Sprint 2 -- Backend Developer Tasks

**Time: Full 2 hours**

## Tasks

1. **Fix Sprint 1 bugs** -- Any bugs filed by QA take priority over new features.

2. **Add search and filtering** (if scoped):
   - `GET /api/trails?difficulty=Hard&status=Open` -- Filter trails by difficulty and status
   - `GET /api/trails?search=eagle` -- Text search on trail name and description

3. **Dashboard statistics endpoint** (if scoped):
   - `GET /api/stats` -- Return total trails by status, condition reports by type, most reported trails, recent activity

4. **Trail status management** (if scoped):
   - `PATCH /api/trails/:id` -- Update trail status with a reason referencing condition reports
   - Auto-flag trails with High-severity reports

5. **Add authentication** (if scoped):
   - `POST /api/auth/register` -- Create a user account
   - `POST /api/auth/login` -- Return a JWT or session token
   - Protect write endpoints behind authentication middleware

6. **Open PRs** for each feature. Keep them small and reviewable.

## Verification

- [ ] Sprint 1 bugs fixed
- [ ] At least one advanced feature shipped (search, stats, status management, or auth)
- [ ] All PRs reviewed and merged

---

Previous: [Phase 2: Sprint 1 -- Backend Developer Tasks](../phase-2-sprint-1-build/backend-developer.md) | Next: [Phase 4: Ship and Demo -- Backend Developer Tasks](../phase-4-deploy-demo/backend-developer.md)
