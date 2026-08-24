# Stage 4: Release Evidence and Residual Risk

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

The last stage turns technical work into a release decision. A fixed test suite
does not automatically mean the service is ready, and an open finding does not
automatically mean it must wait.

## Tasks

1. Re-run restore, build, tests, and package audit from a clean working tree.
2. Revisit every prioritized finding. Mark it remediated, accepted, deferred, or
   not reproducible, with evidence.
3. Write `deliverables/residual-risk.md`. For every open risk, name the owner,
   compensating control, review date, trigger for reconsideration, and reason it
   does not block this release.
4. Write `deliverables/secure-release-checklist.md`. Include security tests,
   authorization coverage, input handling, configuration, dependency status,
   logging, rollback, monitoring, and approval criteria.
5. State a go, conditional go, or no-go recommendation. List the exact criteria
   that would change the decision.
6. Ask the Release Evidence Reviewer to trace each checklist item to a finding,
   test, command, or accepted risk. Remove unsupported claims.
7. Run:

   ```bash
   bash scripts/validate-deliverables.sh
   ```

## Verification

- All six required deliverables are present and non-empty
- Residual risks have an owner, review date, compensating control, and trigger
- The checklist contains objective pass/fail release criteria
- The recommendation matches the evidence and unresolved findings
- `bash scripts/validate-deliverables.sh` passes
- Final `dotnet restore`, `dotnet build`, and `dotnet test` commands pass

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can find missing links between findings and evidence. It cannot accept
risk for the team. The release recommendation belongs to the accountable
reviewers, with names, dates, and conditions that can be checked later.

---

Previous: [Stage 3: Targeted Remediations and Security Tests](stage-3-remediations-and-tests.md)
