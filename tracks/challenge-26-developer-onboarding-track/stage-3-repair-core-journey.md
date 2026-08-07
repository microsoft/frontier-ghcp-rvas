# Stage 3: Repair and Test the Core Journey

**Difficulty:** ⭐⭐⭐ | **Time:** 90-120 min

## Tasks

This is the midpoint refinement pass for your Customization Trio. Update the
repository instructions with terminology decisions that should persist. Tighten
the Technical Accuracy Reviewer agent around the discrepancies you missed in
Stage 1. Extend the Example Verification skill to capture expected output or
exit status, not just whether a command starts.

1. Rewrite `docs/getting-started.md` as a tested quickstart for a named
   audience. State prerequisites, use the supported Node.js version, provide
   the shortest path to a useful result, and show how the reader knows it
   worked.
2. Repair `docs/tutorials/first-workspace.md` as a complete task tutorial.
   Choose either the API or web profile. Explain the goal, run real commands,
   include expected observations, and keep optional branches out of the main
   path.
3. Correct `docs/reference/cli.md` against `launchpad --help`, observed exit
   behavior, and CLI tests. Keep descriptions suitable for lookup.
4. Correct `docs/reference/sdk.md` against the package exports, TypeScript
   declarations, and SDK tests. Include one minimal example that compiles and
   uses the real API.
5. Update `docs/index.md` and the glossary to match the Stage 2 decisions.
   Remove conflicting legacy names rather than explaining every historical
   variation.
6. Run every shell example you changed. Add or adjust tests only if you find a
   real software defect. The challenge is not complete if the docs merely look
   plausible.
7. Repeat the Stage 1 reader journeys without using knowledge that is absent
   from the repaired docs. Record the result in the issue inventory.

## Verification

- The quickstart gets a named reader to a useful result with tested commands
- The tutorial completes one realistic setup-planning task from start to finish
- CLI reference names, options, output, and errors match current behavior
- SDK imports, signatures, return values, and failure behavior match the code
- Navigation and terminology follow the recorded decisions
- The repeated reader journeys complete without undocumented steps

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft from verified facts and compare examples with source. You
still decide the teaching sequence, how much output to show, what belongs in a
tutorial instead of reference, and whether a new reader can recover from an
error.

---

Previous: [Stage 2: Define Audience, Structure, and Language](stage-2-define-structure.md) | Next: [Stage 4: Add Editorial Checks and Maintenance](stage-4-editorial-maintenance.md)
