# Platform Notes

Use this file to capture decisions that should not live only in a chat transcript.

## Naming Decision

- Prefix format:
- Maximum prefix length:
- Azure limit designed around:
- Stakeholder request narrowed or deferred:
- Example resource names:

## Tag Baseline

Required tags:

- `owner`:
- `cost_center`:
- `environment`:
- `data_classification`:
- `managed_by`:

Decision still open:

- Should product or application name be a required tag?
- Should cost center be free text or a constrained value?

## State Bootstrap Order

Draft the order before enabling the backend:

1. Create the bootstrap resource group, storage account, and container with local state.
2. Review storage account network access, account key usage, and soft delete settings.
3. Copy the backend values into `backend.hcl` or the CI secret store.
4. Run `terraform init -migrate-state` only after the backend decision is reviewed.

Open question:

- Which Azure identity should own backend access from GitHub Actions?

## Public Network Decision

- Current value:
- Why this is acceptable or not acceptable:
- What changes before prod:
- Evidence link or plan run:
