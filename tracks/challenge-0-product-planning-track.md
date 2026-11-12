# Challenge 0 Track: Product Planning

**Duration:** 6-8 hours

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Product planning, backlog management, and documentation using GitHub Copilot and GitHub's collaboration features

## Prerequisites

- A GitHub account with Copilot access
- Basic familiarity with GitHub (repositories, issues, pull requests)
- No programming experience required

## Technology stack

- **GitHub Issues** for user stories and backlog items
- **GitHub Projects** for boards and milestone tracking
- **Markdown** for all documentation (product briefs, specs, ADRs, release plans)
- **GitHub Pull Requests** for reviewing and merging documentation changes
- **GitHub Copilot Chat** for brainstorming, writing, and refining documents

## Getting started

Pick one of these ways to work. You can switch later.

- **Path A: browser only.** Go to [github.com/copilot](https://github.com/copilot), attach your repository, and use Chat alongside Issues and Projects. Custom agents and instructions work here. Nothing to install.
- **Path B: Codespaces.** Create a Codespace from your repository and use Copilot Chat in the VS Code sidebar, with Issues and Projects on GitHub.com. The devcontainer hides the activity bar, status bar, and line numbers and uses a GitHub theme. Press `Ctrl+Shift+I` (`Cmd+Shift+I` on Mac) to open Chat.
- **Path C: local VS Code.** Use the GitHub MCP server to create issues, list PRs, and manage milestones from Copilot Chat. The devcontainer configures the server for you.

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Open `challenges/challenge-0-product-planning/` and read the templates and sample docs. Base your writing standards and artifact types on those files.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Your role (Product Owner, BA, PM) and what you need help with
- The product you are planning (TaskFlow, a task management platform)
- The kind of artifacts you produce (user stories, specs, ADRs, release plans)
- Writing standards (clear, concise, structured markdown)
- GitHub workflow preferences (issue labels, milestone naming, branch strategy)
- That this track has no codebase, so Copilot should suggest process and document improvements, not application code

### Suggested custom agents

- A Product Strategist Agent that checks feature ideas against product goals and flags risks or open questions before they reach the backlog.
- A Story Writer Agent that turns approved feature descriptions into stories with testable Given/When/Then acceptance criteria.
- A Release Planner Agent that proposes milestones from a backlog and identifies dependencies and communication needs.

### Suggested custom skills

- An Issue Batch Creation Skill that converts a finished stories file into GitHub Issues through MCP, keeping titles, bodies, and labels and confirming the issue count.
- A Document Critique Pass Skill that checks briefs, specs, or ADRs for contradictions, priority conflicts, and untestable acceptance criteria.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "product brief agent", "user story skill", and "release notes instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Write a rough draft first, then ask Copilot to tighten it.
- Use the GitHub MCP server to create a batch of Issues from a finished stories file.
- Use ADRs to compare options and trade-offs before deciding.
- In the critique exercises, check for contradictions, priority conflicts, and untestable criteria yourself.

## Resources

- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-0-product-planning-track/stages.md)
