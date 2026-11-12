# Stage 3: Sprint 2 -- DevOps Engineer Tasks

**Time: Full 2 hours**

## Tasks

1. **Add a reverse proxy** -- Configure nginx in the Codespace as a reverse proxy in front of the backend and frontend. Route `/api/` to the backend and everything else to the frontend, so the frontend doesn't need the backend's port at runtime.

2. **Make the environment shareable** -- Check that anyone on the team can open the Codespace from a fresh branch and have a working application within a minute or two:
   - Document the setup steps in `docs/local-setup.md` (open Codespace, wait for post-create script, run the start command)
   - Confirm the database migrations or seed data run automatically on first start
   - Have another team member (or the QA engineer) try the steps from scratch

3. **Add a CI smoke test** -- Update the GitHub Actions workflow to start all services and verify the application responds. A simple `curl` against the health check endpoint is enough:

   ```yaml
   - name: Start services
     run: npm run dev &
   - name: Wait for startup
     run: sleep 10
   - name: Smoke test
     run: curl --fail http://localhost:3000/api/health
   ```

4. **Review service logs** -- Check that each service writes structured, readable logs to the terminal. If the backend uses a logger, check that the format is consistent.

If your infrastructure agent produces an incomplete smoke test or reverse proxy config, improve its service and health-check guidance before calling the environment shareable.

## Verification

- [ ] Reverse proxy routing `/api/` to backend and `/` to frontend
- [ ] Another team member can start the full environment from a fresh Codespace
- [ ] `docs/local-setup.md` written
- [ ] CI workflow runs a smoke test against the running services

---

Previous: [Stage 2: Sprint 1 -- DevOps Engineer Tasks](../stage-2-sprint-1-build/devops-engineer.md) | Next: [Stage 4: Ship and Demo -- DevOps Engineer Tasks](../stage-4-deploy-demo/devops-engineer.md)
