# Stage 3: Sprint 2 -- DevOps Engineer Tasks

**Time: Full 2 hours**

## Tasks

1. **Add a reverse proxy** -- Configure nginx as a reverse proxy inside the Codespace that sits in front of the backend and frontend. Route `/api/` to the backend and everything else to the frontend. This removes the need for the frontend to know the backend's port at runtime.

2. **Make the environment shareable** -- Make sure anyone on the team can open the Codespace from a fresh branch and have a working application within a minute or two:
   - Document the setup steps in `docs/local-setup.md` (open Codespace, wait for post-create script, run the start command)
   - Confirm the database migrations or seed data run automatically on first start
   - Test this by having another team member (or the QA engineer) try the steps from scratch

3. **Add a CI smoke test** -- Update the GitHub Actions workflow to start all services and verify the application responds. A simple `curl` against the health check endpoint is enough:

   ```yaml
   - name: Start services
     run: npm run dev &
   - name: Wait for startup
     run: sleep 10
   - name: Smoke test
     run: curl --fail http://localhost:3000/api/health
   ```

4. **Review service logs** -- Make sure each service writes structured logs that are readable in the terminal. If the backend uses a logger, confirm the format is consistent.

If your infrastructure agent produces an incomplete smoke test or reverse proxy config, refine its service and health-check guidance before calling the environment shareable.

## Verification

- [ ] Reverse proxy routing `/api/` to backend and `/` to frontend
- [ ] Another team member can start the full environment from a fresh Codespace
- [ ] `docs/local-setup.md` written
- [ ] CI workflow runs a smoke test against the running services

---

Previous: [Stage 2: Sprint 1 -- DevOps Engineer Tasks](../stage-2-sprint-1-build/devops-engineer.md) | Next: [Stage 4: Ship and Demo -- DevOps Engineer Tasks](../stage-4-deploy-demo/devops-engineer.md)
