# Challenge 30 Track: Spec-Driven Feature Delivery with GitHub Spec Kit

**Duration:** 4-6 hours (five-hour core)

**Difficulty:** ⭐⭐

**Focus:** Using GitHub Spec Kit with Copilot CLI to implement an approval
feature, then keep its specification useful when the rules change

## Who Is This For

- Developers who want to try spec-driven development on an existing application
- Tech leads evaluating a shared requirements-to-code workflow
- QA engineers comfortable reading TypeScript and running automated tests

## Prerequisites

- Familiarity with TypeScript, HTTP APIs, and automated tests
- GitHub Copilot access, including permission to use Copilot CLI
- Git and a terminal; use the devcontainer on Windows
- For native Linux or macOS setup: Bash 4+, Node.js 22, and Python 3.12 with `venv`

The app needs no Azure subscription or external service. Tool installation and
Copilot require network access. Do not use real employee or customer data.

## Technology Stack

- Node.js 22, TypeScript, and Express
- Plain HTML, CSS, and JavaScript
- Node's test runner and Playwright
- GitHub Spec Kit 1.0.9 and GitHub Copilot CLI 1.0.88-1

Your team owns a small service-request application. Employees can create drafts
and submit them. The UI works and the baseline tests pass. **There is no
approval feature yet.**

You will turn an incomplete request into a reviewed specification, implement it,
and respond to a rule change. Keep the same feature specification current as
the code evolves. Challenge 17 focuses on authoring custom delivery workflows;
this track uses Spec Kit's supplied workflow.

## Getting Started

Read the [shared setup guidance](getting-started.md), then follow Stage 1.
**This track is an exception to the required custom-agent and custom-skill
authoring exercises.** Use the Spec Kit skills rather than rebuilding them.

> [!WARNING]
> First-time setup removes unrelated repository content and resets Copilot
> customizations. Use a disposable clone with a clean worktree. Do not run
> `clean-start` or the shared setup script again after initializing Spec Kit.

### Open and Inspect the Challenge

The starter is in
[`challenges/challenge-30-spec-driven/`](../challenges/challenge-30-spec-driven/).
Select `.devcontainer/challenge-30-spec-driven/devcontainer.json`. Its setup
installs the pinned tools and runs baseline checks. It does not start the app,
sign in to Copilot, or initialize Spec Kit.

Start Copilot and initialize Spec Kit at the **repository root**, not inside
the starter folder. Run application commands with the explicit path shown in
Stage 1. This keeps generated `.specify/`, `.github/skills/`, and `specs/`
artifacts in one place.

The store is in memory. Restarting the server resets the demo data. The identity
selector is not authentication: anyone can choose any demo user. Keep the app
local and forwarded port 5080 private. Real authentication and durable storage
are outside this challenge.

### Repository Instructions for This Track

Write only the project context Copilot needs: application location, build and
test commands, and local-only boundaries. Derive conventions from the code.
Use the Spec Kit constitution for agreed engineering principles. Refer to those
principles rather than maintaining a second copy in repository instructions.

### Suggested Custom Agents

These are optional. Use Spec Kit first.

- **Acceptance Reviewer** -- Reviews the feature specification against the
  stakeholder brief before planning. It should identify untestable claims and
  missing decisions, without deciding business policy for you.
- **Change Reviewer** -- Reviews the code and specification diff after the rule
  change. It should find behavior that no longer matches the agreed criteria,
  without expanding the feature.

### Suggested Custom Skills

The installed `speckit-*` skills handle the required workflow. Do not rewrite
them. If you finish the core work, consider one complementary skill:

- **Acceptance Evidence** -- Takes the current acceptance scenarios and
  checks them against executed tests. Reuse it after the rule change; require
  it to distinguish untested claims from passing evidence.
- **Local Demo Reset** -- Stops the known local app process, restarts the demo,
  and checks its seeded requests. It must warn that restart discards local
  changes and never terminate unrelated processes.

Use the [shared examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
only if you choose an optional customization. No finished definitions are
provided.

## Tips for Using Copilot on This Track

- Invoke each Spec Kit skill separately in Copilot CLI. The `/speckit-*`
  names are agent skills, not shell commands.
- Inspect the generated specification before moving to planning. An unanswered
  policy question is not permission for the model to choose silently.
- Ask for tests while deriving tasks. Do not assume generated tasks include
  the acceptance evidence you need.
- Review the plan against the existing app. A new framework is outside scope.
- Treat convergence as a review aid. Run the tests and exercise the UI yourself.

## Resources

- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [Spec Kit 1.0.9 release](https://github.com/github/spec-kit/releases/tag/v1.0.9)
- [Copilot integration and invocation syntax](https://github.github.io/spec-kit/reference/integrations.html)
- [Adopting Spec Kit in existing code](https://github.github.io/spec-kit/guides/existing-projects.html)
- [Evolving specifications](https://github.github.io/spec-kit/guides/evolving-specs.html)
- [Copilot Guide](../docs/copilot-guide.md)

The track uses the pinned versions above. Upstream documentation can change;
check the installed skills before copying command syntax from another version.

---

Next: [Stages](challenge-30-spec-driven-track/stages.md)
