# Stage 1: Reproduce and Baseline

**Difficulty:** ⭐⭐⭐ | **Time:** 55-70 min

The peak-load report says the database is slow, blocked, and heavy on I/O.
Those are observations, not a diagnosis. Build a repeatable baseline before
changing any SQL.

## Tasks

Start with your repository instructions in scope. Use the Query Plan Reviewer
only after you have collected your own first pass. Run the Query Evidence Loop
for one query early so you can correct the workflow before repeating it four
times.

1. Run `scripts/validate.sh`. If your host can run the SQL Server 2022 image,
   run `scripts/run-local-sqlserver.sh` and record the image, architecture,
   allocated CPU and memory, database compatibility level, and run timestamp.
2. Inspect the schema, deterministic skew rules, and Q1 through Q4. Write down
   each query's result contract before considering a rewrite.
3. Execute at least three baseline passes under the same conditions. Capture
   logical reads, CPU, elapsed time, returned row count, and actual plan for
   each query. If local SQL Server is unavailable, use the supplied evidence
   fixtures and state that the measurements are fixture-based.
4. Compare `baseline-query-stats.csv`, the plan fixtures, the wait sample, and
   the blocking snapshot. Separate primary evidence from symptoms that may be
   caused by the same scan or long transaction.
5. Complete `deliverables/baseline.md` and `deliverables/diagnosis.md`. Cover
   Q1 through Q4, rank the likely bottlenecks, and record one change you will
   not make because the evidence does not support it.
6. At the midpoint, refine the Query Evidence Loop if it failed to preserve
   run conditions, result counts, or plan identity. Keep those fields mandatory
   for the next stage.

Do not clear a shared plan cache or wait statistics to make the numbers cleaner.
If you use an isolated local container and reset state, record that action.

## Verification

- `bash scripts/validate.sh` passes
- The baseline states whether it came from live local execution or fixtures
- Q1 through Q4 have run conditions, at least three samples, logical reads,
  CPU, elapsed time, row counts, and plan references
- The diagnosis ties each claim to a predicate, operator, estimate, wait, or
  blocking observation
- Query result contracts are written down before tuning
- At least one unsupported or overly risky tuning idea is explicitly rejected

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can explain plan operators and organize measurements. It cannot tell
whether two runs were comparable unless you provide the conditions. You own
the distinction between correlation and cause, especially when scan pressure,
parallelism, and blocking appear in the same five-minute window.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Tune with Execution Evidence](stage-2-tune-with-execution-evidence.md)
