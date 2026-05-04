# Stage 2: User Stories and Backlog Quality

[Back to Challenge 0: Product Planning Track](../challenge-0-product-planning-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-90 min

Writing user stories is easy. Writing good ones is harder. This stage tests whether you can tell the difference.

## Tasks

1. **Critique bad stories** -- Open [docs/bad-user-stories.md](../../challenges/challenge-0-product-planning/docs/bad-user-stories.md). It contains 5 poorly-written user stories with common anti-patterns (solution-prescriptive language, missing "so that" clause, vague acceptance criteria, stories that are really epics, untestable criteria). For each story, identify the specific problem and rewrite it correctly. Document the before/after with an explanation of what was wrong.

2. **Write 10+ user stories** across the four epics in [docs/user-stories.md](../../challenges/challenge-0-product-planning/docs/user-stories.md). Each story must include acceptance criteria, priority, and size estimate.

3. **INVEST audit** -- For each of your 10 stories, self-assess against the INVEST criteria (Independent, Negotiable, Valuable, Estimable, Small, Testable). Document any story that fails a criterion and explain how you would fix it (or why it is acceptable as-is).

4. **MoSCoW prioritization** -- Categorize all stories using MoSCoW (Must have, Should have, Could have, Won't have). Write a short rationale for each "Must have" explaining why the release cannot ship without it, and for each "Won't have" explaining what would change your mind.

5. **Create GitHub Issues** -- Convert your stories into GitHub Issues using the template in [templates/user-story-issue.md](../../challenges/challenge-0-product-planning/templates/user-story-issue.md). Apply labels for epic, priority, and MoSCoW category. Create at least 3 GitHub Milestones and assign each issue to one.

   You can create issues in several ways:
   - **GitHub.com** -- Create them directly in the Issues tab of your repository.
   - **Copilot Chat** -- Ask Copilot to help draft issue bodies from your stories file, then paste into GitHub.
   - **GitHub CLI** -- Run `gh issue create` from the terminal if you prefer the command line.

## Verification

- All 5 bad stories in [docs/bad-user-stories.md](../../challenges/challenge-0-product-planning/docs/bad-user-stories.md) have a documented problem and corrected rewrite
- At least 10 user stories with acceptance criteria, priority, and estimate
- INVEST audit is documented for every story
- MoSCoW prioritization includes written rationale for all "Must have" and "Won't have" items
- At least 10 GitHub Issues exist with labels and milestone assignments

## What Copilot Helps With vs. What Requires Your Judgment

Copilot generates user story text and acceptance criteria quickly. It can also apply the INVEST acronym. But identifying what is wrong with someone else's story (the critique exercise), deciding whether a story is truly "Must have" vs. "Should have," and writing persuasive rationale for prioritization decisions require product thinking.

---

Previous: [Stage 1: Product Vision and Market Analysis](stage-1-product-vision.md) | Next: [Stage 3: Feature Specification and Technical Alignment](stage-3-feature-specs.md)
