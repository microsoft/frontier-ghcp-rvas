# Challenge 22 Track: Secure Release Review

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Reviewing and hardening a .NET 8 release candidate across trust
boundaries, authorization, input handling, configuration, dependencies, and
security logging

## Who Is This For

- Application security engineers reviewing code before release
- Senior .NET developers responsible for security-sensitive APIs
- Technical leads who need defensible go or no-go criteria
- DevOps and platform engineers who support dependency and secret controls

## Prerequisites

- Comfortable reading C# and .NET Minimal API code
- Familiarity with HTTP authentication and authorization concepts
- Basic experience with automated tests and package management
- Ability to separate release blockers from risks that can be tracked

## Technology Stack

- .NET 8 and ASP.NET Core Minimal APIs
- xUnit and `WebApplicationFactory`
- Local in-memory data
- .NET package audit commands
- Markdown review artifacts

The starter is a local payments API with identity, payment, and admin
endpoints. Its data and tokens are synthetic. Several security decisions are
deliberately weak, but the challenge does not require destructive testing or
exploit automation.

## Getting Started

Follow the [common setup steps](getting-started.md) first, then continue below.

### Open and Inspect the Challenge

Work in
[`challenges/challenge-22-secure-release/`](../challenges/challenge-22-secure-release/).
Start with `docs/release-brief.md`, then read the API and existing
characterization tests. Run the application and tests before changing code.

Use `.devcontainer/challenge-22-secure-release/` for a .NET 8 environment. The
challenge is local-first. It needs no Azure subscription or credentials.

Create these participant artifacts under `deliverables/`:

- `threat-model.md`
- `prioritized-findings.md`
- `remediation-and-tests.md`
- `dependency-and-secret-review.md`
- `residual-risk.md`
- `secure-release-checklist.md`

The documents should point to code, tests, commands, or captured output. A list
of generic security advice is not enough.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should describe the API's trust model,
data sensitivity, supported roles, release constraints, and test conventions.
State that all testing stays local, demo values must never be replaced with
real credentials, and generated changes need evidence before they are accepted.
Also define how your team labels release blockers and residual risks.

### Suggested Custom Agents

- **Threat Model Reviewer** -- Takes the endpoint inventory, data flows, and
  proposed trust boundaries. It challenges missing actors, assets, abuse cases,
  and assumptions. Use it after the first code walk, not as a source of a
  finished threat model.
- **Authorization Reviewer** -- Takes a focused endpoint or policy change and
  checks identity, role, resource ownership, and denial behavior. Use it before
  accepting auth changes. Keep it scoped to review rather than broad rewrites.
- **Release Evidence Reviewer** -- Takes findings, test output, package evidence,
  and the draft checklist. It finds unsupported conclusions and unclear release
  gates. Use it in the final stage.

### Suggested Custom Skills

- **Endpoint Security Review Skill** -- A repeatable pass from route inventory
  through actor, authentication, authorization, input, output, and logging
  checks. It should produce evidence references, not generic advice.
- **Security Regression Skill** -- A workflow for turning one confirmed finding
  into a failing test, a narrow remediation, and passing regression evidence.
  It should stop when the behavior is not reproducible.
- **Release Decision Skill** -- A workflow that sorts findings by severity and
  confidence, checks remediation evidence, records residual risk, and produces a
  clear release recommendation.

Use the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
to study similar artifacts, then write versions that fit this challenge.

## Tips for Using Copilot on This Track

- Ask for an endpoint and trust-boundary inventory before asking for fixes.
- Keep review prompts narrow enough that you can verify every claim in code.
- Make Copilot distinguish authentication, role authorization, and
  resource-level authorization.
- Turn a finding into a failing test before accepting a remediation.
- Ask for the smallest safe code change, then inspect behavior at the boundary.
- Treat package audit output as evidence to interpret, not an automatic verdict.
- Check logs for both missing context and excess sensitive data.
- Make the final reviewer trace every release gate to a finding, test, or
  explicit risk acceptance.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)

---

Next: [Stages](challenge-22-secure-release-track/stages.md)
