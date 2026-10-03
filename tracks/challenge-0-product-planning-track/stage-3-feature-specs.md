# Stage 3: Feature Specification and Technical Alignment

**Difficulty:** ⭐⭐ | **Time:** 75-90 min

A feature spec must describe how the feature fits the existing system and resolve conflicting requirements.

## Tasks

1. **Write two feature specs** -- Pick the two most important features from your backlog. For each, copy [docs/feature-spec.md](../../challenges/challenge-0-product-planning/docs/feature-spec.md) to a new file and fill in every section.

2. Map one feature spec to the existing REST API from Challenge 1. Identify the endpoints it uses and any new endpoints, fields, or behaviors needed. Document the gaps as "API Change Requests" in the spec.

3. **Diagrams** -- Each spec must include at least two Mermaid diagrams: a **sequence diagram** showing system interactions, and a **state diagram** showing the lifecycle of the primary entity (e.g., a notification's states: created, sent, read, dismissed).

4. **Measurable NFRs** -- Every non-functional requirement must have a specific, testable threshold. Not "the feature should be fast" but "notification delivery latency p95 < 3 seconds measured from event trigger to client receipt."

5. **Spec review exercise** -- Open [docs/bad-feature-spec.md](../../challenges/challenge-0-product-planning/docs/bad-feature-spec.md). It contains a pre-written feature spec with 5 intentional problems (a missing edge case, two contradictory requirements, an undefined technical term used without explanation, an unmeasurable NFR, and a missing dependency). Find all five, document each problem, and write the corrected version.

6. **Open a Pull Request** for your specs on a branch. Write a PR description that summarizes the features and calls out open questions.

If your agent or writing skill produces vague NFRs, interchangeable personas, or weak acceptance criteria, revise the customization before asking it to revise the draft.

## Verification

- Two complete feature specs exist, each with all sections filled
- One spec includes API change requests referencing specific endpoints
- Each spec has a sequence diagram and a state diagram in Mermaid
- All NFRs include measurable thresholds with units
- All 5 issues in [docs/bad-feature-spec.md](../../challenges/challenge-0-product-planning/docs/bad-feature-spec.md) are identified and corrected
- A PR is open with a clear description

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft requirements and Mermaid diagrams. Read Challenge 1's code or documentation to check the API mapping. Review the requirements for contradictions and make sure each NFR can be measured.

---

Previous: [Stage 2: User Stories and Backlog Quality](stage-2-user-stories.md) | Next: [Stage 4: Decision Making Under Constraints](stage-4-decision-making.md)
