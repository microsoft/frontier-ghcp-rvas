# Challenge 0 Track: Product Planning

**Duration:** 6-8 hours

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Product planning, backlog management, and documentation using GitHub Copilot and GitHub's collaboration features

## Who Is This For

- Product Owners and Product Managers
- Business Analysts
- Project Managers and Scrum Masters
- Program Managers
- Stakeholders who participate in planning and requirements

## Prerequisites

- A GitHub account with Copilot access
- Basic familiarity with GitHub (repositories, issues, pull requests)
- No programming experience required

## Technology Stack

No traditional development stack. You will work with:

- **GitHub Issues** for user stories and backlog items
- **GitHub Projects** for boards and milestone tracking
- **Markdown** for all documentation (product briefs, specs, ADRs, release plans)
- **GitHub Pull Requests** for reviewing and merging documentation changes
- **GitHub Copilot Chat** for brainstorming, writing, and refining documents

## Getting Started

This track supports three ways of working. Choose the one that fits you best, or mix and match.

**Path A: GitHub.com Copilot Chat** -- Work entirely in the browser with no IDE. Go to [github.com/copilot](https://github.com/copilot), attach your repository for context, and use Copilot Chat alongside the GitHub.com UI for Issues and Projects. Custom agents and custom instructions work here. This is the lowest-friction option -- nothing to install or configure.

**Path B: GitHub.com + Codespaces** -- Work in VS Code in the browser via Codespaces. Open your repository on GitHub.com, create a Codespace, and use Copilot Chat in the sidebar alongside the GitHub.com UI for Issues and Projects. The devcontainer strips away typical IDE complexity -- no activity bar, no status bar, no line numbers. You get a clean writing environment with a GitHub theme. Press `Ctrl+Shift+I` (or `Cmd+Shift+I` on Mac) to open Copilot Chat.

**Path C: VS Code with GitHub MCP Server** -- Work in VS Code locally and use the GitHub MCP server to create issues, list PRs, and manage milestones directly from Copilot Chat without leaving the editor. The devcontainer pre-configures this.

> All paths are valid. Mix and match as you like.

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-0-product-planning/`. This is where your starter files live (templates, sample docs, and exercises). Read through the templates and sample docs before drafting anything -- the writing standards and artifact types below should reflect what's actually there.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- Your role (Product Owner, BA, PM) and what you need help with
- The product you are planning (TaskFlow -- a task management platform)
- The kind of artifacts you produce (user stories, specs, ADRs, release plans)
- Writing standards (clear, concise, structured markdown)
- GitHub workflow preferences (issue labels, milestone naming, branch strategy)
- That this track has no codebase, so Copilot should suggest process and document improvements, not application code

### Suggested Custom Agents

- **Product Strategist Agent** -- Weighs a feature idea or product brief draft against the product's goals and flags risks or open questions. Give it a rough idea; it returns a structured brief with trade-offs called out. Use it before committing an idea to the backlog, not for polishing final prose.
- **Story Writer Agent** -- Turns an approved idea into user stories with clear, testable acceptance criteria. Give it a feature description; it returns story drafts in Given/When/Then form. Use it once direction is set and the idea needs to become working units.
- **Release Planner Agent** -- Reasons about milestone sequencing, dependency risk, and stakeholder communication. Give it a backlog or set of stories; it proposes a milestone plan with risks called out. Use it when sequencing a release, not for day-to-day story writing.

### Suggested Custom Skills

- **Issue Batch Creation Skill** -- A repeatable sequence for turning a finished stories file into GitHub Issues through the MCP server: parse the file, map each story to title, body, and labels, create the issues, and confirm the count matches. Use it once stories are final, not while still drafting.
- **Document Critique Pass Skill** -- A structured review sequence for a brief, spec, or ADR: check for contradictions, priority conflicts, and untestable acceptance criteria, then list findings before anyone else reads the draft. Run it as a last step before sharing a document.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "product brief agent", "user story skill", and "release notes instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Write a rough draft first, then ask Copilot to tighten it. Copilot refines ideas better than it invents them from nothing.
- The GitHub MCP server lets you create Issues at scale from your stories file -- useful when you have a batch of user stories ready.
- ADRs double as thinking tools. Listing options and trade-offs often makes the right choice obvious before you finish writing.
- In the critique exercises, Copilot spots surface-level issues well. Contradictions, priority conflicts, and untestable criteria are on you.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)

---

Next: [Stages](challenge-0-product-planning-track/stages.md)
