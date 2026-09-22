# Stage 5: Hand Over the Change

**Difficulty:** ⭐⭐ | **Time:** 30 min

Give the next developer enough evidence to review and run your change. Extend
your existing working note instead of writing a new report.

## Tasks

1. Run the full checks from the challenge folder:

   ```bash
   dotnet test EquipmentBooking.sln
   bash scripts/validate-starter.sh
   ```

2. Review the final diff with your custom reviewer. Look for changes outside
   the ticket and feature scope, then check its claims yourself.
3. Update the workflow-to-code map for the waitlist. Add a short change
   summary, cancellation regression evidence, and waitlist test references.
   Record known limitations. Do not present unfinished behavior as complete.
4. Record storage changes and explain how another developer runs your version
   with an existing lab database. Test those instructions. Do not assume a
   fresh database is the only case that matters.
5. Demo the original cancellation scenario. Then join a waitlist and confirm
   an eligible request. Show one refused confirmation and that the request
   remains pending. Restart to show persistence.
6. Check that repository instructions still match the application. Remove
   temporary guesses from the discovery work.

## Verification

- Both commands pass, and the waitlist has separate acceptance evidence. The
  starter script alone does not prove the feature is complete.
- The working note contains a usable code map, before-and-after regression
  evidence, and a brief summary of what changed.
- The demo shows unchanged booking behavior and a working waitlist, including
  a refusal when confirmation is no longer safe.
- A restart preserves reservations and waitlist state.
- Launch and storage guidance match the version being handed over.
- Remaining limitations are explicit. No real credentials or external
  services were introduced.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can summarize the diff and find missing evidence references. You
decide whether the result meets the acceptance criteria. Be clear about any
unfinished work.

---

Previous: [Stage 4: Add the Waitlist](stage-4-feature.md)
