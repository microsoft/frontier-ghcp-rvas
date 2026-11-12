# Stage 1: Application Discovery and Test Planning

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

Explore eShop manually and with the Playwright MCP server, then build a test plan.

## Tasks

Use your repository instructions for eShop and Playwright context, your test planning agent for flows and risks, and your selector discovery skill on the live pages.

1. Open the running eShop app in your browser. Browse the catalog, view a product, log in, and add items to the cart. Note page names, key elements, forms, buttons, and navigation patterns.

2. **Ask Copilot about the app**: Open the `app/` folder in VS Code. Use Copilot Chat to ask questions about the application. Try prompts like:
   - "What are the main user-facing pages in this application?"
   - "What authentication method does this app use?"
   - "What API endpoints serve the catalog page?"
   Note which answers are accurate and which you'd need to verify.

3. **Explore with Playwright MCP**: Set up the Playwright MCP server following `docs/playwright-mcp-guide.md`. Then ask Copilot (with MCP active) to navigate the application:
   - "Navigate to the eShop home page and describe what you see"
   - "Go to the login page and list all the form fields and buttons"
   - "Browse the catalog and tell me how many products are displayed"
   Compare what MCP reports with what you saw manually.

4. **Create a test plan**: Based on your exploration, create a file called `docs/test-plan.md` in the challenge folder. Use Copilot to draft it. Include:
   - A list of the main user flows (login, browse catalog, add to cart, checkout)
   - For each flow, 3-5 test scenarios (both happy path and error cases)
   - A risk ranking: which flows are most critical if they break?

## Verification

- You have explored the application both manually and via Playwright MCP
- Copilot Chat was used to ask at least 3 questions about the application codebase
- `docs/test-plan.md` exists with at least 4 user flows and test scenarios for each
- The test plan includes a risk ranking

## What Copilot Helps With vs. What Requires Your Judgment

Copilot describes the codebase and Playwright MCP reports page elements. Check both against the app. You decide which flows and edge cases to test first.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Your First Automated Tests with Copilot](stage-2-page-objects.md)
