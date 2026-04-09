# Backlog Generator -- System Context

This challenge simulates the real-world pain of converting requirement documents into structured project backlogs. The `specs/` directory contains three use case specifications written in the style of Confluence wiki pages.

## What You Have

Three use case specifications of increasing complexity:

1. **Password Reset** (`uc-password-reset.md`) -- Straightforward CRUD-style use case with clear flows
2. **Notification Preferences** (`uc-notification-preferences.md`) -- Moderate complexity with a preference matrix, compliance rules, and multiple channels
3. **Inventory Reorder** (`uc-inventory-reorder.md`) -- Complex, with scheduled jobs, external integrations, business formulas, and approval workflows

## The Problem

Today, a product owner or tech lead reads each spec and manually creates:

- **Epics** grouping related functionality
- **User Stories** with acceptance criteria
- **Technical Tasks** under each story
- **Test Cases** for QA

This manual process takes hours per spec. Different people produce different structures for the same spec. Acceptance criteria vary in quality and completeness. Dependencies get missed. The result is inconsistent, slow, and frustrating.

## What You Will Build

Copilot-based automation that turns a spec document into a structured backlog, using:

- Custom prompts (`.github/prompts/`) for the conversion rules
- Custom agents (`.github/agents/`) for refinement and gap analysis
- Optionally, the Atlassian Rovo MCP server to push items directly to Jira

The `templates/` directory contains example formats for the output backlog items if you want a starting point.
