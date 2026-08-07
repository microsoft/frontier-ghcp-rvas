# Phase 2: Sprint 1 -- DevOps Engineer Tasks

**Time: Full 3 hours**

Build the infrastructure that will take the application from setup to a smooth development environment inside GitHub Codespaces.

## Tasks

### Devcontainer Features

Extend the devcontainer configuration to include database tooling, linting tools, and any CLI utilities the team needs. Use devcontainer features to add PostgreSQL, Redis, or other services as needed.

### Start Script for All Services

Create a single command that brings up backend, frontend, and database together inside the Codespace. Use a process manager like `concurrently`, `overmind`, or a simple shell script with background processes. The frontend should proxy API calls to the backend.

### Expand the CI Pipeline

Update the GitHub Actions workflow:

- Run backend tests
- Run frontend build (verify it compiles)
- Run Playwright E2E tests (can fail for now if the app is not integrated yet)
- Add linting steps for both services

### Harden the Dev Environment

Now that backend and frontend are both running, make the environment reliable for the whole team:

- Add health check scripts that verify each service is up before tests run
- Configure port forwarding in the devcontainer so teammates can preview the app
- Set up a database seed script that runs automatically on Codespace creation
- Document the startup order and any dependencies between services

### Environment Configuration

Set up `.env` files for local development. Document which environment variables each service needs in `docs/env-vars.md`. Make sure `.env` is in `.gitignore` and provide a `.env.example` instead.

## Copilot Tips

```text
"Add a PostgreSQL feature to devcontainer.json and configure
port forwarding for the backend on port 3000 and frontend on port 5173."
```

```text
"Create a dev startup script using concurrently that runs
the backend and frontend with hot reload inside a Codespace."
```

## Verification

- [ ] Devcontainer includes all required runtimes and tools
- [ ] All services (backend, frontend, database) start with a single command
- [ ] Health checks and startup logic in place for dev processes
- [ ] CI pipeline expanded with test and build steps
- [ ] `.env.example` committed and `docs/env-vars.md` written

---

Previous: [Phase 1: Technical Planning -- DevOps Engineer Tasks](../phase-1-technical-planning/devops-engineer.md) | Next: [Phase 3: Sprint 2 -- DevOps Engineer Tasks](../phase-3-sprint-2-integration/devops-engineer.md)
