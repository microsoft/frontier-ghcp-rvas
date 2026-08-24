# Stage 1: Test Onboarding and Map Failures

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

## Tasks

Use the Customization Trio from the start. Keep your repository instructions
available as the evidence and style baseline, use the Onboarding Reader agent
for one defined audience journey, and run your Onboarding Test skill so each
attempt records the same facts.

1. Run `npm install`, `npm run build`, and `npm test` in the challenge folder.
   Confirm that the CLI and SDK work before judging the documentation.
2. Start at `docs/index.md` as an API developer who needs to discover the right
   setup profile and generate a setup plan. Follow only links and instructions
   available to that reader. Record every failed command, unsupported claim,
   missing prerequisite, ambiguous term, and navigation dead end.
3. Repeat a smaller journey as a web developer who wants to use the SDK.
   Compare the documented exports with `src/index.ts`, `src/sdk.ts`, and the
   tests.
4. Create `docs/audience-task-map.md`. For each audience, list the first useful
   task, required prior knowledge, likely starting page, and evidence of
   success.
5. Create `docs/issue-inventory.md`. Give each issue a location, reader impact,
   evidence, priority, and proposed destination. Separate factual defects from
   information architecture and style problems.
6. Run `npm run docs:check`. Note what the scripts catch and, just as
   importantly, which broken examples they ignore.

Do not rewrite pages yet. A precise failure map prevents the loudest page from
consuming the whole repair.

## Verification

- The code builds and all CLI/SDK tests pass
- The task map covers at least two distinct developer audiences
- The issue inventory includes command, SDK, navigation, context, and
  terminology defects
- Every high-priority issue cites observed behavior or source code
- The checker coverage gap is recorded as an issue

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can compare claims across files and organize repeated findings. You
decide which reader tasks matter first, how much context a newcomer needs, and
whether a technically correct page is usable.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Define Audience, Structure, and Language](stage-2-define-structure.md)
