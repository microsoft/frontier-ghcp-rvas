# Stage 4: Modules and environment promotion

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

Refactor the working Terraform into modules another team can reuse for dev and prod without copying resource blocks.

## Scenario notes

Dev needs to stay cheap and easy to reset. Prod needs tighter defaults, clearer approvals, and fewer surprises. The platform lead wants reusable modules, but the app team still needs to understand the call sites without becoming Terraform specialists.

A module boundary should make review easier. Keep decisions visible at the call site.

## Tasks

1. Extract reusable modules for the repeated infrastructure slices you built in earlier stages. Keep the module boundaries simple and explainable.
2. Add at least two environment configurations, such as `dev` and `prod`, with separate variable files or environment folders.
3. Add validation rules, preconditions, or both for values that should not vary freely, such as regions, SKUs, or allowed CIDR ranges.
4. Write `docs/environment-promotion.md` with the differences between dev and prod, what requires approval, and what can change through a pull request alone.
5. Review the module inputs and outputs. Cut anything that exists only because it was convenient during the first draft.

## Review gate

Ask Copilot to compare your module layout against the original flat layout. The review should call out which abstraction made the code easier to review, which one made it harder, and whether any output leaks implementation detail.

## Verification

- The same module set can support at least two environments without copy-pasting resource blocks
- Environment-specific values are easy to find and review
- Validation catches at least one bad input before apply time
- The plan output is still readable after modularization
- `docs/environment-promotion.md` defines dev and prod differences without turning the challenge into a full landing-zone build

## What Copilot helps with vs. what requires your judgment

Copilot can extract repeated blocks into modules. You decide whether the result is easier to review. Remove a module if it saves little code and makes the call site harder to read.

---

Previous: [Stage 3: Identity and Secrets](stage-3-identity-and-secrets.md) | Next: [Stage 5: Policy, CI, and Drift Response](stage-5-policy-ci-and-drift.md)
