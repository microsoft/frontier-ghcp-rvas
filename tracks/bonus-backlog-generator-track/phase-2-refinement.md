# Phase 2: Refinement Agent

[Back to Backlog Generator Track](../bonus-backlog-generator-track.md)

**Duration:** 1.5-2 hours

**Focus:** Building an agent that reviews generated backlogs for gaps and inconsistencies

## Tasks

1. **Define what the agent should check.** Before building it, list the review criteria:
   - Every requirement in the spec has at least one Story covering it
   - Every alternative flow has Stories or acceptance criteria covering it
   - Business rules are testable in the acceptance criteria (not vague)
   - Dependencies between Stories are identified
   - Open questions from the spec are flagged (not silently resolved or ignored)
   - No duplicate Stories covering the same functionality

2. **Create the refinement agent.** Create `.github/agents/backlog-reviewer.agent.md` that:
   - Takes two inputs: the original spec (`#file:spec`) and the generated backlog (`#file:backlog`)
   - Compares them systematically against the review criteria
   - Outputs a gap analysis: what is missing, what is ambiguous, what might be duplicated
   - Suggests specific additions or modifications with draft text

3. **Test on the Password Reset spec.** Run the agent with the Password Reset spec and the backlog you generated in Phase 1. Intentionally leave one gap in the backlog (skip an alternative flow) and verify the agent catches it.

4. **Test on the Inventory Reorder spec.** This is the hardest spec. Run the agent and check whether it catches:
   - EOQ formula coverage
   - Supplier inactive flow
   - Procurement API retry logic
   - Dual approval for high-value POs
   - Auto-submission of critical items after 48 hours

5. **Iterate on the agent.** Adjust its instructions until it reliably catches real gaps without producing excessive false positives.

## Verification

- [ ] Review criteria defined
- [ ] Refinement agent created (`.github/agents/backlog-reviewer.agent.md`)
- [ ] Agent correctly identifies an intentional gap in the Password Reset backlog
- [ ] Agent tested on the Inventory Reorder spec
- [ ] Agent refined based on false positive/negative feedback

---

Previous: [Phase 1: Spec-to-Backlog Prompt](phase-1-prompt.md) | Next: [Phase 3: MCP Integration](phase-3-mcp.md)
