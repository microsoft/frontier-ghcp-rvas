# Challenge 26 Track: Developer Onboarding Repair

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Repairing developer onboarding documentation by testing reader
tasks, settling audience and terminology decisions, correcting examples
against working software, and adding lightweight editorial checks

## Who Is This For

- Technical writers who maintain developer documentation
- Developer educators who build hands-on onboarding material
- Developer experience practitioners responsible for setup success
- Engineers who review or contribute to onboarding docs

## Prerequisites

- Comfortable editing Markdown and running commands in a terminal
- Basic TypeScript or JavaScript reading skills
- Familiarity with task-oriented documentation
- No prior knowledge of the Launchpad CLI or SDK

## Technology Stack

- **TypeScript and Node.js 22** -- the working CLI and SDK behind the docs
- **Node.js test runner** -- local SDK and command-line tests
- **Markdown** -- the fragmented onboarding content
- **Small Node.js scripts** -- link and command-example validation

## What You Are Repairing

Launchpad is a small developer setup tool with a CLI and SDK. The software
works, but the documentation does not. Pages came from different team wikis
and releases. They disagree about commands, supported runtimes, audience,
terminology, and what the tool changes on a developer's machine.

Your measure of success is reader task completion. A new API or web developer
should be able to choose the right profile, verify the tool, generate a setup
plan, and use the SDK without guessing. This differs from the Living
Documentation challenge, which focuses on generating reference material from
code and release changes. Here, automation supports the editorial work rather
than defining it.

## Getting Started

Follow the [common setup steps](getting-started.md) first. Draft the
Customization Trio before you begin the first reader test.

### Open and Inspect the Challenge

Navigate to
[`challenges/challenge-26-developer-onboarding/`](../challenges/challenge-26-developer-onboarding/).
Start at `docs/index.md`, but do not assume it points to everything useful.
Run the code tests before changing documentation so you can separate software
behavior from documentation defects.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should establish:

- The primary audiences and the tasks the repaired docs must support
- The source-of-truth order when docs, tests, and implementation disagree
- The chosen terms for profiles, setup plans, shells, and audiences
- The project's Markdown style and example-testing conventions
- A rule that commands and API examples must be verified before publication

Describe stable decisions only. Stage-specific requests belong in your work
notes, not repository instructions.

### Suggested Custom Agents

- **Onboarding Reader Agent** -- Reviews a journey from one named audience's
  perspective and reports blockers, assumptions, and missing context. Give it
  a page sequence, not the whole repository. Use it during Stages 1 and 3.
- **Technical Accuracy Reviewer Agent** -- Compares documentation claims with
  CLI help, SDK exports, and tests. It reports discrepancies and evidence
  without rewriting every page. Use it before accepting repaired examples.
- **Information Architecture Reviewer Agent** -- Checks page purpose,
  navigation, progressive disclosure, and duplicate content. Give it the
  proposed audience/task map and page tree during Stage 2.

### Suggested Custom Skills

- **Onboarding Test Skill** -- A repeatable clean-room pass that records the
  reader goal, starting page, commands attempted, observed result, and blocker.
  Use the same pass before and after the repair.
- **Example Verification Skill** -- A fixed workflow for building the project,
  running a documented command or SDK sample, and recording the checked
  version. Use it whenever an example changes.
- **Editorial Release Skill** -- A short publication check covering links,
  examples, terminology, ownership, and review dates. Use it in Stage 4.

Use the shared
[examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
to study patterns, then author customizations for this challenge. Do not copy
a generic documentation agent and treat it as complete.

## Required Participant Artifacts

By the end of the challenge, the repository should contain:

- An audience and task map
- A prioritized documentation issue inventory with evidence
- A tested quickstart and one task tutorial
- Corrected CLI and SDK reference pages
- Recorded style and terminology decisions
- Automated local link and example checks
- An editorial maintenance workflow with owners and review triggers

## Tips for Using Copilot on This Track

- Give Copilot a reader, goal, starting page, and evidence. "Improve these
  docs" is too vague to produce a useful review.
- Ask for discrepancies before asking for rewrites. You need the inventory
  before you decide page boundaries.
- Treat CLI help, exported SDK types, and passing tests as evidence, not as a
  substitute for reader context.
- Run examples yourself. Plausible command syntax is one of the easiest
  documentation errors to miss.
- Keep reference concise. Move explanations and decisions into the quickstart,
  tutorial, or concepts material when they interrupt lookup tasks.
- Record terminology choices once and apply them consistently rather than
  asking Copilot to choose again on every page.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)

---

Next: [Stages](challenge-26-developer-onboarding-track/stages.md)
