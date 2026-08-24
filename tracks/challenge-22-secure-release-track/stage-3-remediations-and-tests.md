# Stage 3: Targeted Remediations and Security Tests

**Difficulty:** ⭐⭐⭐ | **Time:** 90-110 min

Fix the risks that matter to this release. Broad rewrites make review harder, so
work one proven behavior at a time.

## Tasks

1. Select at least three findings to remediate. Include one authorization gap,
   one input or output-handling gap, and one configuration, dependency, or
   logging gap.
2. For each finding, change or add a test so the unsafe behavior fails before
   the production change.
3. Add narrow authentication and authorization controls. Cover both allowed and
   denied callers, including resource ownership where needed.
4. Add explicit payment validation and stable error responses for the inputs
   you decide to support.
5. Stop returning configuration values and remove sensitive values from logs.
   Add useful actor, action, target, outcome, and correlation context.
6. Remove, update, or justify the flagged dependency. Capture the package audit
   result after the change.
7. Write `deliverables/remediation-and-tests.md` with before behavior, test
   name, code change, result, and any finding left open.

At the midpoint, give the Authorization Reviewer one completed change and a
denial test. If it misses role-versus-ownership distinctions or recommends a
large rewrite, refine that agent brief. Refine the Security Regression skill if
it does not keep a clear failing-test-to-fix evidence chain.

## Verification

- `dotnet build SecureReleaseReview.sln --no-restore` passes
- `dotnet test SecureReleaseReview.sln --no-build` passes
- Tests cover permitted and denied behavior for each authorization change
- Invalid payment input has a deterministic client error
- API responses and logs no longer expose configuration or bearer values
- The package audit result is captured and interpreted
- `deliverables/remediation-and-tests.md` links findings to tests and changes

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can draft policies, validators, and tests. You decide whether the
control belongs at authentication, role, resource, or domain level. Keep each
change small enough that another reviewer can understand why it closes the
finding.

---

Previous: [Stage 2: Identity, Secrets, and Dependencies](stage-2-auth-secrets-and-dependencies.md) | Next: [Stage 4: Release Evidence and Residual Risk](stage-4-release-evidence-and-risk.md)
