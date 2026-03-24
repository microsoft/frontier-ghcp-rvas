# Phase 1: Technical Planning -- QA Engineer Tasks

[Back to Phase 1 Overview](../phase-1-technical-planning.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: ~1 hour setup + 30 min planning**

## Tasks

1. **Set up the test framework** -- Initialize a Playwright project:
   - `npm init playwright@latest`
   - Configure browser targets (Chromium at minimum)
   - Create a base page object class
   - Write a smoke test that loads the frontend home page

2. **Write the test plan** -- Create `docs/test-plan.md`. List the user flows you plan to test, grouped by epic (Trails, Conditions, Dashboard). Include happy paths and key error cases.

3. **Write custom instructions** -- Add QA context to `.github/copilot-instructions.md`: test framework, page object patterns, assertion style.

4. **Create a test agent** -- Create `.github/agents/test-engineer.agent.md` with Playwright patterns and the project's page object conventions.

5. **Define test data requirements** -- Document what seed data the backend should provide for tests (sample trails with various difficulties and statuses, sample condition reports, test users if auth is scoped). Coordinate with the backend developer.

6. **Write user stories** -- Create 2-3 GitHub Issues for QA-specific work (test framework setup, E2E test suite, API test suite). Use the template in `challenges/bonus-4-tech-sprint/templates/user-story-issue.md`.

7. **Sprint planning** -- Join the planning session. Identify which stories you will write tests for in Sprint 1.

## Verification

- [ ] Playwright project initialized
- [ ] Smoke test passing
- [ ] Test plan documented
- [ ] Test data requirements shared with backend developer

---

Next: [Phase 2 -- QA Engineer Tasks](../phase-2-sprint-1-build/qa-engineer.md)
