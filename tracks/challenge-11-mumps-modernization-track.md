# Challenge 11 Track: Legacy MUMPS Modernization

**Duration:** 8-12 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Use GitHub Copilot to understand legacy code, write characterization tests, extend features, and translate MUMPS to a modern language

## Who is this for

- Developers who enjoy reverse-engineering unfamiliar systems
- Engineers dealing with legacy modernization at work (COBOL, MUMPS, RPG, or similar)
- Anyone curious about how Copilot handles obscure languages and large-scale translation tasks
- Teams that finished a standard track and want a fundamentally different kind of challenge

## Prerequisites

- Solid programming skills in at least one modern language (PSL, Java, Python, C#, TypeScript)
- Comfort reading code you don't fully understand and building a mental model from it
- Basic understanding of banking concepts (accounts, transactions, interest, loans)
- No prior MUMPS experience required

## Technology stack

- **Source language:** MUMPS (M), with a built-in hierarchical database, used in healthcare and banking since the 1960s
- **Runtime (optional):** YottaDB, an open-source MUMPS implementation for running the original code
- **Target language:** PSL or Java recommended; Python, C#, TypeScript, or another language also works. PSL fits FIS Profile experience; Java is the most common modernization target in banking.
- **Testing:** JUnit, pytest, or your preferred test framework for the target language

## What you are working with

The codebase is a core banking system for the fictional First National Bank, described as "in production" since 1997. It handles customer management, deposit accounts (savings, checking, fixed deposits), teller transactions, consumer loans, interest calculation, end-of-day batch processing, and audit logging.

The code is spread across 12 MUMPS routines totaling roughly 2,500 lines. Some routines are well-commented; others read like someone was in a hurry. There are dead code paths, hardcoded values that should be configurable, a comment about a "temporary fix" from 2012, and business logic that becomes clear only after tracing through multiple files.

A minimal context document is provided. Everything else you learn about the system, you learn from the code.

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-11-mumps-banking/`. Read the [system context](../challenges/challenge-11-mumps-banking/docs/system-context.md) first, then start exploring the `routines/` directory before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-11-mumps-banking/` with Java 21, Python 3.11, Node.js LTS, and an install script for YottaDB if you want to run the original MUMPS code. See the [running instructions](../challenges/challenge-11-mumps-banking/docs/running-the-app.md) for setup and usage details.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should include:

- That you are working with a legacy MUMPS banking application and translating it to [your target language]
- The MUMPS conventions: `^GLOBAL` = persistent database, `$ORDER` = iteration, `$PIECE` = string splitting, abbreviated commands (S=SET, W=WRITE, I=IF, D=DO, Q=QUIT, F=FOR, N=NEW, K=KILL, L=LOCK, R=READ)
- Your target language and framework conventions
- That you want Copilot to explain MUMPS idioms when asked and to preserve business logic exactly during translation
- Non-negotiable: a translated routine must match the original's behavior, including its quirks, unless a quirk is a documented bug you're explicitly asked to fix

### Suggested custom agents

- Use a MUMPS Archaeologist Agent to explain a routine's business rules, data flow, and globals before translating it.
- Use a Banking Domain Agent to explain the intent behind interest calculations, loan amortization, and audit rules that the code leaves unstated.
- Use a Translation Agent to propose target-language code from documented rules and the chosen stack. Verify the original behavior before using it.

### Suggested custom skills

- A Business Rule Documentation Skill records a routine's rules in plain language in a shared document before translation.
- A Behavior Parity Check Skill compares MUMPS output from YottaDB with translated output for the same inputs, including known quirks.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "legacy code translation agent", "characterization testing skill", and "banking domain instructions" before you draft your own.

---

## Tips for using Copilot on this track

- MUMPS is in Copilot's training data, but it is not a primary language. Expect Copilot to need more guidance than usual. Paste code blocks and ask for line-by-line explanations.
- Use `@workspace` and `#file` to point Copilot at specific routines.
- Describe the business rule first ("this function calculates monthly loan payment using the PMT formula"), then ask for its equivalent in the target language.
- Agent mode is strong for generating test scaffolding. Describe the test scenarios and let Copilot wire up the framework.
- The `/explain` command works on MUMPS files. Use it on the dense routines (BNKTXN, BNKINTR) to build your understanding.

## Resources

- [MUMPS Language Overview (Wikipedia)](https://en.wikipedia.org/wiki/MUMPS)
- [YottaDB Documentation](https://docs.yottadb.com/)
- [MUMPS Programming Language Tutorial](https://www.cs.uni.edu/~okane/)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-11-mumps-modernization-track/stages.md)
