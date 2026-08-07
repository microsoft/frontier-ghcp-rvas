# Phase 2: Core Features

**Estimated:** 3-4 hours

This is where the agent gets its hands dirty. You will build the custom tools that fetch PR data from GitHub, teach the agent to categorize changes, and have it generate a structured changelog -- all through natural conversation.

## Tasks

1. **PR fetching tools**
    - Define and register a `get_merged_prs` custom tool that uses Octokit to fetch all pull requests merged since a given tag, date, or commit SHA
    - The tool should return a simplified array for each PR: `{ number, title, body, labels, author, mergedAt, url }`
    - Register the tool with the session so the agent can call it when it needs PR data
    - Handle the tool invocation: when the model calls `get_merged_prs`, execute the Octokit query and return the results
    - Test by asking the agent "What PRs have been merged since v2.3.0?" and verifying it calls the tool

2. **Supporting data tools**
    - Create a `get_linked_issues` tool: given a PR number, fetch the issues referenced in its body or linked via GitHub's timeline API
    - Create a `get_commit_stats` tool: given a PR number, fetch file-change statistics (files changed, insertions, deletions) to help the agent gauge the size and scope of a change
    - Register both tools alongside `get_merged_prs` so the agent can pull in extra context when it needs to

3. **Change categorization**
    - Through conversation with the agent, establish categorization rules: features, bug fixes, breaking changes, dependency updates, internal/chore
    - The agent should categorize each PR based on its labels, title prefix (e.g., `feat:`, `fix:`, `breaking:`), and body content
    - When a PR is ambiguous, the agent should ask the user: "PR #412 touches the auth module but has no labels. Is this a feature or a fix?"
    - Build this as a multi-turn flow -- the agent proposes categories, the user approves or overrides

4. **Changelog generation**
    - Once all PRs are categorized, the agent generates a structured changelog with sections for each category
    - Each entry should include the PR title, number, author, and linked issues
    - Breaking changes should include a migration note (which the agent drafts based on the PR body and diff summary)
    - The format should follow common conventions (similar to Keep a Changelog or GitHub's auto-generated release notes)

If ship-it's categorization is generic or mishandles ambiguous PRs, refine the repository instructions, your participant-side SDK Pairing agent, or the research skill before changing the separate SDK agent you are building.

## Verification

- Asking "What changes are in this release?" triggers the `get_merged_prs` tool and returns real data from the target repo
- The agent categorizes PRs and asks about ambiguous ones before finalizing
- The generated changelog is well-structured with separate sections for features, fixes, breaking changes, and other categories
- The conversation flows naturally -- no explicit commands needed, the agent decides when to call tools

---

Previous: [Phase 1: Foundation](phase-1-foundation.md) | Next: [Phase 3: Advanced Features](phase-3-advanced-features.md)
