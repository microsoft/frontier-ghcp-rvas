# Stage 5: Hand Over the Change

**Difficulty:** ⭐⭐ | **Time:** 30 min

Give the next developer enough evidence to review your change and run it.
Extend your existing working note rather than writing a new report.

## Tasks

1. Run the full checks from the challenge folder:

   ```bash
   dotnet test EquipmentBooking.sln
   bash scripts/validate-starter.sh
   ```

2. Review the final diff with your custom reviewer. Look for changes outside
   the ticket and feature scope, then check the review claims yourself.
3. Update the workflow-to-code map where the waitlist changed it. Add a brief
   change summary with the cancellation regression evidence and the waitlist
   test references. Record known limitations without presenting unfinished
   behavior as complete.
4. Note any storage changes and explain how another developer can run your
   version with an existing lab database. Verify that instruction rather
   than assuming a fresh database is the only case that matters.
5. Demo the original cancellation scenario, then join a waitlist and confirm
   an eligible request. Include one refused confirmation and show that its
   request remains pending. Restart to demonstrate persistence.
6. Check that repository instructions still describe the actual application.
   Remove temporary guesses from the discovery work.

## Verification

- Both commands pass, and the waitlist has its own acceptance evidence.
  The starter script alone does not prove feature completion.
- The working note contains a usable code map, before-and-after regression
  evidence, and a brief summary of what changed.
- The demo shows preserved booking behavior and a working waitlist, including
  refusal when confirmation is no longer safe.
- A restart preserves reservations and waitlist state.
- Launch and storage guidance match the version being handed over.
- Remaining limitations are explicit. No real credentials or external
  services were introduced.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can summarize the diff and find missing evidence references. You
decide whether the result meets the acceptance criteria. Keep the handover
honest about anything that remains incomplete.

---

Previous: [Stage 4: Add the Waitlist](stage-4-feature.md)
