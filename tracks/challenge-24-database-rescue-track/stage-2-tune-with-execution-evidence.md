# Stage 2: Tune with Execution Evidence

**Difficulty:** ⭐⭐⭐ | **Time:** 70-90 min

Now reduce the measured cost of Q1 through Q4 without changing what callers
receive. Every retained change needs before/after evidence and an operational
cost.

## Tasks

Use the Query Evidence Loop for each query. Bring in the Query Plan Reviewer
after you have a candidate change and a fresh plan, not before. The agent's job
is to challenge your explanation.

1. Add tuned statements to `sql/solution/100_tuned_queries.sql`. Label Q1
   through Q4 and preserve columns, row meaning, ordering, and parameter
   behavior.
2. Add only evidence-backed indexes to `sql/solution/110_indexes.sql`. For each
   index, comment on the query it supports, expected access path, key order,
   included columns, and insert or storage cost.
3. Change one variable per pass. Compare query rewrite alone, index alone, and
   the combination when both are plausible.
4. Capture actual plans and the same measurements used in Stage 1. Watch for
   estimate errors, residual predicates, lookups, spills, excessive grants,
   scans, and regressions on the skewed high-volume customers or products.
5. Test at least one selective and one skewed parameter set for parameterized
   queries. If you choose recompilation, dynamic SQL, or a hint, document why a
   stable query and index shape was not enough.
6. Update the diagnosis with before/after values and rejected alternatives.
   Midway through, tighten the Query Plan Reviewer brief if it offers generic
   advice without naming the operator or evidence its advice addresses.
7. Run submission verification. It should still fail on the unfinished
   migration and operations artifacts, but it must accept the completed tuning
   files:

   ```bash
   python tools/verify_artifacts.py --mode submission
   ```

## Verification

- Tuned SQL labels and implements Q1 through Q4
- Every query preserves its Stage 1 result contract
- Before/after evidence uses comparable conditions and at least three samples
- Each retained index names its read benefit and write or storage cost
- Selective and skewed parameter cases are tested where they matter
- The diagnosis explains plan changes rather than reporting timing alone
- No table, constraint, or compatibility column is removed for performance

## What Copilot Helps With vs. What Requires Your Judgment

Copilot is good at spotting non-SARGable predicates and drafting candidate
indexes. It tends to over-index when it sees queries one at a time. You decide
whether the combined index set is acceptable for a transactional workload and
whether a faster plan remains stable for the skew in this fixture.

---

Previous: [Stage 1: Reproduce and Baseline](stage-1-reproduce-and-baseline.md) | Next: [Stage 3: Design and Test the Compatible Migration](stage-3-compatible-migration.md)
