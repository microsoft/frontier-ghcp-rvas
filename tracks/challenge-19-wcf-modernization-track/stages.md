# Legacy WCF Banking Modernization: Phases

## Phases

| Phase | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Contract Archaeology](phase-1-archaeology.md) | 2-3 hours | Understand WCF contracts, map service operations, document business rules and faults |
| 2 | [Characterization Tests](phase-2-testing.md) | 1.5-2 hours | Write tests against the running WCF service to pin current behavior |
| 3 | [REST API Migration](phase-3-migration.md) | 2-3 hours | Build an ASP.NET Core Web API that replaces each WCF service operation |
| 4 | [Integration and Hardening](phase-4-hardening.md) | 1-2 hours | Wire up tests against the REST API, fix gaps, add Swagger, write migration notes |

Each phase builds on the previous. Phase 1 is not optional -- if you do not understand the contracts and faults going in, Phase 3 will produce a broken API that silently drops business rules.

> **Short on time?** Focus on Phases 1 and 3. Translate `AccountService` only -- skip `LoanService` and `TransactionService`. Run manual REST tests instead of Phase 4's full test suite.

---

Previous: [Track Overview](../challenge-19-wcf-modernization-track.md) | Next: [Phase 1: Contract Archaeology](phase-1-archaeology.md)
