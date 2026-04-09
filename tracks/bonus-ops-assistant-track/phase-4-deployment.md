# Phase 4: Deployment Automation

[Back to Ops Assistant Track](../bonus-ops-assistant-track.md)

**Duration:** 1.5-2 hours

**Focus:** Generating deployment checklists and post-deploy smoke tests

## Tasks

1. **Build a pre-deployment checklist generator.** Create `.github/prompts/deploy-checklist.prompt.md` that takes a set of code changes (described or referenced via `#file`) and produces:
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

3. **Test the checklist prompt.** Make a code change to the demo app (add a new endpoint or modify an existing one) and run the checklist prompt. Verify the output is specific to the change, not generic.

4. **Integrate ops agents.** Create a combined workflow prompt that chains your tools: analyze deployment logs with the log analyst agent, route any errors to the right team with the routing prompt, and generate runbooks for new error patterns.

## Verification

- [ ] Pre-deployment checklist prompt created and tested
- [ ] Post-deployment smoke test script created and tested against the demo app
- [ ] Checklist produces change-specific output (not generic boilerplate)
- [ ] Combined workflow demonstrated (log analysis to routing to runbook generation)

---

Previous: [Phase 3: Troubleshooting Aids](phase-3-troubleshooting.md)
