# Stage 4: Deployment Automation

**Duration:** 1.5-2 hours

**Focus:** Generating deployment checklists and post-deploy smoke tests

## Tasks

1. **Build a pre-deployment checklist skill.** Create `.github/skills/deploy-checklist/SKILL.md` for a workflow that reviews code changes (described or referenced via `#file`) against the app's deployment requirements and produces:
   - What services are affected by this change
   - Configuration changes needed (environment variables, feature flags)
   - Database migration steps (if any)
   - Dependencies to verify (external services that must be available)
   - Rollback steps if the deployment fails
   - Who to notify before and after deployment

2. **Build a smoke test script.** Write a shell script or Node.js script that validates the demo app after deployment:
   - Check the health endpoint returns 200
   - Check the orders list endpoint returns valid JSON
   - Check that creating an order works (POST, verify 201, verify the order appears in the list)
   - Check response times are within acceptable limits
   - Report pass/fail per check with timestamps

3. **Test the checklist skill.** Make a code change to the demo app (add a new endpoint or modify an existing one) and use the skill. Verify that each checklist item is relevant to the change, then refine any rules that produced generic advice.

4. **Combine the ops workflows.** Use your Log Triage skill with the Log Analyst agent to analyze deployment logs. Pass the findings to the incident routing skill from Stage 2, then use the runbook skill from Stage 3 for errors that need troubleshooting guidance. Keep evidence and unresolved questions in each handoff. Reuse these skills rather than authoring another orchestration artifact.

## Verification

- [ ] Post-deployment smoke test script created and tested against the demo app
- [ ] Checklist produces change-specific output (not generic boilerplate)
- [ ] Combined workflow demonstrated (log analysis to routing to runbook generation)

---

Previous: [Stage 3: Troubleshooting Aids](stage-3-troubleshooting.md)
