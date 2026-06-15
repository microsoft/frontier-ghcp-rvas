# Phase 2: Network and App Platform

[Back to Challenge 21: Azure Terraform Track](../challenge-21-azure-terraform-track.md)

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

With state and naming cleaned up, you can build the first real slice of infrastructure. The goal is a small but believable Azure platform that an application team could actually target.

## Scenario Notes

The app team says the first release only needs a simple container host. Security asks for private service access where it matters. The platform lead warns that every private networking choice adds setup and troubleshooting cost. You have enough time to make the baseline credible, not perfect.

Choose a network shape that fits a small internal app and write down what you are deliberately not building yet.

## Tasks

1. Provision the core resource group and virtual network layout for the application environment. Include at least separate subnets for the application platform and private services.
2. Add Log Analytics and any supporting monitoring resources needed for platform diagnostics.
3. Provision an Azure Container Apps environment and the supporting resources it depends on. Define the key outputs another engineer would need for deployment.
4. Create or update `docs/plan-review.md` with a plan summary for this phase. Include expected creates, anything that would replace an existing resource, and one network trade-off you made.
5. Review the dependency chain with Copilot and remove any accidental ordering issues or unnecessary explicit `depends_on` blocks.

## Review Gate

Run a plan before applying. Ask Copilot to explain the plan as if it were reviewing a pull request: what changes, what could break, what looks overbuilt, and what outputs another team would need. Keep the useful critique in `docs/plan-review.md`.

## Verification

- `terraform plan` shows the expected platform resources without replacement churn from Phase 1
- The network layout is readable and separated by purpose
- Outputs expose the resource group, region, and application platform identifiers you would need later
- Monitoring resources are wired into the platform instead of existing as dead resources
- `docs/plan-review.md` captures the network choice and at least one rejected design option

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can generate the basic Azure resource shapes quickly. You still need to decide network boundaries, address space, and whether the platform design is small-team practical or already drifting into overengineering. A large generated network is not automatically better. Make Copilot argue for every extra subnet, private endpoint, or output.

---

Previous: [Phase 1: State and Naming Baseline](phase-1-state-and-naming.md) | Next: [Phase 3: Identity and Secrets](phase-3-identity-and-secrets.md)
