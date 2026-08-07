# Legacy WCF Banking Modernization: Stages

## Stages

| Stage | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Contract Archaeology](stage-1-archaeology.md) | 2-3 hours | Understand WCF contracts, map service operations, document business rules and faults |
| 2 | [Characterization Tests](stage-2-testing.md) | 1.5-2 hours | Write tests against the running WCF service to pin current behavior |
| 3 | [REST API Migration](stage-3-migration.md) | 2-3 hours | Build an ASP.NET Core Web API that replaces each WCF service operation |
| 4 | [Integration and Hardening](stage-4-hardening.md) | 1-2 hours | Wire up tests against the REST API, fix gaps, add Swagger, write migration notes |

Each stage builds on the previous. Stage 1 is not optional -- if you do not understand the contracts and faults going in, Stage 3 will produce a broken API that silently drops business rules.

> **Short on time?** Focus on Stages 1 and 3. Translate `AccountService` only -- skip `LoanService` and `TransactionService`. Run manual REST tests instead of Stage 4's full test suite.

---

Previous: [Track Overview](../challenge-19-wcf-modernization-track.md) | Next: [Stage 1: Contract Archaeology](stage-1-archaeology.md)
