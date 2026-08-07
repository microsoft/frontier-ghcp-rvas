# Stage 1: Spec to Backlog

**Duration:** 1.5-2 hours

**Focus:** Building a prompt that converts the billing module spec into structured work items

## Tasks

Before you build the prompt, use the full trio: keep your repository instructions open for the existing app's conventions, bring in the Requirements Analyst agent for the first structuring pass, and design the spec-to-backlog sequence as a reusable skill from the start, since that reusability is the point of this track.

1. **Study the requirements document.** Read `specs/billing-module-requirements.md` thoroughly. Identify the natural Epic boundaries: subscription management, usage metering, invoice generation, payment processing, and admin/dashboard features.

2. **Build the spec-to-backlog prompt.** Create `.github/prompts/spec-to-backlog.prompt.md` that:
   - Takes the requirements document as input via `#file`
   - Produces Epics aligned with functional areas
   - Produces User Stories under each Epic with Given/When/Then acceptance criteria
   - Produces Technical Tasks for implementation details (database schema, API endpoints, integrations)
   - Produces Test Cases for each Story
   - Identifies dependencies between Stories (e.g., payment method management must exist before invoice payment)
   - Flags open questions from the spec

3. **Run the prompt.** Generate the full backlog for the billing module. Save the output to `docs/generated-backlog.md` in the challenge folder.

4. **Review for completeness.** Walk through each section of the spec and verify:
   - All plan structures and transitions are covered
   - All metering requirements have Stories
   - The invoice lifecycle (DRAFT to FINALIZED to PAID/OVERDUE) is fully covered
   - Payment processing with Stripe integration has Stories
   - All API endpoints from section 7 are mapped to Stories or Tasks
   - Authorization rules from section 8 are in acceptance criteria
   - Events from section 9 have corresponding Stories
   - Data retention from section 10 is addressed

5. **Iterate on the prompt.** Fix any coverage gaps and re-run until the backlog is comprehensive.

## Verification

- [ ] Spec-to-backlog prompt created (`.github/prompts/spec-to-backlog.prompt.md`)
- [ ] Full backlog generated with Epics, Stories, Tasks, and Test Cases
- [ ] All 10 sections of the spec reflected in the backlog
- [ ] Dependencies between Stories identified
- [ ] Open questions flagged (not silently resolved)

---

Previous: [Stages](stages.md) | Next: [Stage 2: Technical Analysis](stage-2-analysis.md)
