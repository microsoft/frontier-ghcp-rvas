# Phase 1: Spec-to-Backlog Prompt

[Back to Backlog Generator Track](../bonus-backlog-generator-track.md)

**Duration:** 2-2.5 hours

**Focus:** Building and refining a prompt that converts requirement specs into structured backlogs

## Tasks

1. **Study the source material.** Read `uc-password-reset.md` carefully. Identify the natural groupings (Epic-level themes), the individual capabilities (Story-level), and the implementation details (Task-level).

2. **Design your output format.** Review the templates in `templates/backlog-item-templates.md`. Decide on your team's conventions:
   - How many Epics per use case? (Group by functional area, by actor, or by system integration?)
   - Acceptance Criteria format: Given/When/Then or checklist?
   - Should each Story have estimated effort? Technical notes? Dependencies?

3. **Build the backlog prompt.** Create `.github/prompts/spec-to-backlog.prompt.md` that:
   - Takes a use case specification as input (referenced via `#file`)
   - Produces Epics with description and business value
   - Produces User Stories under each Epic with acceptance criteria
   - Produces Technical Tasks under each Story
   - Produces Test Cases linked to Stories
   - Applies INVEST criteria (Independent, Negotiable, Valuable, Estimable, Small, Testable)

4. **Run the prompt on Password Reset.** Generate a backlog from `uc-password-reset.md`. Review the output:
   - Are all flows covered (main flow + all alternative flows)?
   - Are the business rules reflected in acceptance criteria?
   - Are the non-functional requirements captured somewhere?
   - Are dependencies between stories identified?

5. **Iterate.** Fix gaps in the prompt. Common issues: stories too large (split them), acceptance criteria too vague (make them testable), missing edge cases from alternative flows, open questions not flagged.

6. **Run the prompt on a harder spec.** Try it on `uc-notification-preferences.md`. Does it handle the preference matrix? The GDPR rules? The channel availability logic? Refine the prompt based on gaps.

## Verification

- [ ] Backlog prompt created (`.github/prompts/spec-to-backlog.prompt.md`)
- [ ] Password Reset backlog generated with Epics, Stories, Tasks, and Test Cases
- [ ] All main and alternative flows covered in the generated backlog
- [ ] Business rules reflected in acceptance criteria
- [ ] Prompt tested on at least 2 specs with iterative refinement

---

Next: [Phase 2: Refinement Agent](phase-2-refinement.md)
