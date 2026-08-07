# Challenge 11 Track: Legacy MUMPS Modernization

**Duration:** 8-12 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Legacy code comprehension, characterization testing, feature evolution, and language translation -- using GitHub Copilot to tame a codebase most developers have never seen

## Who Is This For

- Developers who enjoy reverse-engineering unfamiliar systems
- Engineers dealing with legacy modernization at work (COBOL, MUMPS, RPG, or similar)
- Anyone curious about how Copilot handles obscure languages and large-scale translation tasks
- Teams that finished a standard track and want a fundamentally different kind of challenge

## Prerequisites

- Solid programming skills in at least one modern language (PSL, Java, Python, C#, TypeScript)
- Comfort reading code you don't fully understand and building a mental model from it
- Basic understanding of banking concepts (accounts, transactions, interest, loans)
- No prior MUMPS experience required -- figuring it out is part of the challenge

## Technology Stack

- **Source language:** MUMPS (M) -- a language with a built-in hierarchical database, used heavily in healthcare and banking since the 1960s
- **Runtime (optional):** YottaDB -- open-source MUMPS implementation for running the original code
- **Target language:** Your choice -- PSL and Java are the recommended options, but Python, C#, TypeScript, or any other language works. PSL is a natural fit if you have FIS Profile experience; Java is the most common modernization target in banking.
- **Testing:** JUnit, pytest, or your preferred test framework for the target language

## What You Are Working With

The codebase is a **core banking system** for a fictional bank called First National Bank. It has been "in production" since 1997 and shows its age. The system handles customer management, deposit accounts (savings, checking, fixed deposits), teller transactions, consumer loans, interest calculation, end-of-day batch processing, and audit logging.

The code is spread across 12 MUMPS routines totaling roughly 2,500 lines. Some routines are well-commented; others read like someone was in a hurry. There are dead code paths, hardcoded values that should be configurable, a comment about a "temporary fix" from 2012, and business logic that becomes clear only after tracing through multiple files.

A minimal context document is provided. Everything else you learn about the system, you learn from the code.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are working with a legacy MUMPS banking application and translating it to [your target language]
- The MUMPS conventions: `^GLOBAL` = persistent database, `$ORDER` = iteration, `$PIECE` = string splitting, abbreviated commands (S=SET, W=WRITE, I=IF, D=DO, Q=QUIT, F=FOR, N=NEW, K=KILL, L=LOCK, R=READ)
- Your target language and framework conventions
- That you want Copilot to explain MUMPS idioms when asked and to preserve business logic exactly during translation

### Suggested Agents

- **MUMPS Archaeologist Agent** -- Reads MUMPS code and explains what it does, identifies business rules, draws out data flows. Knows MUMPS syntax, global structure, and common idioms.
- **Banking Domain Agent** -- Understands core banking concepts: account types, interest calculation methods (simple vs. compound, day-count conventions), loan amortization, transaction atomicity, and audit requirements.
- **Translation Agent** -- Takes documented MUMPS business logic and produces idiomatic code in your target language, preserving behavior exactly while using modern patterns (classes, dependency injection, proper error handling).

### Open the Challenge

Navigate to `challenges/challenge-11-mumps-banking/`. Read the [system context](../challenges/challenge-11-mumps-banking/docs/system-context.md) first, then start exploring the `routines/` directory.

A dedicated devcontainer is provided at `.devcontainer/challenge-11-mumps-banking/` with Java 21, Python 3.11, Node.js LTS, and an install script for YottaDB if you want to run the original MUMPS code. See the [running instructions](../challenges/challenge-11-mumps-banking/docs/running-the-app.md) for setup and usage details.

---

## Tips for Using Copilot on This Track

- MUMPS is in Copilot's training data, but it is not a primary language. Expect Copilot to need more guidance than usual. Paste code blocks and ask for line-by-line explanations.
- Use `@workspace` and `#file` references extensively -- point Copilot at specific routines when asking questions.
- For translation, describe the business rule first ("this function calculates monthly loan payment using the PMT formula"), then ask for the equivalent in your target language. Do not ask Copilot to "translate this MUMPS" cold -- it works better when you give it the intent.
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

Next: [Phases](challenge-11-mumps-modernization-track/phases.md)
