# Stage 1: State and naming baseline

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

You inherited a flat Terraform directory with hard-coded names, no remote state, and no agreement on tags. Fix the foundation first.

## Scenario notes

The team requires remote state but has not agreed on naming and tagging. The platform lead wants names that sort cleanly by environment. The application team wants short names that are easy to read in the Azure portal. Finance wants every resource tagged with owner, cost center, environment, and data classification. Azure storage account naming limits constrain all of this.

Settle the naming and tagging before you touch the rest of the platform. Record the rules you chose and the trade-offs you rejected in `docs/platform-notes.md`.

## Tasks

Record naming and tagging rules in your repository instructions. Use the Terraform Reviewer agent to check module and naming choices, then run the plan review skill on the first `terraform plan`. Check its findings yourself.

1. Use `terraform/azure/` as the working Terraform root. Provision the storage account and blob container you want to use for Terraform state, and document the bootstrap order in `docs/platform-notes.md`.
2. Configure the main environment in `terraform/azure/` to use the remote backend. Remove hard-coded resource names and replace them with locals, variables, and a tagging baseline that fits the stakeholder notes.
3. Add provider and Terraform version constraints, plus a `terraform.tfvars.example` that shows the minimum values another engineer would need to supply without exposing real subscription details.
4. Add a short naming decision section to `docs/platform-notes.md`. Include one Azure naming limit you designed around and one stakeholder request you narrowed or deferred.
5. Keep the layout ready for later stages: `terraform/azure/` stays the environment root, and reusable code goes under `modules/`.

## Review gate

Ask Copilot to critique your naming and backend design. Don't ask it to rewrite everything. Ask it to find conflicts with Azure limits, weak tag coverage, and bootstrap steps that would confuse a teammate.

## Verification

- `terraform fmt -check` passes for the files you touched
- `terraform validate` passes in the main environment directory
- The remote backend configuration points at Azure Storage rather than local state
- Naming and tag inputs are centralized instead of repeated across resources
- `docs/platform-notes.md` explains the bootstrap order, naming rules, tag baseline, and unresolved assumptions

## What Copilot helps with vs. what requires your judgment

Copilot can draft provider blocks, backend configuration, and variable declarations. You check that the naming pattern stays readable and within Azure limits across regions and environments.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Network and App Platform](stage-2-network-and-platform.md)
