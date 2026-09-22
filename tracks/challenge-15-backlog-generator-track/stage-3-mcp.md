# Stage 3: MCP Integration

**Duration:** 1.5-2 hours

**Focus:** Pushing generated backlog items to Jira using the Atlassian Rovo MCP server

> This stage requires an Atlassian Cloud account with Jira access. If you do not have one, skip to Stage 4.

## Tasks

1. **Set up the Atlassian MCP server.** Follow the instructions in the [MCP Servers Guide](../../docs/mcp-servers.md#atlassian-rovo-mcp-server-jira-confluence) to configure the Atlassian Rovo MCP server in your `.vscode/mcp.json`. Complete the OAuth authentication flow.

2. **Explore the available tools.** In Agent mode, ask Copilot what Atlassian MCP tools are available. Familiarize yourself with the tools for creating Jira issues, searching issues, and reading Confluence pages.

3. **Create a single issue manually.** Use Copilot in Agent mode to create one Jira Issue (a User Story) from your generated backlog. Verify it appears correctly in Jira with the right fields.

4. **Create an Epic with linked Stories.** Use Copilot to:
   - Create a Jira Epic
   - Create multiple Stories under that Epic
   - Set the correct issue type, summary, description, and acceptance criteria

5. **Build the Jira Push skill.** Create or refine `.github/skills/push-backlog-to-jira/SKILL.md` from setup for a workflow that:
   - Takes your reviewed backlog as input
   - Requires human approval of the target project and issue mapping before creating items through MCP
   - Creates Epics first, then Stories linked to Epics, then Tasks linked to Stories
   - Handles the dependency ordering
   - Reports created issue references and any failed writes so a retry does not duplicate completed work

6. **Read a Confluence page (bonus).** If you have Confluence, use the MCP tools to read a page and supply its content to your spec-to-backlog skill. Review the generated backlog before using the Jira Push skill.

## Verification

- [ ] Atlassian MCP server configured and authenticated
- [ ] At least one Jira issue created via Copilot MCP tools
- [ ] An Epic with linked Stories created in Jira
- [ ] Approved backlog items created in dependency order, with issue references and failures reported
- [ ] (Bonus) Confluence content converted into a reviewed backlog

---

Previous: [Stage 2: Refinement Agent](stage-2-refinement.md) | Next: [Stage 4: Consistency Benchmark](stage-4-benchmark.md)
