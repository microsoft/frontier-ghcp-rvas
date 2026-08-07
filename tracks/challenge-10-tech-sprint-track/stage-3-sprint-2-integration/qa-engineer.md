# Stage 3: Sprint 2 -- QA Engineer Tasks

**Time: Full 2 hours**

## Tasks

1. **Run Sprint 1 tests against the integrated app** -- The frontend and backend are now connected. Run the full suite and note any regressions.

2. **Write tests for new Sprint 2 features:**
   - Search and filtering (search for a trail by name, filter by difficulty)
   - Dashboard page loads and displays statistics
   - Trail status updates and visual indicators
   - Authentication flow (register, login, submit a report as an authenticated user)

3. **Cross-browser testing** -- Run tests in at least Chromium and Firefox.

4. **Accessibility check** -- Use Playwright's accessibility snapshot or an axe-core integration to catch obvious accessibility problems.

5. **File new bugs** as GitHub Issues. Include screenshots whenever possible.

6. **Generate a test report** -- Share results with the team (HTML report, or paste a summary into a GitHub Issue).

If your test agent produces generic assertions or coverage that does not map to a TrailMate scenario, refine its guidance before relying on the test for the integration run.

## Verification

- [ ] Full E2E suite run against the integrated app
- [ ] At least 1 new test for Sprint 2 features
- [ ] Test report generated and shared

---

Previous: [Stage 2: Sprint 1 -- QA Engineer Tasks](../stage-2-sprint-1-build/qa-engineer.md) | Next: [Stage 4: Ship and Demo -- QA Engineer Tasks](../stage-4-deploy-demo/qa-engineer.md)
