# Stage 1: Application Discovery and Test Planning

[Back to Challenge 5: QA & Testing Track](../challenge-5-qa-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

Before writing any tests, you need to know what you're testing. In this stage you'll explore the eShop application using Copilot and the Playwright MCP server, then build a test plan.

## Tasks

1. **Explore the app manually**: Open the running eShop application in your browser. Click through the main flows: browse the catalog, view a product, log in, add items to the cart. Take notes on what you see -- page names, key elements, forms, buttons, navigation patterns.

2. **Ask Copilot about the app**: Open the `app/` folder in VS Code. Use Copilot Chat to ask questions about the application. Try prompts like:
   - "What are the main user-facing pages in this application?"
   - "What authentication method does this app use?"
   - "What API endpoints serve the catalog page?"
   Observe how Copilot uses the codebase as context. Note which answers are accurate and which need verification.

3. **Explore with Playwright MCP**: Set up the Playwright MCP server following `docs/playwright-mcp-guide.md`. Then ask Copilot (with MCP active) to navigate the application:
   - "Navigate to the eShop home page and describe what you see"
   - "Go to the login page and list all the form fields and buttons"
   - "Browse the catalog and tell me how many products are displayed"
   Compare what MCP reports with what you saw manually.

4. **Create a test plan**: Based on your exploration, create a file called `docs/test-plan.md` in the challenge folder. Use Copilot to help you draft it. Include:
   - A list of the main user flows (login, browse catalog, add to cart, checkout)
   - For each flow, 3-5 test scenarios (both happy path and error cases)
   - A risk ranking: which flows are most critical if they break?

## Verification

- You have explored the application both manually and via Playwright MCP
- Copilot Chat was used to ask at least 3 questions about the application codebase
- `docs/test-plan.md` exists with at least 4 user flows and test scenarios for each
- The test plan includes a risk ranking

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can read the codebase and describe what it finds. Playwright MCP can navigate pages and report element structures. But deciding which flows matter most, which edge cases are worth testing, and how to prioritize -- that's QA judgment. Copilot gives you raw material; you shape it into a testing strategy.

---

Next: [Stage 2: Your First Automated Tests with Copilot](stage-2-page-objects.md)
