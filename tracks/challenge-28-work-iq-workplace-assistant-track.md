# Challenge 28 Track: Work IQ Workplace Assistant

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Turning approved Microsoft 365 project context into a reviewed
handoff with Microsoft Work IQ and GitHub Copilot CLI

## Who Is This For

- Delivery leads trying to get a straight answer on decisions and follow-up work
- Technical leads who piece together meetings, messages, and documents
- Developers building workplace-aware workflows with GitHub Copilot
- Information governance partners reviewing how workplace data is handled

## Prerequisites

This is a live Microsoft 365 data challenge. A local devcontainer gets the
tools ready, but it cannot provide the tenant access needed to finish it.

- GitHub Copilot CLI access
- Node.js on a supported Windows, Linux, macOS, or WSL environment
- A Microsoft 365 account in a Microsoft Entra tenant enabled for Work IQ
- Access to the emails, meetings, Teams messages, and documents in the selected
  project scope
- A Copilot Studio usage-based billing plan linked to an Azure subscription and
  resource group, with the participant assigned to the plan
- Administrative consent for the Work IQ application in the Microsoft Entra
  tenant
- Browser access to complete Microsoft Entra authentication
- A delivery lead and reviewer who can define the data scope and approve the
  final handoff

Complete the
[preflight checklist](../challenges/challenge-28-work-iq-workplace-assistant/docs/preflight-checklist.md)
before the session. Missing tenant enablement, billing, or consent means the
session should wait for the tenant administrator.

## Technology Stack

- **Microsoft Work IQ** -- permission-aware access to Microsoft 365 context
- **GitHub Copilot CLI** -- the MCP client used to retrieve and reason over
  workplace context
- **Microsoft Entra ID** -- delegated user authentication
- **Microsoft 365** -- the approved project emails, meetings, Teams messages,
  and documents
- **Markdown** -- the reviewed project handoff and action register

## What You Are Building

Pick one project and one recent time range. Retrieve the context that answers a
real delivery question, then turn it into an action register backed by sources.
The handoff captures decisions, follow-up work, risks, dependencies, and what
is still unknown.

Keep the workflow read-only until someone has reviewed the result. Sending a
message, creating a task, changing a document, or updating a calendar comes
later, if the team decides it is worth doing.

## Getting Started

Start with the [common setup steps](getting-started.md). Define the
Customization Trio before connecting Work IQ to project data.

### Open and Inspect the Challenge

Open
[`challenges/challenge-28-work-iq-workplace-assistant/`](../challenges/challenge-28-work-iq-workplace-assistant/).
Read `docs/preflight-checklist.md`. Agree the project scope, time range, where
the output can live, and who reviews it. Then read `docs/workflow-brief.md`
before retrieving data.

A dedicated devcontainer lives at
`.devcontainer/challenge-28-work-iq-workplace-assistant/`. It includes Node.js
and GitHub CLI. It does not grant Microsoft 365 access or handle tenant setup.

Install the supported Work IQ plugin for GitHub Copilot CLI, sign in with
Microsoft Entra ID, and check that the Work IQ MCP server is available before
Stage 1. Use the current Microsoft Learn guidance. Never commit local
authentication or MCP configuration.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- The project boundary, approved time range, and allowed data sources
- The distinction between evidence, inference, and unresolved information
- The approved location and audience for generated handoffs
- The rule that retrieval stays within the signed-in user's existing access
- The rule that every write action needs explicit human approval

The administrator owns tenant-wide policy and access decisions. Keep repository
instructions to stable workflow boundaries. Do not put credentials or personal
data there.

### Suggested Custom Agents

- **Evidence Reviewer Agent** -- Reads a draft handoff and finds claims without
  a source, unsupported owners, invented dates, and blurred lines between facts
  and inferences. Use it after the first retrieval pass.
- **Scope Guardian Agent** -- Compares the retrieval plan with the agreed
  project, time range, sources, and audience. Run it before adding a source.
- **Handoff Editor Agent** -- Turns reviewed evidence into a short action
  register without filling holes with assumptions. Use it after the scope and
  evidence reviews.

### Suggested Custom Skills

- **Scoped Workplace Retrieval Skill** -- Captures the project boundary, time
  range, sources, and intended output before retrieval starts. Run it first.
- **Evidence-to-Action Register Skill** -- Pulls out decisions, actions, risks,
  dependencies, and gaps while keeping the source references. Use it before
  drafting the handoff.
- **Human Approval Gate Skill** -- Checks the audience, evidence, sensitive
  content, and any planned write action. Use it before publishing or changing
  Microsoft 365 data.

Use the shared
[examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own)
to study patterns, then write customizations for this challenge. A generic
workplace prompt or agent is not ready for a production workflow.

## Required Participant Artifacts

By the end of the challenge, the repository should contain:

- A completed preflight record that identifies administrator-owned items
- A documented project scope and time range
- A retrieval plan that names approved Microsoft 365 sources
- An evidence-backed action register
- A short delivery handoff that labels facts, inferences, and gaps
- A review record for the output before any write action

## Tips for Using Copilot on This Track

- Start with one project, a recent time range, and one source. Add another
  source only when you can name the gap it fills.
- Put source references beside the claim they support. A neat summary without
  evidence is difficult to trust.
- Have Copilot flag unknown owners and dates. Do not turn partial context into
  confident-looking assignments.
- The signed-in user's permissions are a boundary. They are not a reason to
  search broadly.
- Stop before writing to Microsoft 365. Review the action register with a
  person first.

## Resources

- [Microsoft Work IQ CLI](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/work-iq-cli)
- [Connect GitHub Copilot CLI to Work IQ](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/work-iq/mcp/quickstart/github-copilot-cli)
- [Work IQ overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/work-iq/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-28-work-iq-workplace-assistant-track/stages.md)
