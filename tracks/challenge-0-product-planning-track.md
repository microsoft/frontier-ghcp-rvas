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

Follow the [common setup steps](getting-started.md) for the clean start, custom instructions, and custom agents, then continue below.

### Custom Instructions for This Track

**What to include:**

- Your role (Product Owner, BA, PM) and what you need help with
- The product you are planning (TaskFlow -- a task management platform)
- The kind of artifacts you produce (user stories, specs, ADRs, release plans)
- Writing standards (clear, concise, structured markdown)
- GitHub workflow preferences (issue labels, milestone naming, branch strategy)

### Suggested Agents

**Agents to consider creating:**

- **Product Strategist Agent** -- Helps write product briefs, evaluate feature ideas, and define success metrics
- **Story Writer Agent** -- Specializes in writing user stories with clear acceptance criteria
- **Release Planner Agent** -- Focused on milestone planning, risk assessment, and communication plans

### Open the Challenge

Navigate to `challenges/challenge-0-product-planning/`. This is where your starter files live (templates, sample docs, and exercises).

---

## Stages

### Scenario

You are the Product Owner (or Business Analyst) for **TaskFlow**, a task management platform for engineering teams. The development team has already built a basic REST API with authentication, task CRUD operations, and search (this is what the Backend Track builds in Challenge 1). Your job is to plan the next major release -- **TaskFlow v2.0** -- which adds team collaboration, notifications, and reporting.

Your deliverables are documentation and a well-organized GitHub backlog, not code.

| Stage | Name | Difficulty | Est. Time | What You Produce |
|-------|------|------------|-----------|------------------|
| 1 | [Product Vision and Market Analysis](challenge-0-product-planning-track/stage-1-product-vision.md) | ⭐ | 60-90 min | Product brief with competitive analysis and quantified personas |
| 2 | [User Stories and Backlog Quality](challenge-0-product-planning-track/stage-2-user-stories.md) | ⭐⭐ | 60-90 min | 10+ user stories, critique of bad stories, MoSCoW prioritization |
| 3 | [Feature Specification and Technical Alignment](challenge-0-product-planning-track/stage-3-feature-specs.md) | ⭐⭐ | 75-90 min | 2 feature specs with diagrams, spec review exercise |
| 4 | [Decision Making Under Constraints](challenge-0-product-planning-track/stage-4-decision-making.md) | ⭐⭐⭐ | 60-90 min | 3 ADRs, stakeholder conflict resolution, buy-vs-build analysis |
| 5 | [Release Planning and Go-to-Market](challenge-0-product-planning-track/stage-5-release-planning.md) | ⭐⭐⭐ | 90-120 min | Release plan with risk matrix, rollback plan, dual release notes |

Each stage builds on the previous one. Copilot can help you draft and brainstorm, but the later stages require judgment, trade-off analysis, and critical thinking that you must bring yourself.

> **Short on time?** Pick one spec instead of two in Stage 3, write 2 ADRs instead of 3 in Stage 4, and focus on the release plan and one set of release notes in Stage 5.

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
