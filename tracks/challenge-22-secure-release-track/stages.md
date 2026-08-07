# Secure Release Review: Stages

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Trust Boundaries and Threats](stage-1-trust-boundaries-and-threats.md) | ⭐⭐⭐ | 55-70 min | Threat model with actors, assets, boundaries, abuse cases, and assumptions |
| 2 | [Identity, Secrets, and Dependencies](stage-2-auth-secrets-and-dependencies.md) | ⭐⭐⭐ | 70-85 min | Prioritized findings and dependency/secret review with evidence |
| 3 | [Targeted Remediations and Security Tests](stage-3-remediations-and-tests.md) | ⭐⭐⭐ | 90-110 min | Narrow fixes with security regression tests and recorded results |
| 4 | [Release Evidence and Residual Risk](stage-4-release-evidence-and-risk.md) | ⭐⭐⭐ | 60-75 min | Residual-risk record, secure-release checklist, and release recommendation |

The work follows a release review rather than a vulnerability scavenger hunt.
Map what crosses trust boundaries, prove the important gaps, repair a focused
set, then decide whether the remaining risk is acceptable.

> **Short on time?** Complete Stages 1, 2, and 4, then remediate one
> release-blocking finding from Stage 3 with a regression test.

---

Previous: [Track Overview](../challenge-22-secure-release-track.md) | Next: [Stage 1: Trust Boundaries and Threats](stage-1-trust-boundaries-and-threats.md)
