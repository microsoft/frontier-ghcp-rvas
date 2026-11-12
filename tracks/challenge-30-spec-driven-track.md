# Challenge 30 track: Spec-driven feature delivery with GitHub Spec Kit

**Duration:** 4-6 hours (five-hour core)

**Difficulty:** ⭐⭐

**Focus:** Use GitHub Spec Kit with Copilot CLI to implement an approval
feature and update its specification when the rules change

## Prerequisites

- Familiarity with TypeScript, HTTP APIs, and automated tests
- GitHub Copilot access, including permission to use Copilot CLI
- Git and a terminal; use the devcontainer on Windows
- For native Linux or macOS setup: Bash 4+, Node.js 22, and Python 3.12 with `venv`

The app needs no Azure subscription or external service. Tool installation and
Copilot need network access. Don't use real employee or customer data.

## Technology stack

- Node.js 22, TypeScript, and Express
- Plain HTML, CSS, and JavaScript
- Node's test runner and Playwright
- GitHub Spec Kit 1.0.9 and GitHub Copilot CLI 1.0.88-1
- Impeccable for reviewing the changed approval state in the existing UI

Your team owns a small service-request application. Employees can create drafts
and submit them. The UI works and the baseline tests pass. **There is no
approval feature yet.**

You will turn an incomplete request into a reviewed specification, implement it,
and respond to a rule change, keeping the same feature specification current as
the code changes. Challenge 17 covers authoring custom delivery workflows; this
track uses Spec Kit's own workflow.

## Getting started

Read the [shared setup guidance](getting-started.md), then follow Stage 1.
**This track doesn't require authoring custom agents or skills.** Use the Spec
Kit skills instead of rebuilding them.

> [!WARNING]
> First-time setup removes unrelated repository content and resets Copilot
> customizations. Use a disposable clone with a clean worktree. After
> initializing Spec Kit, don't run `clean-start` or the shared setup script
> again.

### Open and inspect the challenge

The starter is in
[`challenges/challenge-30-spec-driven/`](../challenges/challenge-30-spec-driven/).
Select `.devcontainer/challenge-30-spec-driven/devcontainer.json`. Its setup
installs the pinned tools and runs baseline checks. It does not start the app,
sign in to Copilot, or initialize Spec Kit.

Start Copilot and initialize Spec Kit at the **repository root**, not inside
the starter folder, so the generated `.specify/`, `.github/skills/`, and
`specs/` artifacts stay in one place. Run application commands with the
explicit path shown in Stage 1.

The store is in memory, so restarting the server resets the demo data. Anyone
can choose any demo user; the identity selector provides no authentication.
Keep the app local and forwarded port 5080 private. Real authentication and
durable storage are out of scope.

### Install and use Impeccable

After clean setup and Spec Kit initialization, follow the
[shared manual installation and discovery checks](getting-started.md#5-install-impeccable-when-your-track-uses-it).
Preflight `public/index.html`. In Stage 5, review only the intermediate approval
state in the existing UI. **One approval out of two must remain visibly pending.**
Record accepted requirements in the existing feature specification and browser
tests. Spec Kit owns the delivery workflow: don't start a separate design
workflow or change the frontend framework.

### Repository instructions for this track

Write only the project context Copilot needs: application location, build and
test commands, and local-only boundaries. Conventions come from the code.
Engineering principles go in the Spec Kit constitution; don't duplicate them
in repository instructions.

### Suggested custom agents

These are optional. Use Spec Kit first.

- **Acceptance Reviewer** -- Reviews the feature specification against the
  stakeholder brief before planning. It should identify untestable claims and
  missing decisions, without deciding business policy for you.
- **Change Reviewer** -- Reviews the code and specification diff after the rule
  change. It should find behavior that no longer matches the agreed criteria,
  without expanding the feature.

### Suggested custom skills

The installed `speckit-*` skills cover the required workflow; don't rewrite
them. If you finish the core work, try one complementary skill:

- **Acceptance Evidence** -- Takes the current acceptance scenarios and
  checks them against executed tests. Reuse it after the rule change; require
  it to distinguish untested claims from passing evidence.
- **Local Demo Reset** -- Stops the known local app process, restarts the demo,
  and checks its seeded requests. It must warn that restart discards local
  changes and never terminate unrelated processes.

If you build an optional customization, see the
[shared examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own).
No finished definitions are provided.

## Tips for using Copilot on this track

- Invoke each Spec Kit skill separately in Copilot CLI. The `/speckit-*`
  names are agent skills, not shell commands.
- Inspect the generated specification before planning. If a policy question is
  unanswered, don't let the model choose silently.
- Ask for tests when you derive tasks. Generated tasks may not include the
  acceptance evidence you need.
- Review the plan against the existing app. A new framework is out of scope.
- Convergence is a review aid. Run the tests and exercise the UI yourself.

## Resources

- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [Spec Kit 1.0.9 release](https://github.com/github/spec-kit/releases/tag/v1.0.9)
- [Copilot integration and invocation syntax](https://github.github.io/spec-kit/reference/integrations.html)
- [Adopting Spec Kit in existing code](https://github.github.io/spec-kit/guides/existing-projects.html)
- [Evolving specifications](https://github.github.io/spec-kit/guides/evolving-specs.html)

The track pins the versions above. Upstream docs may describe other versions,
so check the installed skills before copying command syntax.

---

Next: [Stages](challenge-30-spec-driven-track/stages.md)
