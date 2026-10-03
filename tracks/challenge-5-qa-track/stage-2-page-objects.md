# Stage 2: Your First Automated Tests with Copilot

**Difficulty:** ⭐⭐ | **Time:** 60-90 min

Use Copilot to turn your test plan into automated tests. Diagnose and fix the intentional bugs in the starter tests.

## Tasks

1. **Run the starter tests**: Execute `npx playwright test` from the `challenges/challenge-5-qa` directory. The tests will fail. Read the error messages carefully.

2. Open `tests/pages/LoginPage.ts`, which contains 3 intentional bugs. Paste each error into Copilot Chat and ask for help. Example prompts:
   - "This test is timing out on `usernameInput.waitFor`. What could be wrong with the selector?"
   - "This test passes sometimes and fails sometimes. What causes flaky behavior?"
   - "This test crashes with `innerText() failed`. What's a safer way to get text that might not exist?"
   Apply Copilot's suggested fixes. Verify each one actually resolves the issue.

3. **Adapt selectors with Copilot**: The LoginPage selectors are generic templates. Use your browser's Inspect tool to find the real selectors in the eShop login page. Then ask Copilot to update the page object: "Update the LoginPage selectors to use these elements I found: [paste what you inspected]."

4. **Generate new test cases**: Pick at least 3 scenarios from your Stage 1 test plan that cover the login flow. For each one, describe it to Copilot in plain English and ask it to write the test. For example:
   - "Write a Playwright test that verifies a user sees an error message when they submit the login form with an empty email field."
   - "Write a test that checks if the login page redirects to the catalog after a successful login."
   Review each generated test. Does it test what you intended? Does the assertion make sense?

5. **Run and iterate**: Run all tests again. If any fail, use Copilot to diagnose and fix. Keep iterating until all tests pass consistently (run 3 times with zero flakes).

## Verification

- The 3 bugs in `LoginPage.ts` are fixed (document what each bug was in a code comment)
- Selectors match the actual eShop application
- At least 3 new test cases were generated with Copilot and pass
- All login tests pass consistently across 3 runs

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can suggest fixes from error messages and generate tests from plain-English descriptions. Review the assertions and check that each test fails when the intended behavior is broken.

---

Previous: [Stage 1: Application Discovery and Test Planning](stage-1-setup-debug.md) | Next: [Stage 3: Expanding Test Coverage](stage-3-cross-browser.md)
