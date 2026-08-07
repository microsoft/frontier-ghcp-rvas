# Challenge 5 Track: QA & Testing

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Using GitHub Copilot to test a real application -- test planning, test generation, debugging, and reporting

## Who Is This For

- QA Engineers and Quality Assurance Specialists
- Manual testers looking to use AI-assisted testing tools
- Test leads and QA managers who want to evaluate Copilot for their teams

This track does not assume coding experience. You will use Copilot to generate, explain, and fix test code rather than writing it from scratch. The goal is to learn what Copilot can do for QA workflows, where it shines, and where your testing judgment is still essential.

## Prerequisites

- Familiarity with manual testing concepts (test cases, expected vs actual results, bug reports)
- Basic understanding of what automated tests do (you don't need to have written them)
- Comfort with running terminal commands (copy-paste level is fine)
- A browser and the ability to inspect web page elements (right-click > Inspect)

## Technology Stack

- **Application Under Test**: .NET 9.0 / ASP.NET Core + .NET Aspire (eShop)
- **Test Framework**: Playwright (TypeScript) -- Copilot writes the code; you guide it
- **AI Integration**: Playwright MCP Server, GitHub Copilot Chat
- **Environment**: Docker & DevContainers

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-5-qa/`. You will not build an application in this track. Instead, you will test an existing one (eShop) using Copilot as your testing assistant. Browse the running application's pages before writing any instructions or tests.

#### Setup: Target Application

You will be testing **[eShop](https://github.com/dotnet/eShop)**, a .NET Aspire reference application with a microservices architecture.

> ⚠️ **Setup note**: eShop uses .NET Aspire and Docker. The initial setup takes a few minutes as it pulls container images and starts multiple services. Be patient during first launch.

1. **Clone the Repository**:

    ```bash
    git clone https://github.com/dotnet/eShop.git app
    cd app && git checkout 5624ad564d1602a927879df32a79b94522eb6101
    ```

2. **Clean Up Existing Tests**:

    ```bash
    rm -rf app/tests app/e2e
    ```

3. **Remove Test Projects from Solution**:
    Open `app/eShop.slnx` and remove the test projects from the solution file.

4. **Remove from solution filter**:
    Also delete test project references from `app/eShop.slnf`.

5. **Verify Application Runs**:

    ```bash
    cd app
    dotnet restore eShop.Web.slnf
    dotnet dev-certs https --trust
    dotnet run --project src/eShop.AppHost/eShop.AppHost.csproj
    ```

    Open the Aspire dashboard URL from terminal output. Update `baseURL` in `playwright.config.ts` to match your running eShop webapp URL.

6. **Install Playwright**:

    ```bash
    cd challenges/challenge-5-qa
    npm install
    npx playwright install
    ```

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- That you are a QA tester working with Playwright and TypeScript
- That the target application is eShop, a .NET Aspire e-commerce reference app
- Your preferred test structure (describe/it blocks, AAA pattern)
- That you want Copilot to explain code it generates, not just produce it
- That test names should describe the user behavior being verified
- Non-negotiable: never report a failure as a bug without checking whether the selector or a wait condition is the actual cause

### Suggested Custom Agents

- **Test Planner Agent** -- Applies test design judgment: which user flows matter most, what edge cases exist, and where risk concentrates in the application. Give it a page or feature area; it proposes a scenario list. Use it before writing any test code.
- **Playwright Helper Agent** -- Generates and explains Playwright code in plain terms, translating a described scenario into selectors and assertions. Give it a scenario and the page's structure; it returns code plus a plain-language walkthrough. Use it once you know what to test.
- **Bug Reporter Agent** -- Applies judgment on what makes a bug report actionable: reproduction steps, expected vs. actual, and severity. Give it a failing test or error message; it drafts a structured report. Use it after a test fails, not as a test-writing tool.

### Suggested Custom Skills

- **Test Failure Triage Skill** -- A fixed sequence for a failing test: read the error, check the selector against the live page, and classify the failure as a real bug, a flaky wait, or a stale selector. Run it every time a test fails before rewriting anything.
- **Selector Discovery Skill** -- A repeatable workflow using the browser's Inspect tool to capture stable selectors for a page, then confirm each one against the Playwright MCP server before using it in a test. Use it before writing tests against a new page.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "playwright test agent", "bug report skill", and "QA instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Describe what you want to test in plain English before asking Copilot to write code. "Test that a user can add an item to the cart and see the total update" produces better results than "write a Playwright test."
- Keep the application's page open alongside VS Code. Use the browser's Inspect tool to find selectors, then paste them into your Copilot prompts.
- When Copilot generates code you don't understand, ask it to explain. Use prompts like "Explain what this test does step by step" or "Why did you use `waitFor` here?"
- If a test fails, paste the error message into Copilot Chat and ask it to diagnose the problem. This is one of Copilot's strongest use cases.
- If the Playwright MCP tool fails, check the Output panel in VS Code under "GitHub Copilot MCP" for logs.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)

---

Next: [Stages](challenge-5-qa-track/stages.md)
