# Stage 4: AI-Driven Testing with Playwright MCP

[Back to Challenge 5: QA & Testing Track](../challenge-5-qa-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

You've been guiding Copilot with specific prompts. Now let Copilot take the lead -- use the Playwright MCP server to have it autonomously explore the application and generate tests from what it observes.

## Tasks

1. **MCP autonomous exploration**: With the Playwright MCP server running, ask Copilot to explore a flow you haven't tested yet. Try prompts like:
   - "Navigate to the eShop checkout flow and generate a Playwright test for what you observe."
   - "Explore the product filtering and sorting on the catalog page. Generate tests for each filter option."
   Let Copilot drive the browser and produce tests without you specifying selectors or steps.

2. **Compare approaches**: Pick one user flow (e.g., "add item to cart"). You should now have:
   - A test you guided Copilot to write (from Stage 2 or 3)
   - A test MCP generated autonomously (from Task 1)
   Create a short comparison in `docs/ai-testing-comparison.md`. Note differences in: which assertions each test includes, how selectors were chosen, which edge cases each approach caught, and which test feels more reliable.

3. **Refine MCP-generated tests**: MCP-generated tests often need adjustment. Use Copilot Chat to improve them:
   - "This MCP-generated test hardcodes a product name. Make it work with any product on the page."
   - "Add better error messages to the assertions so failures are easier to diagnose."
   - "This test doesn't clean up after itself. Add a teardown step."

4. **Application behavior under edge conditions**: Ask Copilot to help you test what happens when things go wrong. Use prompts like:
   - "Write a Playwright test that simulates a slow network and checks if the catalog page shows a loading state."
   - "Write a test that verifies the app handles a server error gracefully when adding to the cart."
   These are the kinds of scenarios QA testers think of that AI tools often miss on their own.

## Verification

- At least 2 MCP-generated tests exist and pass
- `docs/ai-testing-comparison.md` documents the comparison between guided and autonomous approaches
- MCP-generated tests have been refined based on review
- At least 1 edge-case test (slow network or error handling) exists and passes

## What Copilot Helps With vs. What Requires Your Judgment

MCP can explore an application and produce tests faster than you can write prompts. But the tests it generates tend to verify what the app *does* rather than what the app *should* do. A test that confirms the current behavior is a snapshot, not a quality check. Your judgment determines whether a behavior is correct, whether an edge case matters, and whether a test would catch a real regression.

---

Previous: [Stage 3: Expanding Test Coverage](stage-3-cross-browser.md) | Next: [Stage 5: Reporting, Analysis, and Test Strategy](stage-5-quality-gates.md)
