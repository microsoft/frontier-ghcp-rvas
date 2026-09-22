# Stage 2: Discover the Application

**Difficulty:** ⭐⭐⭐ | **Time:** 60 min

Build a small map that helps another developer find the code behind a user
action.

## Tasks

1. Use your repository instructions for Copilot's first code walk. Trace
   equipment availability from the browser to stored data. Then trace
   reservation creation, cancellation, and the maintenance control.
2. Add a short table to your working note. For each workflow, record the page
   or route, source symbols that handle it, and data it reads or changes. Link
   a relevant test, or mark the missing coverage.
3. Find how the application chooses a synthetic employee and saves data. Check
   what survives a restart. Identify the current rules for invalid ranges and
   unavailable equipment.
4. Check the date contract with fixed examples. October 10 through October 12,
   2030 is adjacent to October 12 through October 14, 2030. A range that
   shares an occupied day conflicts.
5. Give the Discovery Reviewer your map. Ask it to challenge missing
   references and claims based only on names or comments.
6. **Discovery checkpoint: before editing application code, verify every
   generated claim you will rely on.** Open each cited source location and
   reproduce the claimed behavior in the browser or a focused test. Correct
   the map and label remaining hypotheses as unverified.
7. Update the repository instructions with confirmed conventions. If the
   reviewer invented a route or treated a guess as evidence, make its brief
   more specific before you use it again.

Do not document every class. The map should show where you would investigate a
booking problem and where a feature could change existing behavior.

## Verification

- The map links each existing user workflow to actual source symbols.
- Storage and synthetic identity behavior have been checked at runtime.
- The date examples distinguish adjacency from overlap.
- Claims used to plan edits have source or runtime evidence; unresolved
  questions are visibly marked.
- Application code is still unchanged.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can follow references and draft a map. You must check that it traced
the path the application actually runs. A confident summary without evidence
does not pass the discovery checkpoint.

---

Previous: [Stage 1: Establish the Baseline](stage-1-baseline.md) | Next: [Stage 3: Fix the Cancellation Defect](stage-3-fix.md)
