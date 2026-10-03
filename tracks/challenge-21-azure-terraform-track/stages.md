# Azure Terraform: Stages

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [State and Naming Baseline](stage-1-state-and-naming.md) | ⭐⭐ | 45-60 min | Remote state bootstrap, provider constraints, naming and tagging rules with assumptions documented |
| 2 | [Network and App Platform](stage-2-network-and-platform.md) | ⭐⭐ | 45-60 min | VNet, subnets, Log Analytics, Container Apps environment, and plan review notes |
| 3 | [Identity and Secrets](stage-3-identity-and-secrets.md) | ⭐⭐⭐ | 45-60 min | Managed identity, Key Vault access, secret wiring, and least-privilege review |
| 4 | [Modules and Environment Promotion](stage-4-modules-and-environments.md) | ⭐⭐⭐ | 60-75 min | Reusable modules, environment rules, validation checks, and promotion notes |
| 5 | [Policy, CI, and Drift Response](stage-5-policy-ci-and-drift.md) | ⭐⭐⭐ | 60-75 min | GitHub Actions plan workflow, policy gates, and a drift response runbook |

Configure state before provisioning the platform. Add identity controls, extract reusable modules, then define CI and recovery checks.

> **Short on time?** Complete Stages 1, 2, and 5 for a Terraform baseline, hosting target, and CI checks.

---

Previous: [Track Overview](../challenge-21-azure-terraform-track.md) | Next: [Stage 1: State and Naming Baseline](stage-1-state-and-naming.md)
