# Stage 3: Handle field failures

**Difficulty:** ⭐⭐⭐ | **Time:** 75-90 min

## Tasks

Bring back the Sync Incident Reviewer for the first conflict implementation and
the Mobile Accessibility Reviewer for the complete inspection journey. Run the
Permission Degraded-Mode Check before accepting either permission flow.

1. Choose and document a conflict policy for a queued action whose
   `baseVersion` no longer matches the server job. Preserve both the technician
   input and server copy until the policy has made the outcome clear.
2. Implement conflict detection and a usable resolution path. The queue must
   not loop forever or silently discard the action.
3. Replace the starter permission gateway with adapters for Expo Camera and
   Expo Location. Handle not requested, granted, denied, blocked, and
   unavailable states.
4. Add degraded modes. A technician must be able to save an inspection without
   a photo or automatic coordinates, with a clear record of what is missing.
5. Fix the starter accessibility gaps. Cover control names and roles, selected
   values, status announcements, focus order, touch target size, text scaling,
   and status cues that do not depend on color.
6. Exercise stable, offline, flaky, and conflict fixtures. Add useful retry and
   recovery feedback without turning transient failures into duplicate work.
7. Within the existing accessibility review time, use Impeccable's `critique`
   on the inspection journey in Expo web. Distinguish saved locally, awaiting
   sync, failed, and conflicted states without color. Improve one confusing
   message or recovery action while preserving technician input and the agreed
   conflict policy. Use `inspection-save` and `inspection-notes` test IDs to
   target the same controls in before-and-after evidence.

At the midpoint, refine the two reviewer agents with one miss from the first
pass. Tighten their checks around the actual failure you found rather than
adding broad mobile advice.

## Verification

- The chosen conflict policy is documented and implemented
- Conflict handling keeps technician input available until resolution
- All camera and location permission states have tested behavior
- Inspection work continues when optional permissions are unavailable
- Accessibility fixes cover both controls and changing sync status
- Every network fixture has a deterministic validation path
- One UI review improves sync or recovery feedback without changing queue behavior
- Web evidence is labeled as web evidence; outstanding native checks remain explicit

## What Copilot helps with vs. what requires your judgment

Copilot can scaffold Expo permission adapters and accessibility properties. It
cannot decide whether a dispatcher update should beat a technician's offline
inspection. Make that policy explicit, then use Copilot to find code paths that
violate it.

---

Previous: [Stage 2: Persist and Queue Work](stage-2-persist-and-queue.md) | Next: [Stage 4: Prove Release Readiness](stage-4-prove-release-readiness.md)
