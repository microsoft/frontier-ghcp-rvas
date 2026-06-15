# Phase 3: Identity and Secrets

[Back to Challenge 21: Azure Terraform Track](../challenge-21-azure-terraform-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 45-60 min

The platform exists, but it still is not safe to hand to an application team. This phase adds the identity and secret wiring that usually turns a quick demo environment into a real platform conversation.

## Scenario Notes

The app team wants one identity it can reuse across environments. Security prefers a narrower identity per environment. Operations wants secret rotation to avoid code changes. Nobody has written down which secret values the app actually needs.

Before writing more HCL, decide what the app should be allowed to read and how that decision changes between dev and prod.

## Tasks

1. Choose a managed identity approach for the app platform and implement it in Terraform. Be explicit about why you picked system-assigned or user-assigned identity.
2. Provision Key Vault and wire access so the platform can read only the secrets it needs. Keep the access model narrow.
3. Configure the application platform to reference secrets through Azure-native mechanisms instead of hard-coded values in Terraform files.
4. Write `docs/identity-review.md` with the identity choice, Key Vault access model, secret rotation assumption, and one permission you intentionally did not grant.
5. Review the plan for over-broad permissions, unnecessary outputs, and any secret material that should not live in source control.

## Review Gate

Ask Copilot to review the identity and Key Vault plan for least privilege. Make it compare system-assigned and user-assigned identity for this scenario, then check whether your Terraform exposes sensitive values through variables, outputs, or example files.

## Verification

- No application secret values are hard-coded in tracked Terraform files
- The managed identity and Key Vault permissions are narrow enough to explain clearly
- `terraform validate` still passes after the identity and secret changes
- Outputs expose references that are safe to share, not sensitive values
- `docs/identity-review.md` explains the selected identity model and the permissions you avoided

## What Copilot Helps With vs. What Requires Your Judgment

Copilot will generate identity blocks and Key Vault wiring, but it is not reliable at least-privilege decisions. You need to decide what the application actually needs, because Azure will happily let you ship a wider access model than necessary. Use Copilot to pressure-test the access model, not to bless it.

---

Previous: [Phase 2: Network and App Platform](phase-2-network-and-platform.md) | Next: [Phase 4: Modules and Environment Promotion](phase-4-modules-and-environments.md)
