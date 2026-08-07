# Stage 4: Add Editorial Checks and Maintenance

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

## Tasks

1. Review `scripts/check-links.mjs`. Extend it where the repaired navigation
   needs stronger coverage, such as same-page anchors or links outside
   `docs/`, without adding a large documentation toolchain.
2. Review `scripts/check-examples.mjs`. Tag every shell example that is safe to
   run locally, then make the checker verify those commands. Add a focused
   TypeScript example check for the SDK sample.
3. Add a single `docs:check` command that runs all documentation validation.
   Keep failures readable enough that an editor can find the page and example.
4. Create `docs/editorial-workflow.md`. Define who reviews onboarding changes,
   which code changes trigger documentation review, the commands required
   before merge, how terminology decisions change, and when reader testing is
   repeated.
5. Add a lightweight pull request checklist to the workflow. Include audience,
   task success, factual evidence, links, examples, terminology, and ownership.
6. Run the code and documentation checks from a clean install. Update the issue
   inventory with any deferred work and an owner rather than silently dropping
   lower-priority findings.

The checks should protect reader tasks, not reward a high count of generated
reference pages. Keep them local, quick, and understandable.

## Verification

- `npm test` passes
- `npm run docs:check` validates all local links and safe shell examples
- The SDK example is checked against the current package exports
- Failures identify the affected document and example
- The editorial workflow names owners, triggers, required checks, and a reader
  retest cadence
- Deferred issues remain visible with priority and ownership

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can write small parsers and suggest workflow triggers. You decide which
examples are safe to execute, what level of automation the team can maintain,
who owns approval, and when a code change is significant enough to repeat a
reader test.

---

Previous: [Stage 3: Repair and Test the Core Journey](stage-3-repair-core-journey.md)
