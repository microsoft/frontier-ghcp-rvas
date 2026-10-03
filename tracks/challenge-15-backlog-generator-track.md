# Challenge 15 Track: Backlog Generator

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐

**Focus:** Automating the conversion of requirement specifications into structured project backlogs using Copilot skills, agents, and the Atlassian MCP server

## Who is this for

- Product owners and tech leads who spend hours manually creating backlogs from requirement documents
- Scrum masters and project managers who want consistent, high-quality backlog items across teams
- Anyone involved in sprint planning who converts use case documents into Epics, Stories, and Tasks
- Teams that use Jira and Confluence and want to integrate Copilot with those tools

## Prerequisites

- Understanding of agile concepts: Epics, User Stories, Acceptance Criteria, Tasks
- Familiarity with the INVEST criteria for good user stories
- No coding experience required; use Copilot skills and agents to build backlog workflows
- Atlassian Cloud account (optional, for MCP integration stages)

## Technology stack

- **Source material:** Use case specification documents (markdown, simulating Confluence pages)
- **Copilot features:** Custom skills, custom agents, Copilot chat
- **MCP integration:** Atlassian Rovo MCP server (Jira + Confluence access)
- **Output format:** Structured markdown, optionally pushed to Jira

## What you are working with

The `specs/` directory contains three use case specifications of increasing complexity:

1. **Password Reset** -- A straightforward flow with clear actors, preconditions, and alternative paths
2. **Notification Preferences** -- Moderate complexity with a configuration matrix, compliance rules (GDPR), and multiple integration points
3. **Inventory Reorder** -- Complex, with scheduled jobs, external system integrations, business formulas (EOQ), and multi-level approval workflows

Build Copilot workflows that convert these Confluence-style specs into backlogs in your team's format.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-15-backlog-generator/`. Read the [system context](../challenges/challenge-15-backlog-generator/docs/system-context.md) first, then explore the `specs/` directory before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-15-backlog-generator/` with Node.js LTS (for MCP server tooling).

#### Atlassian MCP Server (optional)

If your team uses Atlassian Cloud (Jira / Confluence), you can connect Copilot to it via the Atlassian Rovo MCP Server. See the [MCP Servers Guide](../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira-confluence) for setup instructions. This enables Stage 3 of the challenge, where you push generated backlog items directly to Jira.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should include:

- That you are building automation for converting requirement specs into structured project backlogs
- Your team's backlog conventions (Epic naming, Story format, Acceptance Criteria style)
- The INVEST criteria and how your team applies them
- Your definition of "done" for user stories and tasks
- Non-negotiable: never push generated items to Jira without a human reviewing them first

### Suggested custom agents

- Use a Backlog Architect Agent to draft Epics, Stories with Given/When/Then acceptance criteria, Tasks, and Test Cases from a spec, following INVEST and team conventions.
- Use a Refinement Analyst Agent to compare the draft with the spec and flag missing requirements, ambiguity, dependencies, and uncovered edge cases before estimation.
- Use an Estimation Guide Agent to propose S/M/L/XL sizes for stable stories based on integrations, data changes, UI interactions, and business rules.

### Suggested custom skills

- A Spec-to-Backlog Conversion Skill generates Epics, Stories, and Tasks from a spec's actors, preconditions, and alternate paths in the team's format.
- A Jira Push Skill maps a reviewed backlog to Jira and creates linked items in dependency order through Atlassian Rovo MCP. In Stage 3, require human approval of the target project and mapping. Record issue references and failed writes before retrying. Confluence is an optional source.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "backlog generation agent", "jira automation skill", and "agile instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Start with the simplest spec (Password Reset) to build your skill, then test it on the more complex specs. Check coverage each time.
- Define the backlog skill's output format using your team's work item conventions and the provided backlog templates.
- The refinement agent works best when you give it both the original spec and the generated backlog, then ask it to find gaps. Use `#file` references to point at both documents.
- For the MCP integration, verify the field mapping with a single approved Jira issue before attempting bulk creation.
- Test consistency by having multiple team members use the same skill on the same spec and compare outputs.

## Resources

- [Atlassian Rovo MCP Server](../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira-confluence)
- [INVEST Criteria for User Stories](https://www.agilealliance.org/glossary/invest/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-15-backlog-generator-track/stages.md)
