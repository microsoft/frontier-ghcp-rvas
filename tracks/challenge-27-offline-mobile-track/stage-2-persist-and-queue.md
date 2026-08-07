# Stage 2: Persist and Queue Work

**Difficulty:** ⭐⭐⭐ | **Time:** 75-90 min

## Tasks

1. Replace the session-only store with durable local persistence. Jobs,
   inspection drafts, queue entries, and the minimum sync metadata must survive
   an app reload or restart.
2. Define a versioned local schema. Handle empty, old, and malformed data
   without trapping the app on startup.
3. Make inspection saving local-first. The UI should confirm a local save
   without waiting for the mocked Azure Functions client.
4. Build a durable action queue with explicit ordering and unique action IDs.
   Decide whether repeated edits collapse into one action or remain separate.
5. Add an idempotency rule so retrying an action cannot apply it twice. Keep
   failed actions with enough context to retry or diagnose.
6. Test reload behavior, multiple queued edits, partial flush, and a network
   failure in the middle of a queue.

Run the Offline Journey Check again after the first durable implementation.
Update it if it only proves that data exists, but not that the latest draft and
queue order are correct.

## Verification

- Jobs, drafts, queue entries, and sync metadata survive restart
- Saving an inspection succeeds while the offline fixture is active
- Queue order and idempotency behavior are explicit and tested
- A partial sync does not drop unsent actions
- Malformed local data follows a documented recovery path
- Core persistence and queue tests run in Node

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can implement storage adapters and serialization tests quickly. You
must choose compaction, ordering, migration, and recovery rules. Those rules
determine whether a technician's last hour of work is safe.

---

Previous: [Stage 1: Trace the Field Journey](stage-1-trace-field-journey.md) | Next: [Stage 3: Handle Field Failures](stage-3-handle-field-failures.md)
