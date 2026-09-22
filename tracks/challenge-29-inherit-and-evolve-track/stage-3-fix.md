# Stage 3: Fix the Cancellation Defect

**Difficulty:** ⭐⭐⭐ | **Time:** 75 min

## Tasks

### Support Ticket

> Operations: A cancelled booking sometimes still blocks equipment. The laser
> level has a cancelled reservation for October 10 to October 12, 2030, but
> another employee still cannot reserve it for that window.
> Please make cancellation release equipment when nothing else prevents the
> booking.

1. Reproduce the problem through the application's booking and cancellation
   workflow. Record the equipment, employee, exact date range, expected result,
   and actual result. Keep the data synthetic.
2. Use the discovery map to investigate. Compare a few possible causes against
   source and runtime evidence before deciding which one is responsible.
3. Use your regression-test skill to add a focused automated test that
   expresses the expected behavior. **Run it before changing production
   code and capture the failure.** A compile error or broken test setup
   does not count as reproducing the defect.
4. Make a small fix. Run the same test again and record the passing result.
   Keep enough command output or version references to show the test and
   version you ran.
5. Check nearby behavior. Active overlapping reservations must still block.
   Adjacent ranges must remain valid. Maintenance must still prevent booking.
   Check that cancelling one reservation does not remove another valid
   conflict.
6. Review the diff with Copilot. Remove unrelated refactoring and assertions
   that would pass with the original defect. Update the regression-test skill
   if it no longer connects the reported problem to the test.
7. Run the full solution tests and repeat the original browser workflow. Add
   the cause and changed source references to your working note.

## Verification

- The ticket has a repeatable scenario using fixed dates.
- The regression test fails on the inherited behavior for the expected
  reason and passes after the fix.
- The original UI scenario succeeds when no other booking or maintenance
  blocks the requested range.
- Active conflicts and maintenance remain enforced; adjacent bookings work.
- `dotnet test EquipmentBooking.sln` passes.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can suggest causes and draft a test. You decide whether the test
reproduces the user's problem and whether the patch fixes the cause. A passing
test with a weak assertion proves nothing useful.

---

Previous: [Stage 2: Discover the Application](stage-2-discovery.md) | Next: [Stage 4: Add the Waitlist](stage-4-feature.md)
