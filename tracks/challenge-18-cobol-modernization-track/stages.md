# Legacy COBOL Banking Modernization: Stages

## Stages

| Stage | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Code Archaeology](stage-1-archaeology.md) | 2-3 hours | Reverse-engineer the COBOL codebase, document architecture, map data model |
| 2 | [Characterization Testing](stage-2-testing.md) | 2-3 hours | Write tests that capture current behavior in your target language |
| 3 | [Feature Evolution](stage-3-evolution.md) | 1.5-2 hours | Extend the system with new features |
| 4 | [Full-Stack Modernization](stage-4-modernization.md) | 2.5-3 hours | Build a React frontend + API backend from the COBOL business logic |

Each stage builds on the previous. The archaeology stage is critical -- if you skip understanding the code, the modernization stage will produce a broken system.

> **Short on time?** Focus on Stages 1 and 4. Translate the core transaction program and account program rather than the full system. Skip Stage 3 entirely.

---

Previous: [Track Overview](../challenge-18-cobol-modernization-track.md) | Next: [Stage 1: Code Archaeology](stage-1-archaeology.md)
