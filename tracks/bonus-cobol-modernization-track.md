# Bonus Track: Legacy COBOL Banking Modernization

**Duration:** 8-12 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Legacy code comprehension, characterization testing, feature evolution, and full-stack modernization -- using GitHub Copilot to reverse-engineer a COBOL banking system and rebuild it as a modern web application

## Who Is This For

- Developers who enjoy reverse-engineering unfamiliar systems
- Engineers dealing with legacy modernization at work (COBOL, MUMPS, RPG, or similar)
- Anyone curious about how Copilot handles mainframe-era languages and large-scale translation tasks
- Teams that finished a standard track and want a fundamentally different kind of challenge

## Prerequisites

- Solid programming skills in at least one modern language (Node.js/TypeScript or Java)
- Comfort reading code you don't fully understand and building a mental model from it
- Basic understanding of banking concepts (accounts, transactions, interest, loans)
- Basic familiarity with React or willingness to learn quickly
- No prior COBOL experience required -- figuring it out is part of the challenge

## Technology Stack

- **Source language:** COBOL -- the language that still runs the majority of the world's banking transactions, in use since the 1960s
- **Runtime (optional):** GnuCOBOL -- open-source COBOL compiler for building and running the original programs
- **Backend target:** Node.js/TypeScript or Java (Spring Boot) -- your choice
- **Frontend:** React with a modern UI library (Material UI, Tailwind, or similar)
- **Copilot Skill:** `frontend-design` skill -- install via `npx skills install anthropics/claude-code` and select `frontend-design`
- **Testing:** Jest/Vitest (TypeScript) or JUnit 5 (Java)

## What You Are Working With

The codebase is a **core banking system** for a fictional bank called First National Bank. It has been "in production" since 1997 and shows its age. The system handles customer management, deposit accounts (savings, checking, fixed deposits), teller transactions, consumer loans, interest calculation, end-of-day batch processing, and audit logging.

The code is spread across multiple COBOL programs and copybooks totaling roughly 2,500 lines. Some programs are well-commented; others read like someone was in a hurry. There are dead code paths, hardcoded values that should be configurable, a comment about a "temporary fix" from 2012, and business logic that becomes clear only after tracing through multiple files.

Data lives in indexed sequential (ISAM) files -- COBOL's native flat-file storage with key-based access. A minimal context document is provided. Everything else you learn about the system, you learn from the code.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are working with a legacy COBOL banking application and modernizing it to a React frontend with a Node.js/TypeScript or Java backend
- The COBOL conventions: IDENTIFICATION DIVISION, ENVIRONMENT DIVISION, DATA DIVISION, PROCEDURE DIVISION, WORKING-STORAGE SECTION, copybooks (`.cpy` files), PERFORM/PERFORM THRU, EVALUATE/WHEN, indexed file I/O (OPEN, READ, WRITE, REWRITE, DELETE, START), COMP-3 packed decimal, PIC clauses (PIC 9, PIC X, PIC S9V99), 88-level condition names, paragraph and section naming conventions
- Your target backend language and framework conventions
- That you want Copilot to explain COBOL idioms when asked and to preserve business logic exactly during modernization

### Suggested Agents

- **COBOL Archaeologist Agent** -- Reads COBOL source and explains what it does. Identifies business rules, data flows, copybook structures, and paragraph naming conventions. Knows COBOL syntax, DIVISION/SECTION structure, FD entries, and common idioms.
- **Banking Domain Agent** -- Understands core banking concepts: account types, interest calculation methods (simple vs. compound, day-count conventions), loan amortization, transaction atomicity, and audit requirements.
- **Modernization Agent** -- Takes documented COBOL business logic and produces a modern web architecture: REST API endpoints, service layer design, database schema, and React page structure. Preserves behavior while adopting modern patterns.
- **Frontend Design Agent** -- Works with the `frontend-design` skill to design and build the React frontend. Handles component architecture, layout design, form validation, and responsive UI patterns.

### Open the Challenge

Navigate to `challenges/bonus-12-cobol-banking/`. Read the system-context.md first, then start exploring the COBOL source files and copybooks.

A dedicated devcontainer is provided at `.devcontainer/bonus-12-cobol-banking/` with GnuCOBOL, Node.js LTS, Java 21, and the tools needed to compile and run the original COBOL programs.

---

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Code Archaeology](bonus-cobol-modernization-track/phase-1-archaeology.md) | 2-3 hours | Reverse-engineer the COBOL codebase, document architecture, map data model |
| 2 | [Characterization Testing](bonus-cobol-modernization-track/phase-2-testing.md) | 2-3 hours | Write tests that capture current behavior in your target language |
| 3 | [Feature Evolution](bonus-cobol-modernization-track/phase-3-evolution.md) | 1.5-2 hours | Extend the system with new features |
| 4 | [Full-Stack Modernization](bonus-cobol-modernization-track/phase-4-modernization.md) | 2.5-3 hours | Build a React frontend + API backend from the COBOL business logic |

Each phase builds on the previous. The archaeology phase is critical -- if you skip understanding the code, the modernization phase will produce a broken system.

> **Short on time?** Focus on Phases 1 and 4. Translate the core transaction program and account program rather than the full system. Skip Phase 3 entirely.

## Tips for Using Copilot on This Track

- COBOL is in Copilot's training data and it handles it better than most legacy languages. Paste code blocks and ask for line-by-line explanations -- the results are usually solid.
- Use `@workspace` and `#file` references extensively -- point Copilot at specific programs and copybooks when asking questions.
- For modernization, describe the business rule first ("this paragraph calculates monthly loan payment using the PMT formula"), then ask for the equivalent in your target language. Do not ask Copilot to "translate this COBOL" cold -- it works better when you give it the intent.
- Agent mode is strong for generating test scaffolding. Describe the test scenarios and let Copilot wire up the framework.
- The `/explain` command works on COBOL files. Use it on the dense programs to build your understanding.
- When working on the React frontend, install the frontend-design skill (`npx skills install anthropics/claude-code`, then select `frontend-design`). It helps Copilot generate polished React components and page layouts from descriptions.

## Resources

- [COBOL Language Overview (Wikipedia)](https://en.wikipedia.org/wiki/COBOL)
- [GnuCOBOL Documentation](https://gnucobol.sourceforge.io/)
- [COBOL Tutorial (Tutorialspoint)](https://www.tutorialspoint.com/cobol/index.htm)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
