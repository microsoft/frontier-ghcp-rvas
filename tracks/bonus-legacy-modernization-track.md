# Bonus Track: Legacy Code Modernization

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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are modernizing a legacy Java 8 / Spring Boot 1.5 banking application
- The target stack: Java 17+, Spring Boot 3.x, proper layered architecture, JUnit 5
- Your coding conventions (package naming, exception handling approach, API response format)
- That Copilot should flag security issues, deprecated APIs, and missing tests when reviewing code

### Suggested Agents

- **Code Archaeologist Agent** -- Reads Java code and explains business logic, identifies design patterns (or anti-patterns), traces data flow through controllers and database queries. Knows Spring Boot 1.x and 3.x differences.
- **Migration Advisor Agent** -- Recommends specific migration steps: which libraries to replace, which APIs changed between Spring Boot 1.x and 3.x (javax to jakarta, etc.), and what order to do them in.
- **Security Auditor Agent** -- Identifies SQL injection, insecure dependencies, missing input validation, and other OWASP Top 10 issues. Proposes fixes with code examples.

### Open the Challenge

Navigate to `challenges/bonus-6-legacy-modernization/`. Read the [system context](../challenges/bonus-6-legacy-modernization/docs/system-context.md) first, then explore the `src/` directory.

A dedicated devcontainer is provided at `.devcontainer/bonus-6-legacy-modernization/` with Java 8 (to compile the legacy code), Maven, and Node.js LTS. During the migration phase, you will update the `pom.xml` to target Java 17+ and install a newer JDK (e.g., `sdk install java 21-tem` via SDKMAN) to compile the migrated code.

---

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Code Archaeology](bonus-legacy-modernization-track/phase-1-archaeology.md) | 1.5-2 hours | Reverse-engineer the codebase, document architecture and business rules |
| 2 | [Security and Debt Audit](bonus-legacy-modernization-track/phase-2-audit.md) | 1-1.5 hours | Identify vulnerabilities, deprecated libraries, and technical debt |
| 3 | [Test Harness](bonus-legacy-modernization-track/phase-3-tests.md) | 1.5-2 hours | Write characterization tests that capture current behavior |
| 4 | [Migration](bonus-legacy-modernization-track/phase-4-migration.md) | 2-3 hours | Upgrade to Spring Boot 3.x, replace deprecated libraries, fix architecture |

Each phase builds on the previous. The archaeology phase is foundational -- if you skip understanding the code, the migration will introduce regressions.

> **Short on time?** Focus on Phases 1 and 3. Understanding the code and writing tests delivers value even without the migration.

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
