# Stage 1: Trust Boundaries and Threats

**Difficulty:** ⭐⭐⭐ | **Time:** 55-70 min

The release review starts with the system, not a scanner. Work out who can call
the API, what they can reach, and which data changes hands before ranking code
findings.

## Tasks

Use your repository instructions during the first code walk. Give the Threat
Model Reviewer agent your endpoint inventory and assumptions, then use the
Endpoint Security Review skill on one identity route, one payment route, and one
admin route. This is a review cue, not permission to copy a generated threat
model.

1. Run the starter tests and application. Record the baseline commands and
   results in `deliverables/threat-model.md`.
2. Inventory every endpoint with caller type, input, sensitive output, data
   change, and expected authorization.
3. Draw or describe the API process, caller, local data store, configuration,
   package source, and log destination as trust zones. Mark each boundary.
4. Identify assets worth protecting, including identities, payment ownership,
   configuration values, dependency integrity, and security evidence.
5. Write at least six concrete threat scenarios. Cover authentication,
   authorization, input handling, configuration, dependencies, and logging.
6. State assumptions and scope limits. Keep all proof local and
   non-destructive.

## Verification

- `dotnet test SecureReleaseReview.sln` passes before remediation
- `deliverables/threat-model.md` lists every starter endpoint
- Each threat names an actor, target asset, boundary, and plausible impact
- Authentication, role authorization, and resource ownership are treated as
  separate controls
- The document labels synthetic data and local-only testing clearly

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can inventory routes and suggest abuse cases. You decide which trust
boundaries are real, which assumptions are safe enough for release, and which
threats deserve proof. Reject scenarios that are not tied to this codebase.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Identity, Secrets, and Dependencies](stage-2-auth-secrets-and-dependencies.md)
