# Phase 1: State and Naming Baseline

[Back to Challenge 21: Azure Terraform Track](../challenge-21-azure-terraform-track.md)

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

You inherited a flat Terraform directory with hard-coded names, no remote state, and no agreement on tags. Fix the foundation before you build anything larger on top of it.

## Scenario Notes

The team agrees that remote state is required, but not much else is settled. The platform lead wants names that sort cleanly by environment. The application team wants short names that are easy to read in the Azure portal. Finance wants every resource tagged with owner, cost center, environment, and data classification. Azure storage account names are less forgiving than everyone remembers.

Resolve the naming and tagging tension before you touch the rest of the platform. Record the rules you choose and the trade-offs you reject in `docs/platform-notes.md`.

## Tasks

1. Use `terraform/azure/` as the working Terraform root. Provision the storage account and blob container you want to use for Terraform state, and document the bootstrap order in `docs/platform-notes.md`.
2. Configure the main environment in `terraform/azure/` to use the remote backend. Remove hard-coded resource names and replace them with locals, variables, and a tagging baseline that fits the stakeholder notes.
3. Add provider and Terraform version constraints, plus a `terraform.tfvars.example` that shows the minimum values another engineer would need to supply without exposing real subscription details.
4. Add a short naming decision section to `docs/platform-notes.md`. Include one Azure naming limit you designed around and one stakeholder request you narrowed or deferred.
5. Keep the layout ready for later phases. At minimum, `terraform/azure/` should stay the environment root, while reusable code belongs under `modules/`.

## Review Gate

Before moving on, ask Copilot to critique your naming and backend design. Do not ask it to rewrite everything. Ask it to find conflicts with Azure limits, weak tag coverage, and places where the backend bootstrap order would confuse a teammate.

## Verification

- `terraform fmt -check` passes for the files you touched
- `terraform validate` passes in the main environment directory
- The remote backend configuration points at Azure Storage rather than local state
- Naming and tag inputs are centralized instead of repeated across resources
- `docs/platform-notes.md` explains the bootstrap order, naming rules, tag baseline, and unresolved assumptions

## What Copilot Helps With vs. What Requires Your Judgment

Copilot is useful here for provider blocks, backend structure, and repetitive variable declarations. The judgment call is your naming model: you need names that work across Azure limits, regions, and environments without becoming unreadable six months from now. If Copilot proposes a naming pattern, make it justify the pattern against Azure constraints before you keep it.

---

Next: [Phase 2: Network and App Platform](phase-2-network-and-platform.md)
