# Stage 3: Expanding Test Coverage

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Login tests are passing. Now expand coverage to the core shopping flow and run tests across browsers.

## Tasks

1. **Generate page objects with Copilot**: Open the `CatalogPage.ts` skeleton in `tests/pages/`. Use Copilot to build it out. Share context by opening the eShop catalog page in your browser, inspecting the key elements, and telling Copilot:
   - "Here are the elements on the catalog page: [paste selectors]. Create a CatalogPage class following the BasePage pattern in `BasePage.ts`."
   - Ask Copilot to also generate a `BasketPage.ts` for the shopping cart page.

2. **Build a shopping flow test**: Describe the full user journey to Copilot and ask it to generate a test:
   - "Write a Playwright test that logs in, browses the catalog, adds a product to the basket, then verifies the basket shows the correct item and quantity."
   Review the generated test. Does it follow a realistic user flow? Adjust prompts and regenerate if needed.

3. Run `npx playwright test` on Chromium, Firefox, and WebKit, which are already configured in `playwright.config.ts`. Give Copilot any browser-specific errors and ask it to help diagnose them.

4. Run tests on the Pixel 5 profile in `playwright.config.ts`. The product grid reflows and filter links stack vertically at this width. Ask Copilot to draft assertions that verify products render and filters remain interactive. Review tests that depend on hover and adapt them for touch input.

5. Ask Copilot to capture the catalog and basket pages during tests. Save the images to `screenshots/` and compare layouts across browsers.

If your Playwright agent or selector skill produces generic page objects, mismatched selectors, or assertions that miss mobile quirks, revise that customization before the cross-browser run.

## Verification

- `CatalogPage.ts` and `BasketPage.ts` are implemented and follow the `BasePage` pattern
- Shopping flow test passes end-to-end
- Tests run on Chromium, Firefox, and WebKit (document any browser-specific fixes)
- Mobile viewport test passes or has documented workarounds
- Screenshots saved for at least 2 browsers

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft page objects and browser configuration. For browser-specific failures, check timing, rendering, and event handling. Verify that each fix resolves the cause rather than hiding the failure.

---

Previous: [Stage 2: Your First Automated Tests with Copilot](stage-2-page-objects.md) | Next: [Stage 4: AI-Driven Testing with Playwright MCP](stage-4-ai-driven.md)
