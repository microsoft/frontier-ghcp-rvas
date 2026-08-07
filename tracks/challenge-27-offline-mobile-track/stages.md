# Offline Field Service App: Stages

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|-----------------|
| 1 | [Trace the Field Journey](stage-1-trace-field-journey.md) | ⭐⭐ | 45-60 min | Architecture map, API assumptions, and failure-focused journey notes |
| 2 | [Persist and Queue Work](stage-2-persist-and-queue.md) | ⭐⭐⭐ | 75-90 min | Durable jobs, drafts, queued actions, and restart-safe behavior |
| 3 | [Handle Field Failures](stage-3-handle-field-failures.md) | ⭐⭐⭐ | 75-90 min | Conflict policy, permission degraded modes, accessibility fixes, and failure handling |
| 4 | [Prove Release Readiness](stage-4-prove-release-readiness.md) | ⭐⭐⭐ | 60-75 min | State and integration tests plus a completed release-readiness checklist |

The stages follow the work rather than the screens. First trace where a field
action can fail. Then make local data durable, decide what synchronization
means, and finish with evidence that runs without an emulator.

> **Short on time?** Complete Stages 1, 2, and the queue and conflict tests from
> Stage 4. Do not skip durable local storage.

---

Previous: [Track Overview](../challenge-27-offline-mobile-track.md) | Next: [Stage 1: Trace the Field Journey](stage-1-trace-field-journey.md)
