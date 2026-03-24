# Phase 1: Technical Planning -- Backend Developer Tasks

[Back to Phase 1 Overview](../phase-1-technical-planning.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: ~1 hour setup + 30 min planning**

## Tasks

1. **Set up the development environment** -- Choose a backend framework (Express.js or FastAPI). Create the project scaffold:
   - Initialize the project (`npm init` or set up a virtualenv)
   - Set up folder structure (routes, models, middleware)
   - Add a health check endpoint (`GET /health`)
   - Verify it runs locally

2. **Write custom instructions** -- Add backend context to `.github/copilot-instructions.md`: framework, API conventions, error handling patterns, database choice.

3. **Create a backend agent** -- Create `.github/agents/api-architect.agent.md` with context about REST design, the TrailMate data model, and coding standards.

4. **Finalize the API spec** -- The functional spec suggests endpoints. Review them, adjust as needed, and write the definitive API spec in `docs/api-spec.md`. List the planned endpoints, request/response shapes, and status codes. Share this with the frontend developer so they can start building against it.

5. **Write user stories** -- Create 3-5 GitHub Issues for the Trails and Condition Reports epics. Use the template in `challenges/bonus-4-tech-sprint/templates/user-story-issue.md`.

6. **Sprint planning** -- Join the planning session. Review all Issues, pick your Sprint 1 scope.

## Verification

- [ ] Backend project scaffolded and running locally
- [ ] Health check endpoint responding
- [ ] API spec document drafted and shared
- [ ] Custom instructions and agent created
- [ ] User stories created as GitHub Issues

---

Next: [Phase 2 -- Backend Developer Tasks](../phase-2-sprint-1-build/backend-developer.md)
