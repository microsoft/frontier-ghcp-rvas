# Peak-Load Database Rescue: Stages

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Reproduce and Baseline](stage-1-reproduce-and-baseline.md) | ⭐⭐⭐ | 55-70 min | Repeatable baseline and evidence-backed incident diagnosis |
| 2 | [Tune with Execution Evidence](stage-2-tune-with-execution-evidence.md) | ⭐⭐⭐ | 70-90 min | Tuned Q1-Q4 scripts, targeted indexes, and before/after proof |
| 3 | [Design and Test the Compatible Migration](stage-3-compatible-migration.md) | ⭐⭐⭐ | 70-90 min | Expand, bounded backfill, compatibility tests, reconciliation, and gated contract plan |
| 4 | [Package Operations and Recovery](stage-4-operations-and-recovery.md) | ⭐⭐⭐ | 55-70 min | Rollback, monitoring queries, final reconciliation, and an operations runbook |

The sequence is deliberate. First make the failure repeatable. Then tune what
the evidence supports. Only after the workload is stable should you rehearse
the schema change and package it for another DBA to operate.

> **Short on time?** Complete Q1 and Q2 in Stage 2, but do not skip any migration
> gate in Stages 3 and 4. A partial tuning sample still teaches the evidence
> loop. A partial compatibility test gives false confidence.

---

Previous: [Track Overview](../challenge-24-database-rescue-track.md) | Next: [Stage 1: Reproduce and Baseline](stage-1-reproduce-and-baseline.md)
