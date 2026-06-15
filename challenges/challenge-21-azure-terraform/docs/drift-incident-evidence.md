# Drift Incident Evidence

Use this evidence during Phase 5. Treat it like a ticket from operations, not a solved problem.

## Incident Snapshot

- Environment: dev
- Region: eastus2
- Reported by: operations
- Symptom: a refresh-only plan no longer matches the last approved pull request

## Observed Azure State

```text
resource: azurerm_storage_account.tfstate
public_network_access_enabled: true
shared_access_key_enabled: true
blob_delete_retention_days: 7
```

```text
resource: module.app.azurerm_log_analytics_workspace.this
retention_in_days: 30
```

## Terraform Expectations

```text
enable_storage_public_network_access = false
enable_storage_account_keys          = false
blob_retention_days                  = 14
log_retention_days                   = 30
```

## Review Questions

- [ ] Which differences are drift, and which are expected because the code changed after the last apply?
- [ ] Which change should be reverted in Azure instead of imported into Terraform?
- [ ] Which setting should be revised in Terraform because operations made a valid emergency change?
- [ ] What evidence would you attach to the pull request before approving a repair apply?

## Decision

- Import:
- Revert manually:
- Revise Terraform:
- Block until reviewed by:
