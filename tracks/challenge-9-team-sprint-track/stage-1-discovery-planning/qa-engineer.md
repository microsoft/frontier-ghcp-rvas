# Phase 1: Discovery and Planning -- QA Engineer Tasks

**Time: ~1 hour setup + 30 min planning**

## Tasks

Plan to lean on the test-engineer agent for judgment on which flows and edge cases matter most, not just to generate boilerplate test code.

1. **Set up the test framework** -- Initialize a Playwright project:
   - `npm init playwright@latest`
   - Configure browser targets (Chromium at minimum)
   - Create a base page object class
   - Write a smoke test that loads the frontend home page

2. **Write the test plan** -- Create `docs/test-plan.md`. List the user flows you plan to test, grouped by epic. Include happy paths and key error cases.

3. **Write custom instructions** -- Add QA context to `.github/copilot-instructions.md`: test framework, page object patterns, assertion style.

4. **Create a test agent** -- Create `.github/agents/test-engineer.agent.md` with Playwright patterns and the project's page object conventions.

5. **Define test data requirements** -- Document what seed data the backend should provide for tests (sample reports, sample events, test users). Coordinate with the backend developer.

6. **Sprint planning** -- Join the PO's planning session. Identify which stories you will write tests for in Sprint 1.

## Verification

- [ ] Playwright project initialized
- [ ] Smoke test passing
- [ ] Test plan documented

---

Previous: [Phases](../phases.md) | Next: [Phase 2: Sprint 1 -- QA Engineer Tasks](../phase-2-sprint-1-build/qa-engineer.md)
