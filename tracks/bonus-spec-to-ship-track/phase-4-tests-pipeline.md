# Phase 4: Test Specs and Pipeline

[Back to Spec-to-Ship Accelerator Track](../bonus-spec-to-ship-track.md)

**Duration:** 1.5-2 hours

**Focus:** Generating test specification documents and a CI pipeline

## Tasks

1. **Build a test spec agent.** Create `.github/agents/test-spec-writer.agent.md` that:
   - Takes user stories (from Phase 1) as input
   - Produces a test specification document for each story
   - Each test spec includes: test ID, description, preconditions, test steps, expected results, and priority
   - Covers happy path, alternative flows, edge cases, and negative tests
   - Groups tests by story and epic for traceability

2. **Generate test specs.** Run the agent on the stories from your Phase 1 backlog. Focus on at least 3 stories:
   - A subscription plan change story (covers proration logic)
   - An invoice generation story (covers overage calculation)
   - A payment method management story (covers the "can't delete the last one" constraint)

3. **Review test spec quality.** Check that the generated test specs:
   - Have testable acceptance criteria (not vague "verify it works correctly")
   - Cover the edge cases from the spec (e.g., what happens at exactly 80% quota)
   - Include negative tests (invalid inputs, unauthorized access)
   - Are structured consistently across stories

4. **Create a CI pipeline.** Create `.github/workflows/ci.yml` that:
   - Runs on pull requests and pushes to main
   - Installs dependencies
   - Runs the unit tests from Phase 3
   - Reports test results
   - Caches node_modules

5. **Save all prompts and agents.** Verify that all the artifacts you created across all 4 phases are saved in `.github/prompts/` and `.github/agents/`. These are the reusable tools your team takes home.

## Verification

- [ ] Test spec agent created (`.github/agents/test-spec-writer.agent.md`)
- [ ] Test specs generated for at least 3 stories
- [ ] Test specs include happy path, edge cases, and negative tests
- [ ] CI pipeline created and validates the test suite
- [ ] All prompts and agents saved in `.github/prompts/` and `.github/agents/`

---

Previous: [Phase 3: Code Generation](phase-3-code.md)
