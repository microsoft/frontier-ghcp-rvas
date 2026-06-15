# Azure Terraform Platform Scenario

You are inheriting a small internal platform stack used by an app team that deploys a containerized API into Azure. The original author left after getting the first version working.

The team needs this Terraform code cleaned up before it can become the standard for new environments. Their requirements are simple:

- One platform resource group per environment, plus a clear decision about where Terraform state bootstrap resources live
- Shared virtual network with an app subnet
- Azure Storage for Terraform state bootstrap, including a decision about network access and account keys
- Log Analytics and an Azure Container Apps environment for a small internal API
- Consistent tags for owner, environment, cost center, and data classification
- A delivery path that supports plan review before apply

The code in this challenge is close enough to be useful, but not ready to trust. Some defaults are intentionally debatable. Your job is to use Copilot to understand the stack, tighten the guardrails, and write down the trade-offs you keep.

## Current Tensions

- The state storage account is easy to bootstrap, but the public network and account-key choices need review before shared use.
- The approved region list is short. That is deliberate, but it may not match every team or data residency requirement.
- The modules expose only a few knobs. Add validation before adding more variables.
- The workflow validates syntax and linting, but the plan step is waiting on an Azure authentication decision.

Use those tensions as review prompts. Do not smooth them away without documenting the decision.
