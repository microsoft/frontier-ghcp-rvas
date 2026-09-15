# Stage 2: Discover the Application

**Difficulty:** ⭐⭐⭐ | **Time:** 60 min

Build a map another developer could use to find the code behind a user action.
Keep it small enough to check.

## Tasks

1. Use your repository instructions to constrain Copilot's first code walk.
   Trace equipment availability from the browser to the stored data. Continue
   with reservation creation and cancellation, then the maintenance control.
2. Add a compact table to your working note. For each workflow, record its
   actual route or page, the source symbols that handle it, and the data it
   reads or changes. Include a relevant test reference or mark a coverage gap.
3. Find how the application selects a synthetic employee and persists data.
   Check what happens when the process restarts. Identify the existing rules
   for invalid ranges and unavailable equipment.
4. Confirm the date contract with fixed examples. October 10 to October 12,
   2030 must be adjacent to October 12 to October 14, 2030. A range sharing
   an occupied day must conflict.
5. Give the Discovery Reviewer your map. Have it challenge missing references
   and any claims inferred only from names or comments.
6. **Discovery checkpoint: before editing application code, verify every
   generated claim you will rely on.** Open each cited source location and
   reproduce the claimed behavior in the browser or a focused test. Correct
   the map and label remaining hypotheses as unverified.
7. Refine the repository instructions with confirmed conventions. If the
   reviewer invented a route or treated a guess as evidence, tighten its
   brief before using it again.

Do not spend this stage documenting every class. The map should explain where
you would investigate a booking problem and where a feature change might
affect existing behavior.

## Verification

- The map links each existing user workflow to actual source symbols.
- Storage and synthetic identity behavior have been checked at runtime.
- The date examples distinguish adjacency from overlap.
- Claims used to plan edits have source or runtime evidence; unresolved
  questions are visibly marked.
- Application code is still unchanged.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can follow references and draft a useful map quickly. You must check
that it followed the path the application actually runs. A confident summary
without evidence does not pass the discovery checkpoint.

---

Previous: [Stage 1: Establish the Baseline](stage-1-baseline.md) | Next: [Stage 3: Fix the Cancellation Defect](stage-3-fix.md)
