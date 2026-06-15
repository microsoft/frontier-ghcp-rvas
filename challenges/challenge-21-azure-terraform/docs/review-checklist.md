# Terraform Review Checklist

Use this checklist when reviewing your own pull request. Leave short notes beside anything you cannot prove from the Terraform or the plan.

## Naming and Tags

- [ ] Resource names follow one pattern, but still respect Azure-specific limits such as storage account length and allowed characters.
- [ ] Required tags are applied through one shared mechanism.
- [ ] `owner`, `cost_center`, `environment`, and `data_classification` have useful values, not placeholders.
- [ ] The state file key naming convention separates environment and region without leaking customer or team names.

## State and Access

- [ ] The backend bootstrap order is documented before remote state is enabled.
- [ ] Public network access on the state storage account is intentional, temporary, or replaced with a private access path.
- [ ] Storage account keys are either justified for bootstrap or replaced with an Entra ID based backend path.
- [ ] Blob and container soft delete settings match the recovery story for this environment.

## Modules and Platform Shape

- [ ] Module inputs are constrained enough to stop obvious mistakes before `apply`.
- [ ] Outputs expose deployment references, not implementation trivia.
- [ ] The network layout is small enough for the workshop but still has a clear next step for private services.
- [ ] Log retention is a deliberate cost and operations decision.

## Plan and Workflow

- [ ] The plan has no surprise replacement of state, network, or platform resources.
- [ ] CI checks that block merges are separate from checks that only inform reviewers.
- [ ] The apply path requires human approval and does not run blindly on every merge.
- [ ] Drift response notes explain when to import, revert, or repair Azure resources.
