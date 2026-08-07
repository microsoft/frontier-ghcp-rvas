# Challenge 15 Track: Backlog Generator

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐

**Focus:** Automating the conversion of requirement specifications into structured project backlogs using Copilot prompts, agents, and the Atlassian MCP server

## Who Is This For

- Product owners and tech leads who spend hours manually creating backlogs from requirement documents
- Scrum masters and project managers who want consistent, high-quality backlog items across teams
- Anyone involved in sprint planning who converts use case documents into Epics, Stories, and Tasks
- Teams that use Jira and Confluence and want to integrate Copilot with those tools

## Prerequisites

- Understanding of agile concepts: Epics, User Stories, Acceptance Criteria, Tasks
- Familiarity with the INVEST criteria for good user stories
- No coding experience required -- this track focuses on prompts, agents, and process
- Atlassian Cloud account (optional, for MCP integration stages)

## Technology Stack

- **Source material:** Use case specification documents (markdown, simulating Confluence pages)
- **Copilot features:** Custom prompts, custom agents, Copilot chat
- **MCP integration:** Atlassian Rovo MCP server (Jira + Confluence access)
- **Output format:** Structured markdown, optionally pushed to Jira

## What You Are Working With

The `specs/` directory contains three use case specifications of increasing complexity:

1. **Password Reset** -- A straightforward flow with clear actors, preconditions, and alternative paths
2. **Notification Preferences** -- Moderate complexity with a configuration matrix, compliance rules (GDPR), and multiple integration points
3. **Inventory Reorder** -- Complex, with scheduled jobs, external system integrations, business formulas (EOQ), and multi-level approval workflows

These specs are structured like the Confluence pages your team already works with. The challenge is to build Copilot-based tooling that turns these specs into structured, consistent backlogs.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-15-backlog-generator/`. Read the [system context](../challenges/challenge-15-backlog-generator/docs/system-context.md) first, then explore the `specs/` directory before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-15-backlog-generator/` with Node.js LTS (for MCP server tooling).

#### Atlassian MCP Server (Optional)

If your team uses Atlassian Cloud (Jira / Confluence), you can connect Copilot to it via the Atlassian Rovo MCP Server. See the [MCP Servers Guide](../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira-confluence) for setup instructions. This enables Stage 3 of the challenge, where you push generated backlog items directly to Jira.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are building automation for converting requirement specs into structured project backlogs
- Your team's backlog conventions (Epic naming, Story format, Acceptance Criteria style)
- The INVEST criteria and how your team applies them
- Your definition of "done" for user stories and tasks
- Non-negotiable: never push generated items to Jira without a human reviewing them first

### Suggested Custom Agents

- **Backlog Architect Agent** -- Takes a use case specification and produces a structured backlog: Epics, Stories with Given/When/Then acceptance criteria, Tasks, and Test Cases following INVEST and your team's conventions. Give it a spec; it drafts the backlog. Use it as the first pass on any new spec.
- **Refinement Analyst Agent** -- Reviews a generated backlog against the original spec and flags missing requirements, ambiguous criteria, undiscovered dependencies, and uncovered edge cases. Give it the spec and the draft backlog together; it returns gaps. Use it after the Architect agent, before anyone estimates.
- **Estimation Guide Agent** -- Suggests relative sizing (S/M/L/XL) based on complexity indicators: integrations, data model changes, UI interactions, and business rule complexity. Give it the refined backlog; it proposes sizes with reasoning. Use it once stories are stable, not on a first draft.

### Suggested Custom Skills

- **Spec-to-Backlog Conversion Skill** -- A fixed sequence: read a use case spec, extract actors, preconditions, and alternate paths, and generate Epics/Stories/Tasks in the team's standard format, run consistently across specs of any complexity.
- **Jira Push Skill** -- A repeatable workflow via the Atlassian Rovo MCP server: read a Confluence page, map its content to Jira issue fields, create one issue as a dry run, then push the rest once the mapping is verified.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "backlog generation agent", "jira automation skill", and "agile instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Start with the simplest spec (Password Reset) to build your prompt, then test it on the complex ones. If it works on Inventory Reorder, it works on everything.
- When writing the backlog prompt, be explicit about output format. Include an example of what a well-formed Epic, Story, and Task look like for your team.
- The refinement agent works best when you give it both the original spec and the generated backlog, then ask it to find gaps. Use `#file` references to point at both documents.
- For the MCP integration, start by reading a Confluence page and creating a single Jira issue before attempting bulk creation.
- Test your prompt consistency by having multiple team members run the same spec through the same prompt and comparing outputs.

## Resources

- [Atlassian Rovo MCP Server](../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira-confluence)
- [INVEST Criteria for User Stories](https://www.agilealliance.org/glossary/invest/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-15-backlog-generator-track/stages.md)
