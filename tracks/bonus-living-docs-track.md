# Bonus Track: Living Documentation

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐

**Focus:** Automating documentation generation -- javadoc, architecture diagrams, changelogs, and stakeholder-facing summaries -- using Copilot prompts and agents

## Who Is This For

- Developers who spend too much time writing and updating documentation
- Teams where documentation is always out of date because maintaining it is a manual burden
- Engineers who want to build documentation workflows that stay in sync with code changes
- Tech leads responsible for producing release notes, architecture diagrams, or stakeholder reports

## Prerequisites

- Familiarity with Java (you will read Java code and write javadoc)
- Basic understanding of REST APIs and MVC architecture
- Comfort with markdown and diagramming tools (Mermaid syntax is used)
- No framework expertise required -- the starter code is straightforward

## Technology Stack

- **Codebase:** Java 17, Spring Boot 3.x, JdbcTemplate, H2 database
- **Documentation tools:** Javadoc, Mermaid diagrams, Markdown
- **Copilot features:** Custom prompts, custom agents, Copilot chat

## What You Are Working With

The codebase is the **Widget Corp Inventory Manager** -- a wholesale distribution system that manages products, orders, stock tracking, and inventory reporting. It has 4 controllers (OrderController, ProductController, InventoryController, plus a few domain classes), about 500 lines of business logic, and almost no documentation.

The Product class has a stub javadoc from v1.0 that says "Represents inventory item" without explaining the fields. Everything else is undocumented. The changelog stopped being updated after v2.0, even though significant features were added in v2.3 (warehouse transfers, stock movements) and v2.5 (volume discounts, reorder reports). There are no architecture diagrams.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are documenting an existing Java inventory management system
- Your javadoc conventions (what to document, parameter descriptions, exception docs)
- That Copilot should generate documentation that matches the actual code behavior, not aspirational behavior
- Your preferred diagram format (Mermaid recommended) and level of detail

### Suggested Agents

- **Documentation Reviewer Agent** -- Reviews PRs and flags any public API change (new endpoints, changed parameters, modified return types) that lacks corresponding documentation updates. Can check javadoc, API docs, and the changelog.
- **Diagram Generator Agent** -- Reads Java source files and generates Mermaid architecture diagrams, sequence diagrams for workflows, and ERD diagrams from SQL schemas.
- **Release Communicator Agent** -- Takes code diffs and produces two outputs: (1) a technical changelog entry and (2) a non-technical stakeholder summary of the same changes.

### Open the Challenge

Navigate to `challenges/bonus-7-living-docs/`. Read the [system context](../challenges/bonus-7-living-docs/docs/system-context.md) first, then start exploring the `src/` directory.

A dedicated devcontainer is provided at `.devcontainer/bonus-7-living-docs/` with Java 21, Maven, and Node.js LTS.

---

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Javadoc Generation](bonus-living-docs-track/phase-1-javadoc.md) | 1.5-2 hours | Generate accurate javadoc for all classes and public methods |
| 2 | [Architecture Diagrams](bonus-living-docs-track/phase-2-diagrams.md) | 1-1.5 hours | Create Mermaid diagrams: system architecture, data model, key workflows |
| 3 | [Changelog and Release Notes](bonus-living-docs-track/phase-3-changelog.md) | 1-1.5 hours | Build a prompt that generates changelogs and stakeholder summaries |
| 4 | [PR Documentation Agent](bonus-living-docs-track/phase-4-pr-agent.md) | 2-3 hours | Build an agent that reviews PRs for documentation completeness |

Phases 1-3 can be done in any order. Phase 4 builds on the skills and artifacts from the earlier phases.

> **Short on time?** Focus on Phases 1 and 2. Generated javadoc and architecture diagrams deliver the most immediate value to the team.

## Tips for Using Copilot on This Track

- When generating javadoc, paste a method into chat and ask "What does this method actually do, including edge cases?" Then ask Copilot to write the javadoc based on its own explanation. This produces more accurate docs than asking for javadoc cold.
- For Mermaid diagrams, describe the diagram you want in plain language first, then ask Copilot to generate the Mermaid syntax. Iterate on the diagram until it matches the actual architecture.
- Test your changelog prompt on small diffs first (a single-file change), then scale to multi-file changes.
- For the PR review agent, start by defining what "documentation completeness" means for your team. Different teams care about different things.
- Use `@workspace` to give Copilot full context when generating cross-module diagrams.

## Resources

- [Mermaid Diagramming Syntax](https://mermaid.js.org/intro/)
- [Javadoc Best Practices](https://www.oracle.com/technical-resources/articles/java/javadoc-tool.html)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
