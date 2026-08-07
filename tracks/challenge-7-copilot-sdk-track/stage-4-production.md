# Stage 4: Production-Ready

**Estimated:** 1-2 hours

The agent works end-to-end. Now make it reliable, testable, and deployable.

## Tasks

1. **Testing**
    - Write unit tests for each custom tool implementation: mock Octokit responses and verify that `get_merged_prs` returns correctly shaped data, that `get_linked_issues` resolves references, and that `get_commit_stats` computes the right totals
    - Test the categorization logic independently -- given a set of PR fixtures with various labels and title prefixes, verify they land in the right categories
    - Write an integration test that creates a real `CopilotClient` session, sends a release notes prompt against fixture data, and verifies the output contains the expected sections
    - Mock the GitHub API for deterministic results -- you do not want tests hitting the network
    - Aim for >70% coverage on tool and categorization logic

2. **Packaging**
    - Compile TypeScript and bundle dependencies for distribution
    - Set up a clean `npm run build` that produces a ready-to-run artifact
    - Configure environment variables for `GITHUB_TOKEN` and any MCP server settings
    - Document the setup steps so other team members can run the agent from a fresh Codespace
    - Make sure the build output works without dev dependencies installed

## Verification

- `npm test` passes with >70% coverage on tool implementations and categorization logic
- The application runs successfully in a Codespace and can generate release notes for a real repository
- Environment variables are configured securely -- no tokens in source code or build artifacts

---

Previous: [Stage 3: Advanced Features](stage-3-advanced-features.md)
