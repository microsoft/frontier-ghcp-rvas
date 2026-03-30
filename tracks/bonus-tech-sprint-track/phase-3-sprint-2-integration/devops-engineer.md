# Phase 3: Sprint 2 -- DevOps Engineer Tasks

[Back to Phase 3 Overview](../phase-3-sprint-2-integration.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: Full 2 hours**

## Tasks

1. **Add a reverse proxy** -- Add an nginx (or Traefik) service to `docker-compose.yml` that routes `/api/` to the backend and `/` to the frontend. This gives the whole stack a single entry point on one port and eliminates browser CORS issues.

2. **Make the stack shareable** -- Verify that anyone on the team can start the full application from a fresh clone with a single command:
   - `docker compose up` should bring up backend, frontend, database, and reverse proxy
   - All required environment variables should have defaults in `.env.example`
   - Write or update `docs/local-setup.md` with the full startup sequence

3. **Add a CI smoke test** -- Update the GitHub Actions workflow to spin up the compose stack, wait for the health check to pass, and run basic requests against the API:
   - `GET /health` responds 200
   - `GET /api/trails` returns a JSON array (even if empty)
   - Tear down the stack cleanly after the test

4. **Review container logs** -- Confirm that `docker compose logs <service>` surfaces useful output for each service. Each service should log at an appropriate level (info for requests, error for failures). Fix anything that logs nothing or is too noisy.

## Stretch: Deploy to Azure

If the team completes the Docker Compose work with time to spare, attempt an Azure deployment:

- Apply Terraform or Bicep to provision resources (resource group, Container Apps or App Service)
- Build and push Docker images to Azure Container Registry or GitHub Container Registry
- Set environment variables in Azure, enable HTTPS, configure CORS
- Add a deployment step to the CI pipeline on merge to main

This is optional. A working, demoed compose stack is a complete deliverable.

## Verification

- [ ] Reverse proxy routing `/api/` to backend and `/` to frontend
- [ ] Another team member can start the full stack from scratch with `docker compose up`
- [ ] `docs/local-setup.md` written
- [ ] CI workflow runs a smoke test against the compose stack

---

Previous: [Phase 2 -- DevOps Engineer Tasks](../phase-2-sprint-1-build/devops-engineer.md) | Next: [Phase 4 -- DevOps Engineer Tasks](../phase-4-deploy-demo/devops-engineer.md)
