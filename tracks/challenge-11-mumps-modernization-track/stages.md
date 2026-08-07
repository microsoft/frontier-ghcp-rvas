# Legacy MUMPS Modernization: Phases

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Code Archaeology](phase-1-archaeology.md) | 2-3 hours | Reverse-engineer the codebase, document architecture, map data model |
| 2 | [Characterization Testing](phase-2-testing.md) | 2-3 hours | Write tests that capture current behavior in your target language |
| 3 | [Feature Evolution](phase-3-evolution.md) | 1.5-2 hours | Extend the system with new features (in MUMPS or target language) |
| 4 | [Language Translation](phase-4-translation.md) | 2.5-3 hours | Translate the full system to your chosen modern language |

Each phase builds on the previous. The archaeology phase is critical -- if you skip understanding the code, the translation phase will produce a broken system.

> **Short on time?** Focus on Phases 1 and 4. Translate the core transaction module (BNKTXN) and account module (BNKACCT) rather than the full system. Skip Phase 3 entirely.

---

Previous: [Track Overview](../challenge-11-mumps-modernization-track.md) | Next: [Phase 1: Code Archaeology](phase-1-archaeology.md)
