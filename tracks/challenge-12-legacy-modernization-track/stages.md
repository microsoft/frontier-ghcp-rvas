# Legacy Code Modernization: Stages

## Stages

| Stage | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Code Archaeology](stage-1-archaeology.md) | 1.5-2 hours | Reverse-engineer the codebase, document architecture and business rules |
| 2 | [Security and Debt Audit](stage-2-audit.md) | 1-1.5 hours | Identify vulnerabilities, deprecated libraries, and technical debt |
| 3 | [Test Harness](stage-3-tests.md) | 1.5-2 hours | Write characterization tests that capture current behavior |
| 4 | [Migration](stage-4-migration.md) | 2-3 hours | Upgrade to Spring Boot 3.x, replace deprecated libraries, fix architecture |

Each stage builds on the previous. The archaeology stage is foundational -- if you skip understanding the code, the migration will introduce regressions.

> **Short on time?** Focus on Stages 1 and 3. Understanding the code and writing tests delivers value even without the migration.

---

Previous: [Track Overview](../challenge-12-legacy-modernization-track.md) | Next: [Stage 1: Code Archaeology](stage-1-archaeology.md)
