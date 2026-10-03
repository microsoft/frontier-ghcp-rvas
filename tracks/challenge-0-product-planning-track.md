# Challenge 0 Track: Product Planning

**Duration:** 6-8 hours

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Product planning, backlog management, and documentation using GitHub Copilot and GitHub's collaboration features

## Who is this for

- Product Owners and Product Managers
- Business Analysts
- Project Managers and Scrum Masters
- Program Managers
- Stakeholders who participate in planning and requirements

## Prerequisites

- A GitHub account with Copilot access
- Basic familiarity with GitHub (repositories, issues, pull requests)
- No programming experience required

## Technology stack

No traditional development stack. You will work with:

- **GitHub Issues** for user stories and backlog items
- **GitHub Projects** for boards and milestone tracking
- **Markdown** for all documentation (product briefs, specs, ADRs, release plans)
- **GitHub Pull Requests** for reviewing and merging documentation changes
- **GitHub Copilot Chat** for brainstorming, writing, and refining documents

## Getting started

Choose one of these ways to work:

Path A uses GitHub.com Copilot Chat in the browser without an IDE. Go to [github.com/copilot](https://github.com/copilot), attach your repository, and use Chat alongside Issues and Projects. Custom agents and instructions work here. Nothing needs installing.

Path B uses GitHub.com and Codespaces. Create a Codespace from your repository and use Copilot Chat in VS Code's sidebar, with Issues and Projects on GitHub.com. The devcontainer hides the activity bar, status bar, and line numbers and uses a GitHub theme. Press `Ctrl+Shift+I` (or `Cmd+Shift+I` on Mac) to open Chat.

Path C uses local VS Code with the GitHub MCP server to create issues, list PRs, and manage milestones from Copilot Chat. The devcontainer pre-configures the server.

> You can switch between these options.

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

- Use a Product Strategist Agent to review feature ideas against product goals and flag risks or open questions before adding them to the backlog.
- Use a Story Writer Agent to turn approved feature descriptions into stories with testable Given/When/Then acceptance criteria.
- Use a Release Planner Agent to propose milestones from a backlog and identify dependencies and communication needs.

### Suggested custom skills

- An Issue Batch Creation Skill converts a finished stories file into GitHub Issues through MCP. It should preserve titles, bodies, and labels and confirm the issue count.
- A Document Critique Pass Skill reviews briefs, specs, or ADRs for contradictions, priority conflicts, and untestable acceptance criteria before you share them.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "product brief agent", "user story skill", and "release notes instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Write a rough draft first, then ask Copilot to tighten it. Copilot refines ideas better than it invents them from nothing.
- Use the GitHub MCP server to create a batch of Issues from a finished stories file.
- ADRs double as thinking tools. Listing options and trade-offs often makes the right choice obvious before you finish writing.
- In the critique exercises, Copilot spots surface-level issues well. Contradictions, priority conflicts, and untestable criteria are on you.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-0-product-planning-track/stages.md)
