# Stage 3: Fix the Cancellation Defect

**Difficulty:** ⭐⭐⭐ | **Time:** 75 min

## Tasks

### Support Ticket

> Operations: A cancelled booking sometimes still blocks equipment. The laser
> level has a cancelled reservation for October 10 to October 12, 2030, but
> another employee still cannot reserve it for that window.
> Please make cancellation release equipment when nothing else prevents the
> booking.

1. Reproduce the symptom with the application's booking and cancellation
   workflow. Record the equipment, employee, and exact date window, plus the
   expected result and what happened. Keep the data synthetic.
2. Use the discovery map to investigate. Compare a small set of hypotheses
   against source and runtime evidence before choosing a cause.
3. Use your regression-test skill to add a focused automated test that
   expresses the expected behavior. **Run it before changing production
   code and capture the failure.** A compile error or broken test setup
   does not count as reproducing the defect.
4. Make a narrow fix. Run the same test again and capture its passing result.
   Keep enough command output or version references to show which test ran
   against which version.
5. Check nearby behavior: active overlapping reservations still block;
   adjacent ranges remain valid; maintenance still prevents booking. Confirm
   that cancelling one reservation does not remove another valid conflict.
6. Review the diff with Copilot. Reject unrelated refactoring and assertions
   that would pass with the original defect. Refine the regression-test skill
   if it lost the link between the reported symptom and the test.
7. Run the full solution tests and repeat the original browser workflow.
   Add the cause and changed source references to your working note.

## Verification

- The ticket has a repeatable scenario using fixed dates.
- The regression test fails on the inherited behavior for the expected
  reason and passes after the fix.
- The original UI scenario succeeds when no other booking or maintenance
  blocks the requested range.
- Active conflicts and maintenance remain enforced; adjacent bookings work.
- `dotnet test EquipmentBooking.sln` passes.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can propose hypotheses and draft a test. You decide whether the test
reproduces the user's problem and whether the patch fixes its cause. A green
test with a weakened assertion proves nothing useful.

---

Previous: [Stage 2: Discover the Application](stage-2-discovery.md) | Next: [Stage 4: Add the Waitlist](stage-4-feature.md)
