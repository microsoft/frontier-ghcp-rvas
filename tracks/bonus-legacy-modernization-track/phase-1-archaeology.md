# Phase 1: Code Archaeology

[Back to Legacy Code Modernization Track](../bonus-legacy-modernization-track.md)

**Duration:** 1.5-2 hours

**Focus:** Reverse-engineering, documentation, architecture mapping

## Tasks

1. **Read the system context.** Start with `docs/system-context.md` in the challenge folder. It gives you the same information a new team member would get on their first day -- which is not much.

2. **Explore the codebase with Copilot.** Use `/explain` on each Java file. Start with `AccountController.java` (the largest file with the most business logic), then `CustomerController.java`, `ReportController.java`, and `DbHelper.java`. For each file, ask Copilot follow-up questions: "What business rules are embedded in this method?" and "What are the edge cases?"

3. **Map the module structure.** Write a summary of each class: what it does, what endpoints it exposes, what database tables it touches. Document which classes depend on which.

4. **Extract the data model.** Read `schema.sql` and `data.sql`. Document the tables, columns, relationships, and constraints. Note any missing constraints (foreign keys without ON DELETE rules, columns that should have NOT NULL but don't).

5. **Trace three key workflows.** Pick three operations and trace them from HTTP request to database write:
   - Creating a new account (the minimum balance rules, interest rate tiers, account limit check)
   - A transfer between accounts (the balance check, both-side updates, transaction logging)
   - Monthly interest calculation (which accounts qualify, the calculation formula, the rounding)

6. **Produce an architecture document.** Write `docs/architecture.md` covering: module map, data model, key workflows (use Mermaid diagrams), and a glossary of business terms used in the code.

## Verification

- [ ] All 4 Java files summarized with purpose and responsibilities
- [ ] Data model documented with all tables, columns, and relationships
- [ ] Three workflows traced with step-by-step descriptions
- [ ] Architecture document created with Mermaid diagrams
- [ ] Business rules extracted and documented (account limits, interest tiers, transfer rules, customer tiers)

---

Next: [Phase 2: Security and Debt Audit](phase-2-audit.md)
