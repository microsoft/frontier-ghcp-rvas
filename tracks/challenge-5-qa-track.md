# Challenge 5 Track: QA & Testing

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Use GitHub Copilot to plan, generate, debug, and report tests for a real application

## Who is this for

- QA Engineers and Quality Assurance Specialists
- Manual testers looking to use AI-assisted testing tools
- Test leads and QA managers who want to evaluate Copilot for their teams

No coding experience is required. Use Copilot to generate and explain test code, then check whether the tests cover the intended behavior.

## Prerequisites

- Familiarity with manual testing concepts (test cases, expected vs actual results, bug reports)
- Basic understanding of what automated tests do (you don't need to have written them)
- Comfort with running terminal commands (copy-paste level is fine)
- A browser and the ability to inspect web page elements (right-click > Inspect)

## Technology stack

- **Application Under Test**: .NET 9.0 / ASP.NET Core + .NET Aspire (eShop)
- **Test Framework**: Playwright (TypeScript), with Copilot generating code for scenarios you choose
- **AI Integration**: Playwright MCP Server, GitHub Copilot Chat
- **Environment**: Docker & DevContainers

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-5-qa/`. You will not build an application in this track. Instead, you will test an existing one (eShop) using Copilot as your testing assistant. Browse the running application's pages before writing any instructions or tests.

#### Setup: Target application

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

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- That you are a QA tester working with Playwright and TypeScript
- That the target application is eShop, a .NET Aspire e-commerce reference app
- Your preferred test structure (describe/it blocks, AAA pattern)
- That Copilot should explain generated code
- That test names should describe the user behavior being verified
- Non-negotiable: never report a failure as a bug without checking whether the selector or a wait condition is the actual cause

### Suggested custom agents

- Use a Test Planner Agent to identify important flows, edge cases, and risks for a page or feature before writing tests.
- Use a Playwright Helper Agent to generate tests from a scenario and page structure. It should explain its selectors and assertions in plain language.
- Use a Bug Reporter Agent to draft reproduction steps, expected and actual behavior, and severity from a failing test or error message.

### Suggested custom skills

- A Test Failure Triage Skill checks the error and live-page selector to distinguish bugs from flaky waits or stale selectors. Run it before rewriting a failing test.
- A Selector Discovery Skill finds stable selectors with the browser's Inspect tool and verifies them through Playwright MCP before tests use them.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "playwright test agent", "bug report skill", and "QA instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Describe what you want to test in plain English before asking Copilot to write code. "Test that a user can add an item to the cart and see the total update" produces better results than "write a Playwright test."
- Keep the application's page open alongside VS Code. Use the browser's Inspect tool to find selectors, then paste them into your Copilot prompts.
- When Copilot generates code you don't understand, ask it to explain. Use prompts like "Explain what this test does step by step" or "Why did you use `waitFor` here?"
- If a test fails, paste the error message into Copilot Chat and ask it to diagnose the problem.
- If the Playwright MCP tool fails, check the Output panel in VS Code under "GitHub Copilot MCP" for logs.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)

---

Next: [Stages](challenge-5-qa-track/stages.md)
