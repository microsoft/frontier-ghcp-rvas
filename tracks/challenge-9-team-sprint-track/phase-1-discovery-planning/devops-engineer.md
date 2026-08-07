# Phase 1: Discovery and Planning -- DevOps Engineer Tasks

**Time: ~1 hour setup + 30 min planning**

## Tasks

1. **Set up the repository structure** -- Define branching strategy (trunk-based or feature branches). Write a short doc in `docs/branching-strategy.md` with the team's agreement on PR conventions.

2. **Configure the devcontainer** -- Set up `.devcontainer/devcontainer.json` so the Codespace includes all runtimes the team needs (Node.js, Python, PostgreSQL). Add VS Code extensions, port forwarding rules, and any post-create scripts.

3. **Create a start script** -- Write a script (e.g., `scripts/dev.sh`) that starts all services (backend, frontend, database) inside the Codespace. Consider using a process manager like `concurrently` or `overmind` to run everything in one terminal.

4. **Set up GitHub Actions** -- Create a CI workflow (`.github/workflows/ci.yml`) that runs on PRs. Start with a lint step and a placeholder test step.

5. **Write custom instructions** -- Add DevOps context to `.github/copilot-instructions.md`: Codespace conventions, service ports, CI/CD approach, and how the local stack is structured.

6. **Create an infra agent** -- Create `.github/agents/infra-engineer.agent.md` with devcontainer, GitHub Actions, and environment context. Include the ports each service uses and how to start the stack.

7. **Sprint planning** -- Join the PO's planning session. Confirm infrastructure timeline.

## Verification

- [ ] Codespace starts with all required runtimes and tools
- [ ] Backend runs inside the Codespace
- [ ] GitHub Actions CI workflow runs on PRs

---

Previous: [Phases](../phases.md) | Next: [Phase 2: Sprint 1 -- DevOps Engineer Tasks](../phase-2-sprint-1-build/devops-engineer.md)
