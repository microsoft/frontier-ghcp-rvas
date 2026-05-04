# Stage 5: Reporting, Analysis, and Test Strategy

[Back to Challenge 5: QA & Testing Track](../challenge-5-qa-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Tests exist. Now make them useful to your team: build reporting, analyze flakiness, and create a test strategy that captures what you've learned.

## Tasks

1. **Build a custom reporter with Copilot**: Open the skeleton in `reporters/markdown-reporter.ts`. Ask Copilot to implement it:
   - "Implement this Playwright custom reporter. It should generate a markdown file with: total pass/fail counts, duration per test, links to failure screenshots, and a summary table."
   Run the tests with the custom reporter enabled and check the output.

2. **Analyze flaky tests**: Run the full test suite 5 times. If any tests fail intermittently, paste the failure details into Copilot Chat:
   - "This test passes 3 out of 5 times. Here's the error when it fails: [paste error]. What's causing the flakiness?"
   For each flaky test, either fix it or mark it with `test.fixme()` and document the reason.

3. **Complete the test strategy**: Open `docs/test-strategy-template.md` and complete it. Use Copilot as a thinking partner:
   - "Based on a shopping e-commerce application with login, catalog, cart, and checkout, help me fill out a test strategy. Which areas are highest risk?"
   - "Create a traceability matrix mapping these user stories to test cases: [list your test scenarios]."
   The strategy should reflect your experience from Stages 1-4 -- what worked, what was hard, where Copilot saved time.

4. **Copilot effectiveness review**: Add a section to your test strategy called "Copilot for QA -- Observations." Based on your hands-on experience across all stages, answer:
   - Which QA tasks did Copilot handle well?
   - Where did you need to override or correct Copilot's output?
   - What prompting patterns worked best for generating useful tests?
   - Would you recommend Copilot for your QA team? Under what conditions?

## Verification

- Custom reporter generates a readable markdown summary when tests run
- Flaky tests are either fixed or documented with `test.fixme()` and a reason
- Test strategy document is complete with risk prioritization and traceability matrix
- Copilot effectiveness section includes specific observations from your experience

---

Previous: [Stage 4: AI-Driven Testing with Playwright MCP](stage-4-ai-driven.md)
