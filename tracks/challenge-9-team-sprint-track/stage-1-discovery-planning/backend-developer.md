# Stage 1: Discovery and Planning -- Backend Developer Tasks

**Time: ~1 hour setup + 30 min planning**

## Tasks

Plan to actually use the api-architect agent for the REST design judgment calls it exists for, resource shapes, status codes, error handling, not just to have it sit in `.github/agents/`.

1. **Set up the development environment** -- Choose a backend framework (Express.js or FastAPI). Create the project scaffold:
   - Initialize the project (`npm init` or set up a virtualenv)
   - Set up folder structure (routes, models, middleware)
   - Add a health check endpoint (`GET /health`)
   - Verify it runs locally

2. **Write custom instructions** -- Add backend context to `.github/copilot-instructions.md`: framework, API conventions, error handling patterns, database choice.

3. **Create a backend agent** -- Create `.github/agents/api-architect.agent.md` with context about REST design, the CityPulse data model, and coding standards.

4. **Draft the API spec** -- Create `docs/api-spec.md`. List the planned endpoints, request/response shapes, and status codes. Share this with the frontend developer so they can start building against it.

5. **Sprint planning** -- Join the PO's planning session. Review stories, ask questions, commit to Sprint 1 scope.

## Verification

- [ ] Backend project scaffolded and running locally
- [ ] Health check endpoint responding
- [ ] API spec document drafted and shared
- [ ] Custom instructions and agent created

---

Previous: [Stages](../stages.md) | Next: [Stage 2: Sprint 1 -- Backend Developer Tasks](../stage-2-sprint-1-build/backend-developer.md)
