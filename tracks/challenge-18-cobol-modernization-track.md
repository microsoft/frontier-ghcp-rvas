# Challenge 18 Track: Legacy COBOL Banking Modernization

**Duration:** 4-6 hours (five-hour core for one transfer workflow)

**Difficulty:** ⭐⭐⭐

**Focus:** Trace and characterize a COBOL account-transfer workflow, then expose it through an API and a React UI

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
- **UI review:** Impeccable, installed manually for one teller workflow
- **Testing:** Jest/Vitest (TypeScript) or JUnit 5 (Java)

## What You Are Working With

The codebase is a **core banking system** for a fictional bank called First National Bank. It has been "in production" since 1997 and shows its age. The system handles customer management, deposit accounts (savings, checking, fixed deposits), teller transactions, consumer loans, interest calculation, end-of-day batch processing, and audit logging.

The code is spread across multiple COBOL programs and copybooks totaling roughly 2,500 lines. Some programs are well-commented; others read like someone was in a hurry. There are dead code paths, hardcoded values that should be configurable, a comment about a "temporary fix" from 2012, and business logic that becomes clear only after tracing through multiple files.

Data lives in indexed sequential (ISAM) files -- COBOL's native flat-file storage with key-based access. A minimal context document is provided. Everything else you learn about the system, you learn from the code.

**The core covers one account-to-account transfer workflow.** Characterize its
rules before translation, then build a local API and React view for account
selection, transfer submission, and the resulting balances. Full-system
translation and new banking features are stretch work. Preserve the original
COBOL sources and do not replace their behavior with design recommendations.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-18-cobol-banking/`. Read the system-context.md first, then start exploring the COBOL source files and copybooks before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-18-cobol-banking/` with GnuCOBOL, Node.js LTS, Java 21, and the tools needed to compile and run the original COBOL programs.

### Install and Use Impeccable

Follow the [shared manual installation and discovery checks](getting-started.md#5-install-impeccable-when-your-track-uses-it)
after clean setup. Once the React shell exists, preflight one of its source
files. In Stage 4, critique only the transfer flow. Use
`fixtures/transfer-ui-cases.json` for review states and preserve the behavior
captured in Stage 2. This replaces the former frontend-design installation;
do not install both skills for this exercise.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are working with a legacy COBOL banking application and modernizing it to a React frontend with a Node.js/TypeScript or Java backend
- The COBOL conventions: IDENTIFICATION DIVISION, ENVIRONMENT DIVISION, DATA DIVISION, PROCEDURE DIVISION, WORKING-STORAGE SECTION, copybooks (`.cpy` files), PERFORM/PERFORM THRU, EVALUATE/WHEN, indexed file I/O (OPEN, READ, WRITE, REWRITE, DELETE, START), COMP-3 packed decimal, PIC clauses (PIC 9, PIC X, PIC S9V99), 88-level condition names, paragraph and section naming conventions
- Your target backend language and framework conventions
- That you want Copilot to explain COBOL idioms when asked and to preserve business logic exactly during modernization
- Non-negotiable: a modernized module must match the original's behavior, including its quirks, unless a quirk is a documented bug you're explicitly asked to fix

### Suggested Custom Agents

- **COBOL Archaeologist Agent** -- Reads COBOL source and copybooks and explains what it does: business rules, data flow, and paragraph structure. Give it a program or copybook; it returns a plain-language walkthrough. Use it before touching any modernization work.
- **Banking Domain Agent** -- Applies banking domain judgment: interest calculation methods, loan amortization, and audit requirements the COBOL code assumes but rarely states outright. Give it a described rule; it explains the domain reasoning. Use it when a calculation's intent is unclear from the code alone.
- **Modernization Agent** -- Reasons about target architecture: how a documented COBOL business rule becomes a REST endpoint, service layer, schema, and page structure in your chosen stack. Give it a documented rule and your target stack; it proposes the design. Use it once the Archaeologist and Domain agents have made the original logic clear.

### Suggested Custom Skills

- **Behavior Parity Check Skill** -- A repeatable comparison: run the original COBOL program (via GnuCOBOL) and the modernized code against the same inputs, and confirm the outputs, including known quirks, match before calling a module migrated.
- **Business Rule Documentation Skill** -- A fixed sequence: trace a paragraph, extract the rule in plain language, and log it in a shared doc before any code gets rewritten.
- **Transfer Journey Check Skill** -- A repeatable check of account selection, rejected transfers, and successful balance updates. Require backend evidence before accepting a success message. Keep it separate from Impeccable's general UI review.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "legacy code archaeology agent", "characterization testing skill", and "banking domain instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- COBOL is in Copilot's training data and it handles it better than most legacy languages. Paste code blocks and ask for line-by-line explanations -- the results are usually solid.
- Use `@workspace` and `#file` references extensively -- point Copilot at specific programs and copybooks when asking questions.
- For modernization, describe the business rule first ("this paragraph calculates monthly loan payment using the PMT formula"), then ask for the equivalent in your target language. Do not ask Copilot to "translate this COBOL" cold -- it works better when you give it the intent.
- Agent mode is strong for generating test scaffolding. Describe the test scenarios and let Copilot wire up the framework.
- The `/explain` command works on COBOL files. Use it on the dense programs to build your understanding.
- Give Impeccable the characterized transfer rules before reviewing the UI. Accept a change only if the backend tests and browser journey still agree.

## Resources

- [COBOL Language Overview (Wikipedia)](https://en.wikipedia.org/wiki/COBOL)
- [GnuCOBOL Documentation](https://gnucobol.sourceforge.io/)
- [COBOL Tutorial (Tutorialspoint)](https://www.tutorialspoint.com/cobol/index.htm)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-18-cobol-modernization-track/stages.md)
