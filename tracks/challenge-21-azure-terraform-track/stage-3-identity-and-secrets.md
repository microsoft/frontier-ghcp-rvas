# Stage 3: Identity and secrets

**Difficulty:** ⭐⭐⭐ | **Time:** 45-60 min

Add managed identity and secret access before handing the platform to the application team.

## Scenario notes

The app team wants one identity it can reuse across environments. Security prefers a narrower identity per environment. Operations wants secret rotation to avoid code changes. Nobody has written down which secret values the app actually needs.

Before writing more HCL, decide what the app should be allowed to read and how that decision changes between dev and prod.

## Tasks

1. Choose a managed identity approach for the app platform and implement it in Terraform. Be explicit about why you picked system-assigned or user-assigned identity.
2. Provision Key Vault and wire access so the platform can read only the secrets it needs. Keep the access model narrow.
3. Configure the application platform to reference secrets through Azure-native mechanisms instead of hard-coded values in Terraform files.
4. Write `docs/identity-review.md` with the identity choice, Key Vault access model, secret rotation assumption, and one permission you intentionally did not grant.
5. Review the plan for over-broad permissions, unnecessary outputs, and any secret material that should not live in source control.

If your Azure Identity agent or plan review skill proposes broad access or a generic Key Vault design, refine that customization before writing `docs/identity-review.md`.

## Review gate

Ask Copilot to review the identity and Key Vault plan for least privilege. Make it compare system-assigned and user-assigned identity for this scenario, then check whether your Terraform exposes sensitive values through variables, outputs, or example files.

## Verification

- No application secret values are hard-coded in tracked Terraform files
- The managed identity and Key Vault permissions are narrow enough to explain clearly
- `terraform validate` still passes after the identity and secret changes
- Outputs expose references that are safe to share, not sensitive values
- `docs/identity-review.md` explains the selected identity model and the permissions you avoided

## What Copilot helps with vs. what requires your judgment

Copilot can draft identity blocks and Key Vault access configuration. You decide which permissions the application needs. Have Copilot review the access model, then verify each grant yourself.

---

Previous: [Stage 2: Network and App Platform](stage-2-network-and-platform.md) | Next: [Stage 4: Modules and Environment Promotion](stage-4-modules-and-environments.md)
