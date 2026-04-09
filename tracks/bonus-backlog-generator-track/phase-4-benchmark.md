# Phase 4: Consistency Benchmark

[Back to Backlog Generator Track](../bonus-backlog-generator-track.md)

**Duration:** 1-1.5 hours

**Focus:** Testing your prompt across all three specs and measuring output consistency

## Tasks

1. **Process all three specs.** Run your spec-to-backlog prompt on:
   - `uc-password-reset.md` (if not already done)
   - `uc-notification-preferences.md`
   - `uc-inventory-reorder.md`
   Save each output as a separate file in the challenge folder.

2. **Compare structural consistency.** Across all three outputs, check:
   - Do Epics follow the same naming convention?
   - Do Stories use the same format (As a/I want/So that vs. title-only)?
   - Are acceptance criteria consistently structured (Given/When/Then vs. checklist)?
   - Are effort estimates present and using the same scale?
   - Are dependencies formatted the same way?

3. **Compare coverage consistency.** For each spec, verify:
   - Are all main flows covered?
   - Are all alternative flows covered?
   - Are all business rules reflected?
   - Are open questions flagged?
   - Are non-functional requirements captured?

4. **Run the refinement agent on all three.** Use the agent from Phase 2 to review all three generated backlogs. Compare the gap analysis across specs -- does the agent catch similar types of gaps consistently?

5. **Multi-person test (if your team has multiple people).** Have two team members independently run the same prompt on the same spec. Compare their outputs. High consistency means your prompt is deterministic enough to reduce person-to-person variation.

6. **Document findings.** Write a brief consistency report: what works well, what varies, and what prompt refinements would improve consistency.

## Verification

- [ ] All 3 specs processed through the prompt with outputs saved
- [ ] Structural consistency checked across outputs
- [ ] Coverage consistency checked across outputs
- [ ] Refinement agent run on all three outputs
- [ ] Consistency report written with improvement recommendations

---

Previous: [Phase 3: MCP Integration](phase-3-mcp.md)
