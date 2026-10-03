# Challenge 13 Track: Living Documentation

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐

**Focus:** Use Copilot skills and agents to generate javadoc, architecture diagrams, changelogs, and stakeholder summaries

## Who is this for

- Developers who spend too much time writing and updating documentation
- Teams where documentation is always out of date because maintaining it is a manual burden
- Engineers who want to build documentation workflows that stay in sync with code changes
- Tech leads responsible for producing release notes, architecture diagrams, or stakeholder reports

## Prerequisites

- Familiarity with Java (you will read Java code and write javadoc)
- Basic understanding of REST APIs and MVC architecture
- Comfort with markdown and diagramming tools (Mermaid syntax is used)
- No framework expertise required

## Technology stack

- **Codebase:** Java 17, Spring Boot 3.x, JdbcTemplate, H2 database
- **Documentation tools:** Javadoc, Mermaid diagrams, Markdown
- **Copilot features:** Custom skills, custom agents, Copilot chat

## What you are working with

Widget Corp Inventory Manager is a wholesale distribution system for products, orders, stock tracking, and inventory reports. It has 4 controllers (OrderController, ProductController, InventoryController, plus a few domain classes), about 500 lines of business logic, and almost no documentation.

The Product class has a stub javadoc from v1.0 that says "Represents inventory item" without explaining the fields. Everything else is undocumented. The changelog stopped being updated after v2.0, even though significant features were added in v2.3 (warehouse transfers, stock movements) and v2.5 (volume discounts, reorder reports). There are no architecture diagrams.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-13-living-docs/`. Read the [system context](../challenges/challenge-13-living-docs/docs/system-context.md) first, then start exploring the `src/` directory before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-13-living-docs/` with Java 21, Maven, and Node.js LTS.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should include:

- That you are documenting an existing Java inventory management system
- Your javadoc conventions (what to document, parameter descriptions, exception docs)
- That Copilot should generate documentation that matches the actual code behavior, not aspirational behavior
- Your preferred diagram format (Mermaid recommended) and level of detail
- Non-negotiable: never document behavior you haven't verified by reading the method itself

### Suggested custom agents

- Use a Documentation Reviewer Agent as a PR check to flag undocumented public API changes in a diff, including endpoints, parameters, and return types.
- Use a Diagram Generator Agent to draft Mermaid architecture, sequence, and ERD diagrams from Java source and schema.
- Use a Release Communicator Agent at release time to draft a technical changelog entry and a non-technical stakeholder summary from a diff.

### Suggested custom skills

- A Javadoc Accuracy Pass Skill generates documentation from verified method behavior, including edge cases. Run it per class rather than in bulk.
- A Changelog Reconciliation Skill fills gaps against version history. Extend it in Stage 3 to generate entries from diffs and check affected components and breaking changes.
- A Stakeholder Summary Skill summarizes user impact and business communication needs from a diff. Use it with the changelog skill and Release Communicator agent in Stage 3.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "documentation review agent", "changelog skill", and "javadoc instructions" before you draft your own.

---

## Tips for using Copilot on this track

- When generating javadoc, paste a method into chat and ask "What does this method actually do, including edge cases?" Then ask Copilot to write the javadoc based on its own explanation. This produces more accurate docs than asking for javadoc cold.
- For Mermaid diagrams, describe the diagram you want in plain language first, then ask Copilot to generate the Mermaid syntax. Iterate on the diagram until it matches the actual architecture.
- Test your changelog skill on small diffs first (a single-file change), then scale to multi-file changes.
- For the PR review agent, start by defining what "documentation completeness" means for your team. Different teams care about different things.
- Use `@workspace` to give Copilot full context when generating cross-module diagrams.

## Resources

- [Mermaid Diagramming Syntax](https://mermaid.js.org/intro/)
- [Javadoc Best Practices](https://www.oracle.com/technical-resources/articles/java/javadoc-tool.html)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-13-living-docs-track/stages.md)
