# Stage 4: Test Specs and Pipeline

**Duration:** 1.5-2 hours

**Focus:** Generating test specification documents and a CI pipeline

## Tasks

1. **Build a test spec agent.** Create `.github/agents/test-spec-writer.agent.md` that:
   - Takes user stories (from Stage 1) as input
   - Produces a test specification document for each story
   - Each test spec includes: test ID, description, preconditions, test steps, expected results, and priority
   - Covers happy path, alternative flows, edge cases, and negative tests
   - Groups tests by story and epic for traceability

2. **Generate test specs.** Run the agent on the stories from your Stage 1 backlog. Focus on at least 3 stories:
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
   - Runs the unit tests from Stage 3
   - Reports test results
   - Caches node_modules

5. **Prepare the reusable artifacts for handoff.** Save each skill under `.github/skills/<skill-name>/SKILL.md` and each custom agent under `.github/agents/`. Keep the CI pipeline in `.github/workflows/`. Check that the skills identify their required inputs and reference files that another team member can access.

## Verification

- [ ] Test spec agent created (`.github/agents/test-spec-writer.agent.md`)
- [ ] Test specs generated for at least 3 stories
- [ ] Test specs include happy path, edge cases, and negative tests
- [ ] CI pipeline created and validates the test suite
- [ ] Another team member can use the saved workflows with the documented inputs and available references

---

Previous: [Stage 3: Code Generation](stage-3-code.md)
