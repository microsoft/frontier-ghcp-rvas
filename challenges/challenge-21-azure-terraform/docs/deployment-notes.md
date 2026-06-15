# Deployment Notes

Use this file during Phase 5 to document the deployment workflow, approval path, and rollback approach for the Azure Terraform stack.

## Checks Before Plan Review

- Required:
  - `terraform fmt -recursive -check`
  - `terraform init -backend=false`
  - `terraform validate`
  - TFLint result:
- Advisory:
  - Policy scan:
  - Cost review:

## Apply Approval Path

- Approver role:
- GitHub environment or manual gate:
- Evidence the approver must see before apply:
- Change types that must never auto-apply:

## Failed Apply Response

If `terraform apply` fails halfway through, do not immediately run it again. Capture:

- The resource Terraform was changing when the failure happened
- The Azure activity log event or provider error
- Whether Terraform state contains the partially created resource
- Whether the next action is retry, import, state repair, or manual cleanup

## State Confirmation

- Last refresh-only plan command:
- Azure resource IDs checked manually:
- Drift found:
- Decision: no action / import / revert Azure change / revise Terraform
