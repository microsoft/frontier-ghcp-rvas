# Phase 1: Code Archaeology

**Duration:** 2-3 hours
**Focus:** Reverse-engineering, documentation, architecture mapping

## Objective

Understand the MUMPS banking system well enough to explain every module's purpose, map the data model, trace key business workflows, and document the system for someone who has never seen it. You start with almost nothing -- a brief system context file and 12 source files in an unfamiliar language.

## Tasks

Before you open a single routine, use everything you set up: keep your repository instructions open for the MUMPS conventions, bring in the MUMPS Archaeologist agent for the parts that need domain judgment, and run your business rule documentation skill as you trace each workflow instead of writing up the architecture doc from memory afterward.

1. **Learn MUMPS basics.** Before touching the code, spend 15-20 minutes getting oriented. Ask Copilot to explain MUMPS syntax: what `S`, `W`, `I`, `D`, `Q`, `F`, `N`, `K`, `L`, `R` mean, how `^GLOBALS` work as a built-in database, what `$ORDER`, `$PIECE`, `$GET`, `$DATA`, `$HOROLOG` do, and what the `.` indentation means inside `DO` blocks. Create a cheat sheet for yourself in the challenge folder.

2. **Map the module structure.** Read through every `.m` file in `routines/` and write a one-paragraph summary of each. Which modules handle user-facing menus? Which contain business logic? Which are pure utilities? Document the call graph -- which routines call which.

3. **Extract the data model.** The database is implicit in the code -- global variables like `^CUST`, `^ACCT`, `^TXNLOG`, `^LOAN`, `^USER`, `^AUDIT`, `^BATCH`, and `^BNKCONF` define the schema. For each global, document:
   - Its hierarchical key structure (subscripts)
   - What each leaf node stores
   - Indexes and cross-references
   - Relationships to other globals

4. **Trace three key workflows end-to-end.** Pick three operations and trace them through the code from user input to database write:
   - A customer deposit (user menu through BNKTXN and back)
   - An account-to-account transfer (including the locking strategy)
   - End-of-day batch processing (all the steps BNKBATCH runs)

5. **Identify quirks, risks, and technical debt.** As you read, note anything that looks like a bug, a workaround, dead code, a security concern, or a missing feature. The system context file hints at some of these, but there are more to find.

6. **Produce an architecture document.** Write a single markdown file (`docs/architecture.md` in the challenge folder) that covers:
   - System overview and module map
   - Data model with all globals documented
   - Key workflow diagrams (text-based, Mermaid, or ASCII -- your choice)
   - Technical debt inventory
   - Glossary of domain terms used in the code

## Copilot Tips for This Phase

- Use `/explain` on each `.m` file to get a starting point, then refine with follow-up questions.
- Ask Copilot: "What does `F  S AID=$O(^ACCT(AID)) Q:AID=""  D` do?" -- it can explain MUMPS idioms.
- Point Copilot at `BNKINIT.m` first -- the seed data reveals the data model more clearly than the business logic.
- Use agent mode to generate Mermaid diagrams from your module descriptions.
- For dense code blocks, paste them into chat and ask "What business rule does this implement?"

## Verification

- [ ] Cheat sheet of MUMPS syntax created
- [ ] All 12 routines summarized with purpose and responsibilities
- [ ] Complete data model documented (all globals, subscripts, indexes)
- [ ] Three workflows traced with step-by-step descriptions
- [ ] Technical debt items identified (at least 5)
- [ ] Architecture document written and saved to the challenge folder

---

Previous: [Phases](phases.md) | Next: [Phase 2: Characterization Testing](phase-2-testing.md)
