# Phase 1: Technical Planning -- DevOps Engineer Tasks

[Back to Phase 1 Overview](../phase-1-technical-planning.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: ~1 hour setup + 30 min planning**

## Tasks

1. **Set up the repository structure** -- Define branching strategy (trunk-based or feature branches). Write a short doc in `docs/branching-strategy.md` with the team's agreement on PR conventions.

2. **Create the backend Dockerfile** -- Write a multi-stage Dockerfile for the backend. Include a dev stage with hot reload and a production stage.

3. **Create docker-compose.yml** -- Set up local development with docker-compose that runs the backend (and later the frontend and database).

4. **Set up GitHub Actions** -- Create a CI workflow (`.github/workflows/ci.yml`) that runs on PRs. Start with a lint step and a placeholder test step.

5. **Write custom instructions** -- Add DevOps context to `.github/copilot-instructions.md`: Docker conventions, CI/CD approach, Azure deployment target.

6. **Create an infra agent** -- Create `.github/agents/infra-engineer.agent.md` with Docker, GitHub Actions, and Azure deployment context.

7. **Write user stories** -- Create 2-3 GitHub Issues for infrastructure work (Docker setup, CI pipeline, Azure deployment). Use the template in `challenges/bonus-4-tech-sprint/templates/user-story-issue.md`.

8. **Sprint planning** -- Join the planning session. Confirm infrastructure timeline.

## Verification

- [ ] Backend Dockerfile working
- [ ] docker-compose running the backend locally
- [ ] GitHub Actions CI workflow runs on PRs

---

Next: [Phase 2 -- DevOps Engineer Tasks](../phase-2-sprint-1-build/devops-engineer.md)
