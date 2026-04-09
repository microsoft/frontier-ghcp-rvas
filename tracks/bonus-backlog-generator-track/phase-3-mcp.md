# Phase 3: MCP Integration

[Back to Backlog Generator Track](../bonus-backlog-generator-track.md)

**Duration:** 1.5-2 hours

**Focus:** Pushing generated backlog items to Jira using the Atlassian Rovo MCP server

> This phase requires an Atlassian Cloud account with Jira access. If you do not have one, skip to Phase 4.

## Tasks

1. **Set up the Atlassian MCP server.** Follow the instructions in the [MCP Servers Guide](../../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira--confluence) to configure the Atlassian Rovo MCP server in your `.vscode/mcp.json`. Complete the OAuth authentication flow.

2. **Explore the available tools.** In Agent mode, ask Copilot what Atlassian MCP tools are available. Familiarize yourself with the tools for creating Jira issues, searching issues, and reading Confluence pages.

3. **Create a single issue manually.** Use Copilot in Agent mode to create one Jira Issue (a User Story) from your generated backlog. Verify it appears correctly in Jira with the right fields.

4. **Create an Epic with linked Stories.** Use Copilot to:
   - Create a Jira Epic
   - Create multiple Stories under that Epic
   - Set the correct issue type, summary, description, and acceptance criteria

5. **Build a bulk creation prompt.** Create `.github/prompts/push-backlog-to-jira.prompt.md` that:
   - Takes your generated backlog as input
   - Instructs Copilot (in Agent mode with MCP) to create all items in Jira
   - Creates Epics first, then Stories linked to Epics, then Tasks linked to Stories
   - Handles the dependency ordering

6. **Read a Confluence page (bonus).** If you have Confluence, use the MCP tools to read a Confluence page and feed its content into your spec-to-backlog prompt. This closes the loop: Confluence page in, Jira backlog out.

## Verification

- [ ] Atlassian MCP server configured and authenticated
- [ ] At least one Jira issue created via Copilot MCP tools
- [ ] An Epic with linked Stories created in Jira
- [ ] Bulk creation prompt created and tested
- [ ] (Bonus) Confluence page read and used as prompt input

---

Previous: [Phase 2: Refinement Agent](phase-2-refinement.md) | Next: [Phase 4: Consistency Benchmark](phase-4-benchmark.md)
