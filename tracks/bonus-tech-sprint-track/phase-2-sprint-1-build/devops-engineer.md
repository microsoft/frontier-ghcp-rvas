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

### Harden the Compose Setup

Now that backend and frontend are both running, make the compose file reliable for the whole team:

- Add `healthcheck` blocks to the backend and database services so compose knows when they are ready
- Add `restart: unless-stopped` to services that should recover from crashes
- Use named volumes for the database so data survives a `docker compose down`
- Add `depends_on` with `condition: service_healthy` so the backend waits for the database

### Environment Configuration

Set up `.env` files for local development. Document which environment variables each service needs in `docs/env-vars.md`. Make sure `.env` is in `.gitignore` and provide a `.env.example` instead.

## Copilot Tips

```text
"Add a healthcheck to a PostgreSQL service in docker-compose.yml
that uses pg_isready and marks the service healthy after 3 successes."
```

```text
"Create a multi-stage Dockerfile for a React app built with Vite.
Build stage uses Node 20, production stage uses nginx:alpine."
```

## Verification

- [ ] Frontend Dockerfile building successfully
- [ ] docker-compose running backend, frontend, and database together
- [ ] Health checks and restart policies in place
- [ ] CI pipeline expanded with test and build steps
- [ ] `.env.example` committed and `docs/env-vars.md` written

---

Previous: [Phase 1 -- DevOps Engineer Tasks](../phase-1-technical-planning/devops-engineer.md) | Next: [Phase 3 -- DevOps Engineer Tasks](../phase-3-sprint-2-integration/devops-engineer.md)
