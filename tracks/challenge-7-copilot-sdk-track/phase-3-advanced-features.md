# Phase 3: Advanced Features

**Estimated:** 2-3 hours

The agent can now fetch PRs and generate a changelog. In this phase you add MCP integration so it can read repository files, define a constrained release-manager persona, and give it write tools to actually publish the release.

## Tasks

1. **MCP server integration**
    - Configure the session to connect to the GitHub MCP server
    - Use MCP to let the agent read repository files -- specifically `CHANGELOG.md` (to match the existing format and voice), CI workflow configs (to check pipeline status), and `package.json` or equivalent version files
    - Combine MCP-provided tools with your custom tools in a single session
    - Test that the agent can answer questions like "What format does the existing changelog use?" by reading the actual file

2. **Release manager persona**
    - Define a custom agent with a system prompt that constrains behavior: "You are a release manager. Be precise about breaking changes. Flag any PR that lacks a description or linked issue. Format changelogs consistently."
    - Configure which tools this agent has access to -- it should only use the release-related tools, not general-purpose file system or shell tools
    - Experiment with how different model choices affect the quality of categorization and changelog writing

3. **Iterative refinement**
    - Build a conversational editing loop: after generating the changelog, the user can request changes
    - Support commands like "Move PR #405 to the highlights section", "Add a migration guide for the auth breaking change", "Make the descriptions shorter", "Group the dependency updates into a single line"
    - The agent should apply these edits to its internal changelog state and present the updated version
    - Each refinement round should stream the full updated changelog so the user can compare

4. **Publishing tools**
    - Create a `create_draft_release` tool that uses Octokit to create a GitHub Release in draft state with the generated notes, attached to the target tag
    - Create a `check_ci_status` tool that fetches the CI check status for the release branch or tag -- the agent should warn if checks are failing before publishing
    - The agent should confirm before publishing: "The changelog has 12 PRs across 4 categories. CI is green on main. Create a draft release tagged v2.4.0?"
    - After publishing, the agent should print the URL of the draft release

5. **Error handling and edge cases**
    - Handle SDK connection failures (Copilot CLI not running, auth expired)
    - Implement retry logic for transient GitHub API errors
    - Handle edge cases: repositories with no tags, PRs with no body, releases with zero changes
    - Add structured logging so you can debug tool calls and model decisions during development

## Verification

- The agent reads the existing `CHANGELOG.md` via MCP and matches its format in the generated notes
- The agent stays focused on release management and does not execute arbitrary shell commands
- Users can iteratively refine the changelog through conversation before publishing
- Running "publish it" creates a draft GitHub Release with the correct tag, title, and body
- The agent warns about failing CI checks before creating the release

---

Previous: [Phase 2: Core Features](phase-2-core-features.md) | Next: [Phase 4: Production-Ready](phase-4-production.md)
