# Phase 2: Sprint 1 -- DevOps Engineer Tasks

[Back to Phase 2 Overview](../phase-2-sprint-1-build.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: Full 3 hours**

Build the infrastructure that will take the application from local development to production.

## Tasks

### Frontend Dockerfile

Write a multi-stage Dockerfile for the frontend (build with Node, serve with nginx or similar).

### Full docker-compose

Update `docker-compose.yml` to run backend, frontend, and a database together. The frontend should proxy API calls to the backend.

### Expand the CI Pipeline

Update the GitHub Actions workflow:

- Run backend tests
- Run frontend build (verify it compiles)
- Run Playwright E2E tests (can fail for now if the app is not integrated yet)
- Add linting steps for both services

### Start Infrastructure as Code

Begin writing Terraform or Bicep for the Azure deployment:

- Resource group
- Azure App Service or Container Apps for backend and frontend
- Optionally: Azure Database for PostgreSQL (or keep SQLite for simplicity)

### Environment Configuration

Set up `.env` files for local and production. Document which environment variables each service needs in `docs/env-vars.md`.

## Copilot Tip

```text
"Create a multi-stage Dockerfile for a React app built with Vite.
Build stage uses Node 20, production stage uses nginx:alpine."
```

## Verification

- [ ] Frontend Dockerfile building successfully
- [ ] docker-compose running backend and frontend together
- [ ] CI pipeline expanded with test and build steps
- [ ] Infrastructure as Code started (Terraform or Bicep)
- [ ] Environment variables documented

---

Previous: [Phase 1 -- DevOps Engineer Tasks](../phase-1-technical-planning/devops-engineer.md) | Next: [Phase 3 -- DevOps Engineer Tasks](../phase-3-sprint-2-integration/devops-engineer.md)
