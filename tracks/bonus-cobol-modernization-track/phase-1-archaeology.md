# Phase 1: Code Archaeology

[Back to Legacy COBOL Banking Modernization Track](../bonus-cobol-modernization-track.md)

**Duration:** 2-3 hours
**Focus:** Reverse-engineering, documentation, architecture mapping

## Objective

Understand the COBOL banking system well enough to explain every program's purpose, map the data model, trace key business workflows, and document the system for someone who has never seen it. You start with almost nothing -- a brief system context file and a set of source files in a language most developers have never worked with.

## Tasks

1. **Learn COBOL basics.** Before touching the code, spend 15-20 minutes getting oriented. Ask Copilot to explain COBOL structure: what the four DIVISIONs are (IDENTIFICATION, ENVIRONMENT, DATA, PROCEDURE), how SECTIONS and paragraphs organize code, what PIC clauses mean (`PIC 9(5)`, `PIC X(30)`, `PIC S9(7)V99 COMP-3`), how 88-level condition names work, what PERFORM and PERFORM THRU do, how EVALUATE/WHEN replaces nested IF chains, and how indexed file I/O works (OPEN, READ, WRITE, REWRITE, DELETE, START with keys). Create a cheat sheet for yourself in the challenge folder.

2. **Map the program structure.** Read through every `.cbl` file and `.cpy` copybook. Write a one-paragraph summary of each. Which programs handle user-facing menus? Which contain business logic? Which are pure utilities? Document the call graph -- which programs CALL which, and which paragraphs PERFORM which.

3. **Extract the data model.** The database is defined in FD (File Description) entries and copybooks. For each ISAM file, document:
   - The record layout from the copybook (field names, PIC clauses, sizes)
   - The primary key and any alternate keys (ALTERNATE RECORD KEY)
   - COMP-3 packed decimal fields and their precision
   - 88-level condition names and what they represent
   - Relationships between files (customer ID linking accounts to customers, etc.)

4. **Trace three key workflows end-to-end.** Pick three operations and trace them through the code from user input to file write:
   - A customer deposit (menu selection through the transaction program and back)
   - An account-to-account transfer (including any locking or serialization strategy)
   - End-of-day batch processing (all the steps the batch program runs)

5. **Identify quirks, risks, and technical debt.** As you read, note anything that looks like a bug, a workaround, dead code, a security concern, or a missing feature. The system context file hints at some of these, but there are more to find.

6. **Produce an architecture document.** Write a single markdown file (`docs/architecture.md` in the challenge folder) that covers:
   - System overview and program map
   - Data model with all ISAM files and record layouts documented
   - Key workflow diagrams (text-based, Mermaid, or ASCII -- your choice)
   - Technical debt inventory
   - Glossary of domain terms used in the code

## Copilot Tips for This Phase

- Use `/explain` on each `.cbl` file to get a starting point, then refine with follow-up questions.
- Ask Copilot: "What does this PERFORM THRU block do?" or "Explain this EVALUATE statement" -- it handles COBOL idioms well.
- Point Copilot at the seed data or initialization program first -- the initial data setup reveals the data model more clearly than the business logic.
- Use agent mode to generate Mermaid diagrams from your program descriptions.
- For dense PROCEDURE DIVISION blocks, paste them into chat and ask "What business rule does this implement?"
- Copybooks are key -- they define the record layouts that every program shares. Start there for the data model.

## Verification

- [ ] Cheat sheet of COBOL syntax and conventions created
- [ ] All programs and copybooks summarized with purpose and responsibilities
- [ ] Complete data model documented (all ISAM files, record layouts, keys, conditions)
- [ ] Three workflows traced with step-by-step descriptions
- [ ] Technical debt items identified (at least 5)
- [ ] Architecture document written and saved to the challenge folder

---

Next: [Phase 2: Characterization Testing](phase-2-testing.md)
