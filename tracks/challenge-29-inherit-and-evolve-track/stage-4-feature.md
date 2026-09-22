# Stage 4: Add the Waitlist

**Difficulty:** ⭐⭐⭐ | **Time:** 105 min

Employees need a waitlist when equipment is already booked. An administrator
decides when to confirm an eligible request. Keep the current Razor UI and
SQLite storage.

## Tasks

1. Read the acceptance criteria and identify the source areas that will change.
   Decide how pending and confirmed states appear before editing. Keep the UI
   plain enough to finish in this stage.
2. Follow existing project conventions to add a persistent waitlist and the
   employee workflow. Keep the booking and cancellation behavior you already
   checked.
3. Add a demo admin view that shows the earliest eligible request for each
   equipment item and supports manual confirmation. Clearly explain why a
   confirmation cannot proceed.
4. Reuse your regression-test skill for ordering and availability. Include a
   request that becomes unavailable after an administrator views it, plus
   repeated or competing confirmation attempts.
5. At the midpoint, review one end-to-end path with your discovery or change
   reviewer. Check its claims against code and runtime behavior. Update the
   reviewer if it focuses on formatting and misses a booking conflict.
6. Restart the application and check saved requests. Run the solution tests,
   then walk through the employee and admin UI.

### Acceptance Criteria

- An employee can join the waitlist for a specific equipment item and a valid
  whole-day range already occupied by a reservation. Invalid ranges show a
  clear validation message.
- An employee cannot create duplicate active (pending) requests for the same
  equipment and exact range.
- Requests persist in SQLite. First-in, first-out order survives a restart.
  Requests with the same ordering timestamp use a deterministic tie break.
- When a cancellation frees equipment, show the earliest **currently eligible**
  pending request for manual admin confirmation. An eligible request has its
  whole date range available.
- An older request with an unavailable range does not block a later eligible
  request. Select only eligible pending requests for the same equipment, even
  when their requested ranges differ.
- Maintenance prevents eligibility. Releasing maintenance uses the same
  availability rule and exposes an eligible request when no booking blocks it.
- Confirmation checks availability again. If another booking or maintenance
  blocks it, leave the request pending and do not create a reservation.
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

Copilot can draft persistence changes and suggest edge-case tests. You decide
what eligibility means and must prove confirmation cannot double-book
equipment. Check the saved result and the message shown in the UI.

---

Previous: [Stage 3: Fix the Cancellation Defect](stage-3-fix.md) | Next: [Stage 5: Hand Over the Change](stage-5-handover.md)
