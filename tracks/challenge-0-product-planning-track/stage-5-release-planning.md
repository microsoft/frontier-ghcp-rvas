# Stage 5: Release Planning and Go-to-Market

[Back to Challenge 0: Product Planning Track](../challenge-0-product-planning-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 90-120 min

A release plan is not just a list of features and dates. It is a risk management document, a communication tool, and a rollback strategy.

## Tasks

1. **Complete the release plan** in [docs/release-plan.md](../../challenges/challenge-0-product-planning/docs/release-plan.md). Map milestones to your GitHub Milestones and Issues. Every milestone must be independently shippable -- if you stopped after milestone 1, customers would get something useful.

2. **Risk matrix** -- Replace the simple risk table with a proper probability-vs-severity matrix. Use a 3x3 or 5x5 grid. Each risk must have a probability score, severity score, composite score, mitigation plan, and trigger condition (what observable event tells you the risk is materializing).

3. **Mermaid Gantt chart** -- Add a Mermaid Gantt diagram to the release plan showing all milestones, their features, dependencies between features, and a critical path. The Gantt must reflect realistic durations (matching your stakeholder budget from Stage 4).

4. **Rollback plan** -- For each milestone, define what "rollback" means. Copy [templates/rollback-plan.md](../../challenges/challenge-0-product-planning/templates/rollback-plan.md) once per milestone and fill in every section. How do you undo a shipped feature? Consider: feature flags, data migration reversal, API versioning, and customer communication.

5. **Dual release notes** -- Write two versions of release notes for v2.0:
   - `docs/release-notes-internal.md` -- Written for the engineering team and internal stakeholders. Use [templates/release-notes-internal.md](../../challenges/challenge-0-product-planning/templates/release-notes-internal.md) as a starting point. Technical in tone, references specific issues and PRs, discusses known limitations.
   - `docs/release-notes-external.md` -- Written for customers. Use [templates/release-notes-external.md](../../challenges/challenge-0-product-planning/templates/release-notes-external.md) as a starting point. Focuses on benefits, new capabilities, and migration steps. No internal jargon.

6. **Post-launch monitoring spec** -- Add a section to the release plan defining what a monitoring dashboard should track in the first 2 weeks after launch. Include at least 5 metrics, each with a green/yellow/red threshold. Example: "Error rate: green < 0.5%, yellow 0.5-2%, red > 2% -- triggers incident response."

7. **Set up a GitHub Project board** -- Create a Project on GitHub. Add all your issues. Organize them by milestone and status.

## Verification

- Release plan milestones match GitHub Milestones
- Risk matrix uses probability x severity scoring with composite scores
- Mermaid Gantt diagram renders correctly and shows dependencies
- Rollback plan covers every milestone with specific reversal steps
- Two release notes exist with clearly different tone and content
- Monitoring spec has 5+ metrics with green/yellow/red thresholds
- GitHub Project board is set up with issues organized

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft release notes, generate Gantt diagram syntax, and suggest monitoring metrics. But calibrating risk probabilities to your specific project, designing realistic rollback strategies (not generic ones), writing external release notes that actually sound like they are for customers (not engineers), and setting monitoring thresholds that would trigger the right response require experience and context.

---

Previous: [Stage 4: Decision Making Under Constraints](stage-4-decision-making.md)
