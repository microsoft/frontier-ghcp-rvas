# Stage 2: Network and app platform

**Difficulty:** ⭐⭐ | **Time:** 45-60 min

With state and naming settled, build a small Azure platform that the application team can deploy to.

## Scenario notes

The app team needs a simple container host for the first release. Security asks for private service access where it matters. The platform lead warns that each private networking choice adds setup and troubleshooting cost.

Choose a network shape that fits a small internal app and write down what you are deliberately not building yet.

## Tasks

1. Provision the core resource group and virtual network layout for the application environment. Include at least separate subnets for the application platform and private services.
2. Add Log Analytics and any supporting monitoring resources needed for platform diagnostics.
3. Provision an Azure Container Apps environment and the supporting resources it depends on. Define the key outputs another engineer would need for deployment.
4. Create or update `docs/plan-review.md` with a plan summary for this stage. Include expected creates, anything that would replace an existing resource, and one network trade-off you made.
5. Review the dependency chain with Copilot and remove any accidental ordering issues or unnecessary explicit `depends_on` blocks.

## Review gate

Run a plan before applying. Ask Copilot to explain the plan as if it were reviewing a pull request: what changes, what could break, what looks overbuilt, and what outputs another team would need. Keep the useful critique in `docs/plan-review.md`.

## Verification

- `terraform plan` shows the expected platform resources without replacement churn from Stage 1
- The network layout is readable and separated by purpose
- Outputs expose the resource group, region, and application platform identifiers you would need later
- Monitoring resources are wired into the platform instead of existing as dead resources
- `docs/plan-review.md` captures the network choice and at least one rejected design option

## What Copilot helps with vs. what requires your judgment

Copilot can draft Azure resources. You decide the network boundaries and address space. Check whether every subnet, private endpoint, and output is needed for this app.

---

Previous: [Stage 1: State and Naming Baseline](stage-1-state-and-naming.md) | Next: [Stage 3: Identity and Secrets](stage-3-identity-and-secrets.md)
