# Drift Response

Use this runbook when Terraform state and Azure state disagree.

## First Five Minutes

1. Stop automatic applies for the affected environment.
2. Save the failing workflow run, provider error, or refresh-only plan output.
3. Identify whether the drift affects state storage, networking, identity, or the application platform.
4. Decide whether the resource is safe to change during business hours.

## Commands to Capture Evidence

```bash
terraform -chdir=terraform/azure init -backend=false
terraform -chdir=terraform/azure plan -refresh-only -no-color
```

Add Azure CLI commands for the specific resource you are checking. Do not paste credentials or secret values into this file.

## Decision Matrix

| Situation | Likely Action | Notes |
|-----------|---------------|-------|
| Azure change was accidental and Terraform is still correct | Revert the Azure change or run apply after review | Attach the refresh-only plan to the PR |
| Azure change was intentional emergency work | Update Terraform, then apply after approval | Explain why the portal change happened |
| Resource exists in Azure but not in Terraform state | Import or recreate | Prefer import when replacement would cause outage |
| Terraform wants to replace state, network, or identity resources | Block and review | Replacement may be valid, but not casual |

## Failure Drill

Use `docs/drift-incident-evidence.md` as the starting point.

- What changed outside Terraform?
- Is the code or Azure the source of truth now?
- Which command proves your answer?
- Who approves the repair?
