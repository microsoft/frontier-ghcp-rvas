# Stage 1: Spec to Backlog

**Duration:** 1.5-2 hours

**Focus:** Building a skill that converts the billing module spec into structured work items

## Tasks

Use your repository instructions for the existing app's conventions and the Requirements Analyst agent for the first structuring pass. Build on the Spec-to-Backlog skill from setup throughout this stage.

1. **Study the requirements document.** Read `specs/billing-module-requirements.md` thoroughly. Identify the natural Epic boundaries: subscription management, usage metering, invoice generation, payment processing, and admin/dashboard features.

2. **Build the spec-to-backlog skill.** Create or refine `.github/skills/spec-to-backlog/SKILL.md` for a repeatable conversion and coverage-review workflow that:
   - Takes the requirements document as input via `#file`
   - Produces Epics aligned with functional areas
   - Produces User Stories under each Epic with Given/When/Then acceptance criteria
   - Produces Technical Tasks for implementation details (database schema, API endpoints, integrations)
   - Produces Test Cases for each Story
   - Identifies dependencies between Stories (e.g., payment method management must exist before invoice payment)
   - Flags open questions from the spec

3. **Use the skill.** Generate the full backlog for the billing module. Save the output to `docs/generated-backlog.md` in the challenge folder.

4. **Review for completeness.** Walk through each section of the spec and verify:
   - All plan structures and transitions are covered
   - All metering requirements have Stories
   - The invoice lifecycle (DRAFT to FINALIZED to PAID/OVERDUE) is fully covered
   - Payment processing with Stripe integration has Stories
   - All API endpoints from section 7 are mapped to Stories or Tasks
   - Authorization rules from section 8 are in acceptance criteria
   - Events from section 9 have corresponding Stories
   - Data retention from section 10 is addressed

5. **Refine the skill.** Address the coverage gaps and generate the backlog again. Check it against the requirements before moving to technical analysis.

## Verification

- [ ] Full backlog generated with Epics, Stories, Tasks, and Test Cases
- [ ] All 10 sections of the spec reflected in the backlog
- [ ] Dependencies between Stories identified
- [ ] Open questions flagged (not silently resolved)

---

Previous: [Stages](stages.md) | Next: [Stage 2: Technical Analysis](stage-2-analysis.md)
