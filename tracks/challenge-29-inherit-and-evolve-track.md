# Challenge 29 Track: Inherit and Evolve an Application

**Duration:** 4-6 hours (300-minute target)

**Difficulty:** ⭐⭐⭐

**Focus:** Understanding an unfamiliar C# application, fixing a reported defect
with regression evidence, and adding a small waitlist feature

## Who Is This For

- C# developers taking over an existing application
- Engineers practicing code discovery and review with GitHub Copilot

## Prerequisites

- Comfortable reading C# and writing automated tests
- Basic understanding of HTTP forms and relational data
- GitHub Copilot access in your editor or terminal
- .NET 10 SDK, or VS Code with Dev Containers and Docker

You do not need prior knowledge of this codebase. No Azure subscription,
credentials, or external services are required.

## Technology Stack

- .NET 10 and ASP.NET Core
- Server-rendered Razor UI
- SQLite for local persistence
- xUnit tests
- Docker for an optional local application run

Your team has inherited an equipment-booking application. Employees can browse
equipment and check availability, then make or cancel reservations. A demo
administrator can toggle equipment maintenance.

Operations reports that a cancelled booking sometimes still blocks equipment.
You will investigate that report before adding a waitlist. **The starter runs,
but its passing tests do not cover the reported defect.** No waitlist exists yet.

All identities are synthetic. The employee selector and demo admin controls
provide no real authentication. Keep the application in this local lab.
Authentication work and architecture migration are outside the challenge.

Bookings use whole days with a **start-inclusive, end-exclusive** range. A
booking from October 10 to October 12, 2030 uses October 10 and 11; a booking
starting October 12 does not overlap it. Scenarios must work independently of
the current date.

## Getting Started

Follow the [common setup steps](getting-started.md), with the warning below.

> [!WARNING]
> Setup removes unrelated repository content and resets Copilot customizations.
> Use a disposable clone with a clean worktree. The devcontainer runs setup
> automatically; do not run the clean-start script again after container setup.

### Open and Inspect the Challenge

Work in
[`challenges/challenge-29-inherit-and-evolve/`](../challenges/challenge-29-inherit-and-evolve/).
Use `.devcontainer/challenge-29-inherit-and-evolve/devcontainer.json` when
selecting a devcontainer. It provides .NET 10 and the host Docker CLI, and
forwards port 5080. Keep that forwarded port private. Its post-create step runs
repository setup, then `scripts/validate-starter.sh` to restore, build, and
test the starter. **It does not start the application.**

The solution is `EquipmentBooking.sln`. The web project is
`src/EquipmentBooking.Web/EquipmentBooking.Web.csproj`; tests live under
`tests/EquipmentBooking.Tests/`. Start with the
[baseline stage](challenge-29-inherit-and-evolve-track/stage-1-baseline.md)
for launch commands.

Keep one short working note, wherever your team normally keeps engineering
notes. Add source references during discovery and extend it with the final
change summary. There is no separate report for each stage.

### Repository Instructions for This Track

Author `.github/copilot-instructions.md` from facts you verify in this starter.
Describe the stack, local-only boundary, date-range meaning, and commands used
to check changes. Record the existing project conventions after discovery.
Require evidence for claims about behavior and keep unrelated refactoring out
of the task. Do not record a suspected cause as a fact.

### Suggested Custom Agents

Start with one small agent. The second brief is optional.

- **Discovery Reviewer** -- Takes a workflow map and source references. Use it
  before editing application code to find unsupported claims and missing
  behavior checks. Keep it read-only; it must separate observations from
  hypotheses.
- **Change Reviewer** -- Takes a focused diff and test evidence. Use it after
  the cancellation fix and waitlist work to check preserved behavior. Limit
  its scope to this change rather than a general redesign.

### Suggested Custom Skills

Author the regression-test skill for this session. The second brief is an
optional extension if you find yourself repeating the same manual checks.

- **Regression-Test Skill** -- Takes one reproduced symptom and an expected
  outcome. It should guide a repeatable failing-test-to-passing-test check,
  preserve the evidence, and stop if the failure has another cause. Use it
  for the support ticket and reuse it for waitlist edge cases.
- **Availability Check Skill** -- Takes equipment, fixed date windows, and a
  test database. It should guide repeatable UI and test checks of reservation
  conflicts and maintenance, including cleanup. Keep it local and require
  explicit approval before discarding lab data.

Use the [shared examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
to study authoring patterns. Write your own artifacts; these briefs describe
their job, not their contents.

## Tips for Using Copilot on This Track

- Give Copilot one workflow to trace and require source references.
- Run a claimed behavior yourself before relying on it.
- Keep a failing regression test separate from the production fix.
- Review generated assertions for the behavior they actually prove.
- Add the waitlist through the existing application structure. A framework
  change would consume time without answering the feature request.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-29-inherit-and-evolve-track/stages.md)
