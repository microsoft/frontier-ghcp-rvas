# Challenge 21 Track: Azure Terraform

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐

**Focus:** Building and defending an Azure platform baseline with Terraform -- remote state, reusable modules, identity, policy checks, CI guardrails, and plan review discipline

## Who Is This For

- Platform engineers standardizing Azure environments
- DevOps engineers who manage Terraform in real repositories
- Backend or full-stack developers who own their team's cloud infrastructure
- Technical leads who need a repeatable Azure foundation for multiple environments

## Prerequisites

- An Azure subscription with permission to create resource groups, storage accounts, networking resources, managed identities, and Key Vault
- Basic familiarity with Terraform workflows (`init`, `fmt`, `validate`, `plan`, `apply`)
- Comfort reading HCL and understanding Azure resource relationships
- Basic GitHub Actions knowledge for the CI phase
- Azure CLI installed and authenticated if you want to run the plans against a real subscription

> ⚠️ **No Azure subscription?** You can still complete most of the track by focusing on `terraform fmt`, `terraform validate`, module structure, variable design, and pipeline generation. Treat the live `plan` and `apply` steps as design exercises if you cannot provision resources.

## Technology Stack

- **Terraform** -- Infrastructure as Code
- **AzureRM provider** -- Azure resource provisioning
- **Azure Storage** -- remote state backend
- **Azure Container Apps** -- application hosting target
- **Azure Key Vault and Managed Identity** -- secrets and identity
- **GitHub Actions** -- validation and deployment workflow

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Your Azure subscription, tenant, and preferred deployment regions
- Naming conventions for resource groups, storage, identities, and tags
- Whether your team prefers system-assigned or user-assigned managed identities by default
- Terraform version and provider pinning rules
- Promotion rules between dev and prod, including who approves applies

### Suggested Agents

**Agents to consider creating:**

- **Terraform Reviewer Agent** -- Focused on module shape, variable hygiene, and plan readability
- **Azure Identity Agent** -- Checks managed identity, RBAC, and Key Vault access design
- **CI Guardrail Agent** -- Reviews GitHub Actions, policy checks, and drift handling

### Open the Challenge

Navigate to `challenges/challenge-21-azure-terraform/`. The challenge is built around a small internal operations app that needs a clean Azure foundation before rollout to multiple regions. Focus on `terraform/azure/`, `modules/`, and `docs/` rather than application code.

This challenge should use its own devcontainer at `.devcontainer/challenge-21-azure-terraform/` so the Terraform, Azure CLI, and validation tooling stay isolated from the other tracks.

The starter scaffold includes constrained Terraform inputs, a TFLint configuration, a pull request validation workflow, and evidence files under `docs/`. Treat those files as prompts for review. They are intentionally incomplete, because the work is deciding what the team should accept, block, or document.

### Working Scenario

You are taking over infrastructure for an internal operations app. The app is not mission-critical yet, but it handles operational data that the team does not want exposed. Three stakeholders have left you with requirements that do not line up cleanly:

- The platform lead wants one Terraform pattern that can support dev and prod without a separate rewrite later.
- The application team wants a fast path to a working dev environment and does not want a heavy approval process for every small change.
- Security wants private networking where practical, narrow identity permissions, no secrets in source control, and a clear drift response before production rollout.

Your job is to make the smallest responsible Azure baseline and explain the trade-offs. Do not build a full enterprise landing zone. Do not accept generated HCL until you can explain the plan it produces.

### Required Participant Artifacts

Create these files under `challenges/challenge-21-azure-terraform/docs/` as you work:

- `platform-notes.md` -- state bootstrap order, naming rules, tags, and open assumptions
- `plan-review.md` -- plan review notes for at least two phases, including one risk you rejected
- `identity-review.md` -- managed identity and Key Vault access decisions
- `environment-promotion.md` -- dev-to-prod differences and approval rules
- `drift-response.md` -- incident steps for drift, failed apply, import, and rollback decisions

Keep the notes short. A reviewer should be able to tell why you made each decision without reading every Terraform file.

---

## Phases

| Phase | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [State and Naming Baseline](challenge-21-azure-terraform-track/phase-1-state-and-naming.md) | ⭐⭐ | 45-60 min | Remote state bootstrap, provider constraints, naming and tagging rules with assumptions documented |
| 2 | [Network and App Platform](challenge-21-azure-terraform-track/phase-2-network-and-platform.md) | ⭐⭐ | 45-60 min | VNet, subnets, Log Analytics, Container Apps environment, and plan review notes |
| 3 | [Identity and Secrets](challenge-21-azure-terraform-track/phase-3-identity-and-secrets.md) | ⭐⭐⭐ | 45-60 min | Managed identity, Key Vault access, secret wiring, and least-privilege review |
| 4 | [Modules and Environment Promotion](challenge-21-azure-terraform-track/phase-4-modules-and-environments.md) | ⭐⭐⭐ | 60-75 min | Reusable modules, environment rules, validation checks, and promotion notes |
| 5 | [Policy, CI, and Drift Response](challenge-21-azure-terraform-track/phase-5-policy-ci-and-drift.md) | ⭐⭐⭐ | 60-75 min | GitHub Actions plan workflow, policy gates, and a drift response runbook |

The phases follow the order most teams hit in real work: get state under control, stand up the platform, lock down identity, turn the layout into something reusable, then add the checks that stop bad changes from slipping through.

> **Short on time?** Complete Phases 1, 2, and 5. That gives you a usable Azure Terraform baseline, a real hosting target, and the pipeline guardrails most teams need first.

## Tips for Using Copilot on This Track

- Use Copilot as a reviewer before you use it as a generator. Ask it to compare two designs, find plan risks, and challenge your assumptions.
- Start each Terraform file with a short comment describing the resources, naming rules, and environment assumptions. Copilot does better when the infrastructure intent is explicit.
- Ask Copilot to explain a `terraform plan` diff before you accept it. That is the fastest way to catch an accidental replacement or a missing dependency.
- When generating variables, ask for descriptions, validation, and sensible defaults in the same prompt. Otherwise you usually get empty shells.
- Have Copilot review modules for implicit dependencies and output sprawl. Terraform that technically works can still be miserable to maintain.
- For GitHub Actions, tell Copilot which steps should block merges and which ones are advisory. It will otherwise treat every check as equal.
- If a generated resource looks plausible but unfamiliar, ask Copilot which Azure API or provider schema it is relying on. That often exposes outdated suggestions quickly.
- Before applying, write down one generated suggestion you rejected and why. This is the part of the challenge that proves you understand the infrastructure.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)
