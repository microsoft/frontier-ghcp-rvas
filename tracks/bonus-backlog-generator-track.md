# Bonus Track: Backlog Generator

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
- Atlassian Cloud account (optional, for MCP integration phases)

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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are building automation for converting requirement specs into structured project backlogs
- Your team's backlog conventions (Epic naming, Story format, Acceptance Criteria style)
- The INVEST criteria and how your team applies them
- Your definition of "done" for user stories and tasks

### Suggested Agents

- **Backlog Architect Agent** -- Takes a use case specification and produces a structured backlog: Epics, User Stories with Acceptance Criteria (Given/When/Then format), Technical Tasks, and Test Cases. Follows the INVEST criteria and your team's conventions.
- **Refinement Analyst Agent** -- Reviews a generated backlog against the original spec and identifies: missing requirements, ambiguous acceptance criteria, undiscovered dependencies, and edge cases not covered by any story.
- **Estimation Guide Agent** -- Analyzes generated stories and suggests relative sizing (S/M/L/XL) based on complexity indicators: number of integrations, data model changes, UI interactions, and business rule complexity.

### Open the Challenge

Navigate to `challenges/bonus-9-backlog-generator/`. Read the [system context](../challenges/bonus-9-backlog-generator/docs/system-context.md) first, then explore the `specs/` directory.

A dedicated devcontainer is provided at `.devcontainer/bonus-9-backlog-generator/` with Node.js LTS (for MCP server tooling).

### Atlassian MCP Server (Optional)

If your team uses Atlassian Cloud (Jira / Confluence), you can connect Copilot to it via the Atlassian Rovo MCP Server. See the [MCP Servers Guide](../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira--confluence) for setup instructions. This enables Phase 3 of the challenge, where you push generated backlog items directly to Jira.

---

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Spec-to-Backlog Prompt](bonus-backlog-generator-track/phase-1-prompt.md) | 2-2.5 hours | Build and refine a prompt that converts specs into structured backlogs |
| 2 | [Refinement Agent](bonus-backlog-generator-track/phase-2-refinement.md) | 1.5-2 hours | Build an agent that reviews generated backlogs for gaps and inconsistencies |
| 3 | [MCP Integration](bonus-backlog-generator-track/phase-3-mcp.md) | 1.5-2 hours | Push generated items to Jira using the Atlassian MCP server |
| 4 | [Consistency Benchmark](bonus-backlog-generator-track/phase-4-benchmark.md) | 1-1.5 hours | Process all 3 specs and compare output consistency |

Phases 1 and 2 are the core. Phase 3 requires an Atlassian Cloud account. Phase 4 is a validation exercise that tests your prompts on all three specs.

> **Short on time?** Focus on Phases 1 and 2 with just the Password Reset spec. A working spec-to-backlog prompt and a refinement agent are the most valuable deliverables.

## Tips for Using Copilot on This Track

- Start with the simplest spec (Password Reset) to build your prompt, then test it on the complex ones. If it works on Inventory Reorder, it works on everything.
- When writing the backlog prompt, be explicit about output format. Include an example of what a well-formed Epic, Story, and Task look like for your team.
- The refinement agent works best when you give it both the original spec and the generated backlog, then ask it to find gaps. Use `#file` references to point at both documents.
- For the MCP integration, start by reading a Confluence page and creating a single Jira issue before attempting bulk creation.
- Test your prompt consistency by having multiple team members run the same spec through the same prompt and comparing outputs.

## Resources

- [Atlassian Rovo MCP Server](../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira--confluence)
- [INVEST Criteria for User Stories](https://www.agilealliance.org/glossary/invest/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
