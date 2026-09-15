# Stage 4: Add the Waitlist

**Difficulty:** ⭐⭐⭐ | **Time:** 105 min

Operations wants employees to join a waitlist when their equipment is already
booked. An administrator will decide when to confirm an eligible request.
Keep the current Razor UI and SQLite storage.

## Tasks

1. Read the acceptance criteria below and identify the source areas affected.
   Agree on visible pending and confirmed states before editing. Keep the UI
   plain enough to finish within this stage.
2. Use the existing project conventions to add a persisted waitlist and the
   employee-facing workflow. Preserve the booking and cancellation behavior
   you have already checked.
3. Add a demo admin view that exposes the earliest eligible request for each
   equipment item and supports manual confirmation. Make refusal to confirm
   understandable to the person using it.
4. Reuse your regression-test skill for ordering and availability cases.
   Include a request that becomes unavailable after the administrator views
   it, and repeated or competing confirmation attempts.
5. At the midpoint, review one end-to-end path with your discovery or change
   reviewer. Check its claims in code and runtime again. Refine the reviewer
   if it focuses on formatting while missing a booking conflict.
6. Restart the application and check persisted requests. Run the solution
   tests, then walk through the employee and admin UI.

### Acceptance Criteria

- An employee can join the waitlist for a specific equipment item and valid
  whole-day range that is occupied by a reservation. Invalid ranges receive
  a clear validation message.
- An employee cannot create duplicate active (pending) requests for the same
  equipment and exact range.
- Requests persist in SQLite. First-in, first-out order survives a restart
  and has a deterministic tie break when requests share the same ordering
  timestamp.
- A cancellation makes the earliest **currently eligible** pending request
  visible for manual admin confirmation. Eligibility requires the request's
  entire date range to be available.
- An older request whose range is still unavailable does not block a later
  eligible request. Selection compares only eligible pending requests for the
  same equipment, even when their requested ranges differ.
- Maintenance prevents eligibility. Releasing maintenance uses the same
  availability rule and exposes an eligible request when no booking blocks it.
- Confirmation rechecks availability. If another booking or maintenance now
  prevents it, the request stays pending and no reservation is created.
- A successful confirmation creates a reservation for the requesting employee
  and exact requested range. The request is marked confirmed only when that
  reservation succeeds. Failed or repeated confirmation cannot leave a false
  confirmed state or double-book equipment.
- The employee and administrator can distinguish pending from confirmed
  requests. Existing reservations still use start-inclusive, end-exclusive
  ranges; the waitlist uses the same overlap rule.

**Keep the feature bounded.** Do not add email, background promotion, automatic
booking, real authentication, or a new application architecture.

## Verification

- A browser demo covers joining an occupied range through successful manual
  confirmation after cancellation.
- Tests cover duplicate requests, FIFO ordering with a tie, and an older
  unavailable request followed by a later eligible one.
- Maintenance blocks eligibility, and releasing it exposes eligible work.
- A conflict introduced before confirmation leaves the request pending.
- Repeated or competing confirmation attempts cannot create overlapping
  reservations or a confirmed request without its successful reservation.
- Adjacent date ranges remain valid, while overlapping occupied days conflict.
- Pending and confirmed requests retain their state after an application
  restart.
- Existing browse, reserve, list, and cancel workflows still work.
  `dotnet test EquipmentBooking.sln` passes.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft persistence changes and suggest edge-case tests. You own the
meaning of eligibility and the evidence that confirmation cannot double-book
equipment. Check both the stored result and what the UI tells the user.

---

Previous: [Stage 3: Fix the Cancellation Defect](stage-3-fix.md) | Next: [Stage 5: Hand Over the Change](stage-5-handover.md)
