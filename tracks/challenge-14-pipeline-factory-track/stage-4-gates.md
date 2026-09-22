# Stage 4: Deployment Gates and Runbooks

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

4. **Build an incident runbook skill.** Create or refine `.github/skills/incident-runbook/SKILL.md` from the brief in setup. The workflow should use an error log or incident description as evidence and work with the Runbook Writer agent to produce:
   - A plain-language description of the problem
   - Step-by-step diagnostic procedure
   - Resolution options, ranked by likelihood of success
   - Escalation criteria (when to escalate vs. self-resolve)

5. **Test the runbook skill.** Use the bugs you found in Stage 2 as incident inputs. Check that the runbooks address those failures and give actionable diagnostic steps. Refine the skill when its output lacks evidence or clear escalation criteria.

## Verification

- [ ] Environment protection configured (staging auto-deploy, production manual approval)
- [ ] Post-deployment smoke test script created and integrated into workflow
- [ ] Rollback mechanism designed (at minimum, documented in the workflow with conditional steps)
- [ ] Runbooks tie diagnostic steps and resolution options to the supplied incident evidence
- [ ] At least 2 runbooks generated from Stage 2 bugs

---

Previous: [Stage 3: Reusable Workflows](stage-3-reusable.md)
