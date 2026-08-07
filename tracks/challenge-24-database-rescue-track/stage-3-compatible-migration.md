# Stage 3: Design and Test the Compatible Migration

**Difficulty:** ⭐⭐⭐ | **Time:** 70-90 min

The customer email contract must move from `Email` to `EmailAddress`. Old and
new readers and writers overlap for at least 60 minutes. A rename is not a
deployment plan.

## Tasks

Run the Online Migration Rehearsal from the start. Ask the Migration Safety
Reviewer to inspect the contract and your proposed sequence before any live
execution. Keep the reviewer focused on lock duration, compatibility, and
recoverability.

1. Read `contracts/migration-contract.json` and map the four active client
   behaviors: old reader, old writer, new reader, and new writer.
2. Implement a rerunnable expand step in `sql/migrations/200_expand.sql`.
   It must preserve `Email`, introduce `EmailAddress`, and avoid a long blocking
   transaction on the populated table.
3. Implement `210_backfill.sql` as bounded, resumable batches. Record progress
   in a way that lets an operator stop and resume without guessing.
4. Decide how writes remain consistent during the compatibility window. Test
   all four client behaviors and concurrent updates. Explain where the
   consistency rule lives and how it is removed later.
5. Implement `240_reconciliation.sql` before writing the contract step. Check
   nulls, mismatches, duplicate normalized values, counts, and backfill
   completion.
6. Implement a separately deployable `220_contract.sql`. It must refuse to run
   when reconciliation fails and state any Azure SQL service-tier assumption
   behind online index or constraint work.
7. Fill in `deliverables/migration-plan.md` with deployment order, gates,
   expected lock behavior, cancellation points, and Azure SQL assumptions.
8. At the midpoint, refine the Online Migration Rehearsal and Migration Safety
   Reviewer based on the first failed compatibility or interruption test.

Do not execute the destructive removal of `Email` during this challenge. The
contract script may prepare or gate that later action, but the old column stays
available through the stated compatibility window and rollback rehearsal.

## Verification

- Expand, backfill, reconciliation, and contract are separate scripts
- Every script can be rerun or fails safely with a clear reason
- Backfill batches are bounded and resumable
- Old and new readers and writers pass compatibility tests during overlap
- Reconciliation covers nulls, mismatches, duplicates, and completion
- The contract step is blocked until reconciliation succeeds
- The old `Email` column remains available during the challenge
- Azure SQL online-operation assumptions are explicit and optional to validate

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft guards, batching loops, and comparison queries. It cannot
choose a safe batch size without observing log use, lock duration, and workload
pressure. It also cannot decide when the compatibility window is truly over.
Those are release and operations decisions backed by evidence.

---

Previous: [Stage 2: Tune with Execution Evidence](stage-2-tune-with-execution-evidence.md) | Next: [Stage 4: Package Operations and Recovery](stage-4-operations-and-recovery.md)
