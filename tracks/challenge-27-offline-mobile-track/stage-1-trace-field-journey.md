# Stage 1: Trace the Field Journey

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

## Tasks

Use the full customization trio at the start. Keep your repository instructions
open while you map the code boundaries, ask the Offline Data Reviewer to
challenge the first map, and run the Offline Journey Check against the starter
before proposing a fix.

1. Run `npm run validate:fixtures`, `npm run typecheck`, and `npm test` from the
   challenge folder. Start `npm run web` if you want to inspect the UI without
   an emulator.
2. Trace job loading, inspection editing, local saving, queue creation, and
   synchronization. Record which code owns each step and where data crosses an
   interface.
3. Compare the TypeScript client with
   `src/fixtures/azure-functions-contract.json`. List the assumptions the app
   makes about versions, errors, retries, and successful receipts.
4. Walk three journeys: save with no signal, refresh after saving, and sync
   after the dispatcher changes the same job. Record every point where work can
   disappear, duplicate, or become ambiguous.
5. Define acceptance criteria for persistence, queue ordering, conflict
   handling, permission denial, degraded operation, and accessibility. Keep
   Azure deployment and emulator testing outside the required path.

Refine one part of the trio after the trace. If the review missed a data-loss
path, tighten the agent's scope. If the journey check could not reproduce a
failure consistently, add the missing fixture step to the skill.

## Verification

- Baseline fixture validation, typecheck, and tests pass
- The architecture map separates UI, state, storage, sync, device adapters, and
  the mocked Azure Functions contract
- The three required journeys have observed failure notes
- Acceptance criteria state what survives restart and how conflicts are shown
- Required work can be validated in Expo web or Node

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can trace imports and summarize state transitions. You decide which
copy of data is authoritative, how much stale work is safe to show, and what a
technician should see when the server disagrees.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Persist and Queue Work](stage-2-persist-and-queue.md)
