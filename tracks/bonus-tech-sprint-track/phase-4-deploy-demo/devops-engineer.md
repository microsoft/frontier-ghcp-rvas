# Phase 4: Ship and Demo -- DevOps Engineer Tasks

[Back to Phase 4 Overview](../phase-4-deploy-demo.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: ~1 hour tasks + demo/retro**

## Tasks

1. **Verify the full stack** -- Run `docker compose up` from a clean state and confirm all services come up healthy. Check `docker compose ps` shows no containers restarting or exiting.

2. **Document the stack** -- Write or finalize `docs/local-setup.md`: how to start the application, required `.env` values, how to reset the database, and how to stop everything cleanly.

3. **Verify logs and health checks** -- Confirm that `docker compose logs` surfaces useful output for each service. Confirm the CI smoke test is passing in GitHub Actions.

4. **Demo contribution** -- Walk through the infrastructure: the compose file architecture, the reverse proxy routing, the CI pipeline, and a live `docker compose up` showing the full stack starting cleanly.

## Verification

- [ ] All services healthy on `docker compose ps`
- [ ] `docs/local-setup.md` complete
- [ ] CI smoke test passing
- [ ] Demo contribution prepared

---

Previous: [Phase 3 -- DevOps Engineer Tasks](../phase-3-sprint-2-integration/devops-engineer.md)
