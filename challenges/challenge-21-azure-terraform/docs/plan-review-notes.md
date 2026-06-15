# Plan Review Notes

Use this file while reading a Terraform plan. Do not paste the full plan. Pull out the few lines a reviewer would actually need to discuss.

## Pull Request Context

- Change owner:
- Environment:
- Region:
- Terraform command used:
- Plan file or run link:

## Evidence to Pull From the Plan

Look for these details before deciding whether to approve:

- The storage account name generated from `name_prefix`. Does it stay inside the Azure storage naming rules after the random suffix?
- The value of `public_network_access_enabled` for the state storage account. Is that acceptable for bootstrap, shared state, both, or neither?
- The value of `shared_access_key_enabled`. If account keys stay enabled, who can use them and where is that documented?
- The `azurerm_log_analytics_workspace` retention period. Is the cost acceptable for the selected environment?
- Any resource marked `-/+` or `forces replacement`, especially resource groups, storage accounts, virtual networks, subnets, or the Container Apps environment.

## Reviewer Notes

- Safe to approve:
- Needs more review:
- Largest blast radius:
- Decision: approve / revise / block

## Follow-Up Questions

- [ ] What should happen if a later plan wants to replace the Terraform state storage account?
- [ ] Which environments should allow public network access during backend bootstrap?
- [ ] Should TFLint block the pull request, or should it only inform reviewers during the workshop?
