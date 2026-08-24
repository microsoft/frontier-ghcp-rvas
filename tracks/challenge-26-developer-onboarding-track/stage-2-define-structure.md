# Stage 2: Define Audience, Structure, and Language

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

## Tasks

1. Turn the audience/task map into a proposed page tree. Give each page one
   primary job: orientation, quickstart, tutorial, concept, CLI lookup, SDK
   lookup, or maintenance.
2. Decide what `docs/index.md` should help a first-time reader choose. Add
   navigation that exposes the quickstart, tutorial, references, and project
   vocabulary without forcing a linear read.
3. Create `docs/editorial-decisions.md`. Record the preferred terms and the
   terms to replace. Settle the meaning of profile, setup plan, audience, and
   shell using the implementation as evidence.
4. Add a short style section covering audience labels, prerequisites, command
   formatting, expected output, version claims, links, and the difference
   between task guidance and reference.
5. Review the proposed structure with the Information Architecture Reviewer
   agent. Ask it to identify duplicate page purposes, hidden prerequisites,
   and tasks with no clear starting page.
6. Update the issue inventory with the destination and acceptance criteria for
   each high-priority repair.

Keep the decisions small enough to apply in this session. A useful style note
that fits on one page is better than a broad guide nobody can test.

## Verification

- Every priority audience has a visible starting point and first task
- Each proposed page has one stated purpose
- Preferred and deprecated terms are recorded with clear meanings
- Style decisions say how commands, output, prerequisites, and versions are
  documented
- High-priority inventory items have destinations and acceptance criteria

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can find inconsistent terms and compare the proposed tree with common
documentation patterns. You decide the audience boundaries, where conceptual
context belongs, and which distinctions readers actually need.

---

Previous: [Stage 1: Test Onboarding and Map Failures](stage-1-test-onboarding.md) | Next: [Stage 3: Repair and Test the Core Journey](stage-3-repair-core-journey.md)
