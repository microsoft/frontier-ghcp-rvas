# Azure Terraform: Phases

## Phases

| Phase | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [State and Naming Baseline](phase-1-state-and-naming.md) | ⭐⭐ | 45-60 min | Remote state bootstrap, provider constraints, naming and tagging rules with assumptions documented |
| 2 | [Network and App Platform](phase-2-network-and-platform.md) | ⭐⭐ | 45-60 min | VNet, subnets, Log Analytics, Container Apps environment, and plan review notes |
| 3 | [Identity and Secrets](phase-3-identity-and-secrets.md) | ⭐⭐⭐ | 45-60 min | Managed identity, Key Vault access, secret wiring, and least-privilege review |
| 4 | [Modules and Environment Promotion](phase-4-modules-and-environments.md) | ⭐⭐⭐ | 60-75 min | Reusable modules, environment rules, validation checks, and promotion notes |
| 5 | [Policy, CI, and Drift Response](phase-5-policy-ci-and-drift.md) | ⭐⭐⭐ | 60-75 min | GitHub Actions plan workflow, policy gates, and a drift response runbook |

The phases follow the order most teams hit in real work: get state under control, stand up the platform, lock down identity, turn the layout into something reusable, then add the checks that stop bad changes from slipping through.

> **Short on time?** Complete Phases 1, 2, and 5. That gives you a usable Azure Terraform baseline, a real hosting target, and the pipeline guardrails most teams need first.

---

Previous: [Track Overview](../challenge-21-azure-terraform-track.md) | Next: [Phase 1: State and Naming Baseline](phase-1-state-and-naming.md)
