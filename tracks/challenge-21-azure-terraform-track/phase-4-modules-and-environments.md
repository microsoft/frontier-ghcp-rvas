# Phase 4: Modules and Environment Promotion

[Back to Challenge 21: Azure Terraform Track](../challenge-21-azure-terraform-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

The Terraform now works, but it still reads like a one-off build. This phase turns it into something another team could reuse for dev and prod without copying files and hoping for the best.

## Scenario Notes

Dev needs to stay cheap and easy to reset. Prod needs tighter defaults, clearer approvals, and fewer surprises. The platform lead wants reusable modules, but the app team still needs to understand the call sites without becoming Terraform specialists.

Your goal is reuse with restraint. A module boundary should make review easier, not hide every decision behind variables.

## Tasks

1. Extract reusable modules for the repeated infrastructure slices you built in earlier phases. Keep the module boundaries simple and explainable.
2. Add at least two environment configurations, such as `dev` and `prod`, with separate variable files or environment folders.
3. Add validation rules, preconditions, or both for values that should not vary freely, such as regions, SKUs, or allowed CIDR ranges.
4. Write `docs/environment-promotion.md` with the differences between dev and prod, what requires approval, and what can change through a pull request alone.
5. Review the module inputs and outputs. Cut anything that exists only because it was convenient during the first draft.

## Review Gate

Ask Copilot to compare your module layout against the original flat layout. The review should call out which abstraction made the code easier to review, which one made it harder, and whether any output leaks implementation detail.

## Verification

- The same module set can support at least two environments without copy-pasting resource blocks
- Environment-specific values are easy to find and review
- Validation catches at least one bad input before apply time
- The plan output is still readable after modularization
- `docs/environment-promotion.md` defines dev and prod differences without turning the challenge into a full landing-zone build

## What Copilot Helps With vs. What Requires Your Judgment

Copilot is good at extracting repeated blocks into modules. The hard part is resisting the urge to over-abstract. If a module only saves three lines and makes the call site harder to read, it is probably not helping. Ask Copilot to find the abstraction that should be deleted, not just the one it can create.

---

Previous: [Phase 3: Identity and Secrets](phase-3-identity-and-secrets.md) | Next: [Phase 5: Policy, CI, and Drift Response](phase-5-policy-ci-and-drift.md)
