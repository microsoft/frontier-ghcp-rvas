# Challenge 29 track: Inherit and evolve an application

**Duration:** 4-6 hours (300-minute target)

**Difficulty:** ⭐⭐⭐

**Focus:** Learn an unfamiliar C# application, fix a reported defect with
regression evidence, and add a small waitlist feature

## Prerequisites

- Comfortable reading C# and writing automated tests
- Basic understanding of HTTP forms and relational data
- GitHub Copilot access in your editor or terminal
- .NET 10 SDK and Node.js with npm, or VS Code with Dev Containers and Docker

You don't need to know the codebase. No Azure subscription, credentials, or
external services are required.

## Technology stack

- .NET 10 and ASP.NET Core
- Server-rendered Razor UI
- SQLite for local persistence
- xUnit tests
- Docker for an optional local application run
- Impeccable for a focused review of the new waitlist UI

Your team has inherited an equipment-booking application. Employees can browse
equipment and check availability, then make or cancel reservations. A demo
administrator can toggle equipment maintenance.

Operations reports that a cancelled booking sometimes still blocks equipment.
You will investigate that report, then add a waitlist. **The starter runs, but
its passing tests don't cover the defect.** No waitlist exists yet.

All identities are synthetic. The employee selector and demo admin controls
provide no real authentication, so keep the application local. Authentication
and architecture migration are out of scope.

Bookings use whole days with a **start-inclusive, end-exclusive** range. A
booking from October 10 to October 12, 2030 uses October 10 and 11; a booking
starting October 12 does not overlap it. Scenarios must work independently of
the current date.

## Getting started

Follow the [common setup steps](getting-started.md), and read the warning below.

> [!WARNING]
> Setup removes unrelated repository content and resets Copilot customizations.
> Use a disposable clone with a clean worktree. The devcontainer runs setup
> automatically, so don't run the clean-start script again afterwards.

### Open and inspect the challenge

Work in
[`challenges/challenge-29-inherit-and-evolve/`](../challenges/challenge-29-inherit-and-evolve/).
Use `.devcontainer/challenge-29-inherit-and-evolve/devcontainer.json` when
selecting a devcontainer. It provides .NET 10 and the host Docker CLI. Node.js 22
runs the skill installer. Port 5080 is forwarded; keep it private. The
post-create step runs repository setup, then `scripts/validate-starter.sh` to
restore, build, and test the starter. **It does not start the application.**

The solution is `EquipmentBooking.sln`. The web project is
`src/EquipmentBooking.Web/EquipmentBooking.Web.csproj`; tests live under
`tests/EquipmentBooking.Tests/`. Start with the
[baseline stage](challenge-29-inherit-and-evolve-track/stage-1-baseline.md)
for launch commands.

Keep one short working note wherever your team keeps engineering notes. Add
source references during discovery and the change summary at the end. There is
no per-stage report.

### Install and use Impeccable

Follow the [shared manual installation and discovery checks](getting-started.md#5-install-impeccable-when-your-track-uses-it).
Preflight `src/EquipmentBooking.Web/Pages/Index.cshtml`. In Stage 4, review only
the new waitlist flow, after it works. Keep Razor and the existing visual
style. Make pending and confirmed states distinct, and explain blocked admin
confirmation. Date rules and eligibility belong in the application's tests.

### Repository instructions for this track

Write `.github/copilot-instructions.md` from facts you verify in this starter.
Cover the stack, the local-only boundary, what the date range means, and the
commands that check changes. Add the project conventions after discovery.
Require evidence for claims about behavior, keep unrelated refactoring out, and
don't record a suspected cause as fact.

### Suggested custom agents

Start with one small agent. The second brief is optional.

- **Discovery Reviewer** -- Takes a workflow map and source references. Use it
  before editing application code to find unsupported claims and missing
  behavior checks. Keep it read-only; it must separate observations from
  hypotheses.
- **Change Reviewer** -- Takes a focused diff and test evidence. Use it after
  the cancellation fix and the waitlist to check that existing behavior still
  works. Limit it to this change, not a general redesign.

### Suggested custom skills

Write the regression-test skill. The second is optional, for when you repeat
the same manual checks.

- **Regression-Test Skill** -- Takes one reproduced symptom and an expected
  outcome. It should guide a repeatable failing-test-to-passing-test check,
  preserve the evidence, and stop if the failure has another cause. Use it
  for the support ticket and reuse it for waitlist edge cases.
- **Availability Check Skill** -- Takes equipment, fixed date windows, and a
  test database. It should guide repeatable UI and test checks of reservation
  conflicts and maintenance, including cleanup. Keep it local and require
  explicit approval before discarding lab data.

See the [shared examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
for authoring patterns. Write your own artifacts; the briefs above describe the
job, not the contents.

## Tips for using Copilot on this track

- Give Copilot one workflow to trace and require source references.
- Run a claimed behavior yourself before relying on it.
- Keep a failing regression test separate from the production fix.
- Review generated assertions for the behavior they actually prove.
- Add the waitlist within the existing structure. A framework change won't
  answer the feature request.

## Resources

- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-29-inherit-and-evolve-track/stages.md)
