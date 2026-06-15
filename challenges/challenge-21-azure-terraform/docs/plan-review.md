# Plan Review

Use this as the pull request review note. Keep it short enough that someone would actually read it.

## Plan Summary

- Command:
- Environment:
- Region:
- Adds:
- Changes:
- Destroys:
- Replacements:

## Review Evidence

Paste only the plan lines that changed your decision.

```text
# Example format, replace with your own evidence:
#   + azurerm_storage_account.tfstate will be created
#   ~ public_network_access_enabled = true -> false
# -/+ resource requires replacement
```

## Risk Notes

- Resource with the largest blast radius:
- Reason:
- Manual Azure dependency:
- Decision: approve / revise / block

## CI and Policy Notes

- Blocking checks:
- Advisory checks:
- Missing check you would add next:
- Does the workflow run a plan yet? If not, what Azure authentication decision is blocking it?
