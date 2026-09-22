# Stage 1: Spec-to-Backlog Skill

**Duration:** 2-2.5 hours

**Focus:** Building and refining a skill that converts requirement specs into structured backlogs

## Tasks

Use your repository instructions for backlog conventions and the Backlog Architect agent for the first structuring pass. Refine the Spec-to-Backlog Conversion skill from setup as you work through the specs.

1. **Study the source material.** Read `uc-password-reset.md` carefully. Identify the natural groupings (Epic-level themes), the individual capabilities (Story-level), and the implementation details (Task-level).

2. **Design your output format.** Review the templates in `templates/backlog-item-templates.md`. Decide on your team's conventions:
   - How many Epics per use case? (Group by functional area, by actor, or by system integration?)
   - Acceptance Criteria format: Given/When/Then or checklist?
   - Should each Story have estimated effort? Technical notes? Dependencies?

3. **Build the backlog skill.** Create or refine `.github/skills/spec-to-backlog/SKILL.md` for a repeatable conversion and coverage-review workflow that:
   - Takes a use case specification as input (referenced via `#file`)
   - Produces Epics with description and business value
   - Produces User Stories under each Epic with acceptance criteria
   - Produces Technical Tasks under each Story
   - Produces Test Cases linked to Stories
   - Applies INVEST criteria (Independent, Negotiable, Valuable, Estimable, Small, Testable)

4. **Use the skill on Password Reset.** Generate a backlog from `uc-password-reset.md`. Review the output:
   - Are all flows covered (main flow + all alternative flows)?
   - Are the business rules reflected in acceptance criteria?
   - Are the non-functional requirements captured somewhere?
   - Are dependencies between stories identified?

5. **Iterate.** Refine the skill when stories are too large, acceptance criteria are vague, alternative flows are missing, or open questions are not flagged.

6. **Use the skill on a harder spec.** Try it on `uc-notification-preferences.md`. Check coverage of the preference matrix, GDPR rules, and channel availability logic. Refine the skill based on gaps.

## Verification

- [ ] Password Reset backlog generated with Epics, Stories, Tasks, and Test Cases
- [ ] All main and alternative flows covered in the generated backlog
- [ ] Business rules reflected in acceptance criteria
- [ ] At least 2 specs produce backlogs in the team's format with coverage gaps addressed

---

Previous: [Stages](stages.md) | Next: [Stage 2: Refinement Agent](stage-2-refinement.md)
