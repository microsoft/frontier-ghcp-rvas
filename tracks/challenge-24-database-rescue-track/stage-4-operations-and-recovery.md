# Stage 4: Package Operations and Recovery

**Difficulty:** ⭐⭐⭐ | **Time:** 55-70 min

Finish the rescue as if another DBA will deploy it during a busy week. They
need clear stop conditions, safe rollback, reconciliation they can trust, and
monitoring that does not become the next performance problem.

## Tasks

Use the Peak-Load Triage Capture to shape the monitoring order. Give the
Database Incident Reviewer the runbook and only the evidence an on-call DBA
would have. If it asks the author what a step means, the runbook is not done.

1. Implement `sql/migrations/230_rollback.sql`. Cover failures during expand,
   partial backfill, dual-write overlap, and the gated contract phase. Preserve
   writes accepted through either supported column.
2. Finish `240_reconciliation.sql` so it can run before deployment, after each
   backfill batch, before contract, and after rollback.
3. Implement `sql/monitoring/300_health_checks.sql` for blocking, expensive
   queries, query regression, index usage, and migration progress. Keep the
   queries scoped and explain required permissions.
4. Complete `deliverables/operations-runbook.md`. Include prerequisites,
   ordered commands, expected signals, thresholds, stop conditions, rollback
   triggers, reconciliation ownership, and escalation.
5. Rehearse one failed backfill and one performance regression. Follow the
   runbook rather than improvising. Record any step that was ambiguous.
6. Refine the Peak-Load Triage Capture and Database Incident Reviewer after the
   rehearsal. Remove checks that are too expensive or vague under load.
7. Run the full submission verifier:

   ```bash
   python tools/verify_artifacts.py --mode submission
   ```

8. Optionally run the scripts against Azure SQL. Record the compatibility
   level, service tier, permissions, and any difference from local SQL Server.
   Do not treat this optional check as permission to add Azure-only behavior to
   the authoritative starter scripts.

## Verification

- Submission verification passes
- Rollback covers each migration phase and preserves accepted writes
- Reconciliation can be used before, during, and after the migration
- Monitoring covers blocking, expensive queries, index usage, and progress
- Monitoring queries state permissions and avoid unbounded result sets
- The runbook includes thresholds, stop conditions, owners, and escalation
- A failed backfill and a query regression are rehearsed from the runbook
- Optional Azure SQL results include exact compatibility and service-tier
  assumptions

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can turn your scripts into a checklist and point out missing branches.
It cannot set an acceptable blocking duration, decide how much mismatch is
tolerable, or name the person who can approve the contract step. Put those
decisions in the runbook so they are settled before peak load returns.

---

Previous: [Stage 3: Design and Test the Compatible Migration](stage-3-compatible-migration.md)
