# Stage 5: Policy, CI, and drift response

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

Add CI checks and review evidence so another engineer can assess a plan before it reaches production.

## Scenario notes

Your team has already seen two kinds of trouble: a manual portal change that did not match Terraform, and a failed apply that left part of an environment updated. Developers want CI feedback that is fast. Operations wants enough evidence to decide whether to import, revert, or repair.

Build the smallest workflow and runbook that would help during those incidents.

## Tasks

1. Create a GitHub Actions workflow that runs `terraform fmt -check`, `terraform validate`, and `terraform plan` for pull requests.
2. Add at least one policy or static analysis gate, such as `tflint`, `checkov`, or a similar Terraform-focused check, and decide whether it blocks merges or only reports findings.
3. Define the apply path for mainline changes. Use manual approval, environment protection rules, or a similar control rather than a blind auto-apply.
4. Add a second entry to `docs/plan-review.md` for the CI or policy phase. Include which checks block a pull request and which checks only inform reviewers.
5. Write `docs/drift-response.md` covering how the team should detect drift, compare Azure state against Terraform state, decide whether to import or replace resources, and recover if an apply fails mid-change.
6. Include one failure drill in the runbook. You can use `docs/drift-incident-evidence.md` as the starting evidence, then decide whether the response should import, revert, revise Terraform, or block for review.

## Review gate

Have Copilot review the workflow for credential leaks, slow pull request steps, missing blocking checks, and unclear runbook instructions.

## Verification

- The workflow validates Terraform changes on pull requests
- Policy or lint checks run in CI and have a clear pass/fail rule
- The repository has a documented apply approval path
- The drift response document is practical enough that another engineer could follow it during an incident
- `docs/plan-review.md` includes a CI or policy review note with a blocking-versus-advisory decision
- `docs/drift-response.md` includes a realistic failure drill and a recovery decision point

## What Copilot helps with vs. what requires your judgment

Copilot can draft GitHub Actions YAML and review the runbook. Your team decides which failures block merges and who must approve an apply.

---

Previous: [Stage 4: Modules and Environment Promotion](stage-4-modules-and-environments.md)
