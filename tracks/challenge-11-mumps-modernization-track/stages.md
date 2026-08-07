# Legacy MUMPS Modernization: Stages

## Stages

| Stage | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Code Archaeology](stage-1-archaeology.md) | 2-3 hours | Reverse-engineer the codebase, document architecture, map data model |
| 2 | [Characterization Testing](stage-2-testing.md) | 2-3 hours | Write tests that capture current behavior in your target language |
| 3 | [Feature Evolution](stage-3-evolution.md) | 1.5-2 hours | Extend the system with new features (in MUMPS or target language) |
| 4 | [Language Translation](stage-4-translation.md) | 2.5-3 hours | Translate the full system to your chosen modern language |

Each stage builds on the previous. The archaeology stage is critical -- if you skip understanding the code, the translation stage will produce a broken system.

> **Short on time?** Focus on Stages 1 and 4. Translate the core transaction module (BNKTXN) and account module (BNKACCT) rather than the full system. Skip Stage 3 entirely.

---

Previous: [Track Overview](../challenge-11-mumps-modernization-track.md) | Next: [Stage 1: Code Archaeology](stage-1-archaeology.md)
