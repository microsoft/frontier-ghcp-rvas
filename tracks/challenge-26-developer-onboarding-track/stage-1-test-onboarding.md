# Stage 1: Test onboarding and map failures

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

## Tasks

Use repository instructions as the evidence and style baseline. Have the
Onboarding Reader agent review one audience journey, and use the Onboarding
Test skill to record the same facts for each attempt.

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
6. Run `npm run docs:check`. Record which defects the scripts catch and which
   broken examples they miss.

Do not rewrite pages yet. Use the failure map to prioritize repairs.

## Verification

- The code builds and all CLI/SDK tests pass
- The task map covers at least two distinct developer audiences
- The issue inventory includes command, SDK, navigation, context, and
  terminology defects
- Every high-priority issue cites observed behavior or source code
- The checker coverage gap is recorded as an issue

## What Copilot helps with vs. what requires your judgment

Copilot can compare claims across files and organize repeated findings. You
decide which reader tasks matter first, how much context a newcomer needs, and
whether a technically correct page is usable.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Define Audience, Structure, and Language](stage-2-define-structure.md)
