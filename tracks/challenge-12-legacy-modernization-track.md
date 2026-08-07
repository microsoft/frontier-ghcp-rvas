# Challenge 12 Track: Legacy Code Modernization

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Reverse-engineering undocumented Java code, recovering business logic, migrating to modern frameworks, and capturing knowledge in Copilot-readable formats

## Who Is This For

- Developers who inherit and maintain systems they did not build
- Engineers dealing with outdated Java applications (Spring Boot 1.x, Java 8, deprecated libraries)
- Teams where the original developer has left and documentation is missing or nonexistent
- Anyone who wants to practice using Copilot as a knowledge recovery tool

## Prerequisites

- Solid Java skills (you will read and rewrite real Java code)
- Basic understanding of Spring Boot concepts (controllers, dependency injection, request mapping)
- Familiarity with REST API patterns
- No prior knowledge of the legacy codebase required -- figuring it out is the challenge

## Technology Stack

- **Source codebase:** Java 8, Spring Boot 1.5.22, Gson, Apache HttpClient 4.x, Log4j 1.x, H2 database
- **Target stack:** Java 17+, Spring Boot 3.x, Jackson, java.net.http, SLF4J/Logback
- **Testing:** JUnit 5, Spring Boot Test
- **Build:** Maven

## What You Are Working With

The codebase is the **Acme Bank Account Manager** -- a mid-size banking API that has been in production since 2016. The original contractor left in 2018 and three different developers have maintained it since, none of whom documented anything. The system handles customer management, account operations (checking, savings, fixed deposits), transfers, interest calculation, tier management, and reporting.

The code has several intentional problems: SQL injection vulnerabilities, no service layer, deprecated libraries with known security issues, missing input validation, dead code from a cancelled project, business logic buried in controller methods, and zero tests.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-12-legacy-modernization/`. Read the [system context](../challenges/challenge-12-legacy-modernization/docs/system-context.md) first, then explore the `src/` directory before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-12-legacy-modernization/` with Java 8 (to compile the legacy code), Maven, and Node.js LTS. During the migration phase, you will update the `pom.xml` to target Java 17+ and install a newer JDK (e.g., `sdk install java 21-tem` via SDKMAN) to compile the migrated code.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are modernizing a legacy Java 8 / Spring Boot 1.5 banking application
- The target stack: Java 17+, Spring Boot 3.x, proper layered architecture, JUnit 5
- Your coding conventions (package naming, exception handling approach, API response format)
- That Copilot should flag security issues, deprecated APIs, and missing tests when reviewing code
- Non-negotiable: preserve existing business behavior during migration -- fix security and structure, not the rules

### Suggested Custom Agents

- **Code Archaeologist Agent** -- Reads Java code and explains business logic, design patterns (or anti-patterns), and data flow through controllers and queries. Give it a controller or class; it returns a plain-language walkthrough. Use it before any migration work starts.
- **Migration Advisor Agent** -- Recommends specific migration steps: which libraries to replace, which APIs changed between Spring Boot 1.x and 3.x, and what order to do them in. Give it the current `pom.xml` and target stack; it proposes a sequenced plan. Use it once you understand what the code currently does.
- **Security Auditor Agent** -- Identifies SQL injection, insecure dependencies, missing validation, and other OWASP Top 10 issues, and proposes fixes with examples. Give it a controller or query; it returns findings. Use it as a pass before and after migration.

### Suggested Custom Skills

- **Dependency Upgrade Skill** -- A fixed sequence: check `pom.xml` for deprecated or vulnerable libraries, plan the javax-to-jakarta and Spring Boot 1.x-to-3.x replacement order, then upgrade one dependency at a time, verifying compilation after each.
- **Controller-to-Service Extraction Skill** -- A repeatable refactor workflow: pull business logic out of a controller method into a service class, preserving behavior, then add the test that was missing before the move.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "legacy code archaeology agent", "dependency migration skill", and "spring boot instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Use `/explain` on each controller file. Follow up with targeted questions: "What business rule does the interest calculation implement?" or "What happens when a transfer fails halfway through?"
- Point Copilot at the `pom.xml` and ask "Which dependencies are deprecated or have known security vulnerabilities?" -- it will flag Log4j 1.x, old HttpClient, and outdated Spring Boot.
- For migration, work module by module rather than everything at once. Have Copilot generate the updated `pom.xml` first, then tackle each controller.
- Use `@workspace` to help Copilot understand cross-file relationships when business logic spans multiple controllers.
- Create your `.github/copilot-instructions.md` early -- it makes every subsequent Copilot interaction more accurate.
- Agent mode works well for generating test scaffolding. Describe the scenario and let Copilot build the test class.

## Resources

- [Spring Boot 1.x to 3.x Migration Guide](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Migration-Guide)
- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-12-legacy-modernization-track/stages.md)
