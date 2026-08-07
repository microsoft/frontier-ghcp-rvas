# Stage 3: Sprint 2 -- DevOps Engineer Tasks

**Time: Full 2 hours**

## Tasks

1. **Add a reverse proxy** -- Configure nginx as a reverse proxy inside the Codespace that routes `/api/` to the backend and `/` to the frontend. This gives the whole stack a single entry point on one port and eliminates browser CORS issues.

2. **Make the environment shareable** -- Verify that anyone on the team can start the full application from a fresh Codespace with a single command:
   - Opening the Codespace should install all dependencies automatically
   - All required environment variables should have defaults in `.env.example`
   - Write or update `docs/local-setup.md` with the full startup sequence

3. **Add a CI smoke test** -- Update the GitHub Actions workflow to start all services, wait for the health check to pass, and run basic requests against the API:
   - `GET /health` responds 200
   - `GET /api/trails` returns a JSON array (even if empty)
   - Stop the services cleanly after the test

4. **Review service logs** -- Confirm that each service writes structured logs readable in the terminal. Each service should log at an appropriate level (info for requests, error for failures). Fix anything that logs nothing or is too noisy.

If your infrastructure agent produces an incomplete smoke test or reverse proxy config, refine its service and health-check guidance before calling the environment shareable.

## Verification

- [ ] Reverse proxy routing `/api/` to backend and `/` to frontend
- [ ] Another team member can start the full environment from a fresh Codespace
- [ ] `docs/local-setup.md` written
- [ ] CI workflow runs a smoke test against the running services

---

Previous: [Stage 2: Sprint 1 -- DevOps Engineer Tasks](../stage-2-sprint-1-build/devops-engineer.md) | Next: [Stage 4: Ship and Demo -- DevOps Engineer Tasks](../stage-4-deploy-demo/devops-engineer.md)
