# Phase 4: Deployment Gates and Runbooks

[Back to Pipeline Factory Track](../bonus-pipeline-factory-track.md)

**Duration:** 2-3 hours

**Focus:** Adding deployment gates, rollback mechanisms, and generating incident runbooks

## Tasks

1. **Add environment protection rules.** Configure your deployment workflow with GitHub Environments:
   - `staging`: deploys automatically on push to `main`
   - `production`: requires manual approval (use `environment` key with reviewers)
   - Staging must pass health check before production deployment is allowed

2. **Add smoke tests.** Create a post-deployment validation step:
   - A script that hits the health endpoint and key API endpoints
   - Verifies response status codes and basic response structure
   - Fails the deployment if any check fails

3. **Add rollback mechanism.** Design a workflow that:
   - Tracks the previously deployed version (commit SHA or artifact)
   - On failed smoke test, redeploys the previous version
   - Logs the rollback event

4. **Build an incident runbook prompt.** Create `.github/prompts/incident-runbook.prompt.md` that takes an error log or incident description and produces:
   - A plain-language description of the problem
   - Step-by-step diagnostic procedure
   - Resolution options, ranked by likelihood of success
   - Escalation criteria (when to escalate vs. self-resolve)

5. **Test the runbook prompt.** Feed it the bugs you found in Phase 2 (as if they were real incidents) and verify the produced runbooks are actionable.

## Verification

- [ ] Environment protection configured (staging auto-deploy, production manual approval)
- [ ] Post-deployment smoke test script created and integrated into workflow
- [ ] Rollback mechanism designed (at minimum, documented in the workflow with conditional steps)
- [ ] Incident runbook prompt created and tested
- [ ] At least 2 runbooks generated from Phase 2 bugs

---

Previous: [Phase 3: Reusable Workflows](phase-3-reusable.md)
