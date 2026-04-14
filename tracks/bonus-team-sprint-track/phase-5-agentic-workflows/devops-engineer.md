# Phase 5: Agentic Workflows -- DevOps Engineer Tasks

[Back to Phase 5 Overview](../phase-5-agentic-workflows.md) | [Back to Team Sprint Track](../../bonus-team-sprint-track.md)

**Time: ~1 hour**

## Tasks

1. **Review and harden all team workflows** -- Review every agentic workflow the team has created. For each one, verify:
   - Permissions are minimal (read-only by default, no unnecessary scopes)
   - Safe outputs are properly scoped (title prefixes, label constraints, max counts)
   - The Markdown instructions do not leak secrets or include sensitive patterns
   - Tools are limited to what the workflow actually needs

2. **Create a PR fix workflow** -- Write a workflow based on [PR Fix](https://github.com/githubnext/agentics/blob/main/docs/pr-fix.md) that triggers when a collaborator comments `/fix` on a pull request. The workflow should analyze failing CI checks on that PR and push a fix commit.

   ```yaml
   on:
     issue-comment: /fix
   permissions:
     contents: read
     actions: read
     pull-requests: read
   safe-outputs:
     create-pull-request:
       title-prefix: "[auto-fix] "
       labels: [ci-fix, automated]
       max-pull-requests: 1
   tools:
     github:
   ```

3. **Set up workflow monitoring** -- Verify that GitHub Actions logs show the agentic workflow runs clearly. Check that each workflow run is visible in the Actions tab, the runtime is reasonable, and failed runs surface useful error messages.

4. **Document the workflows** -- Add a section to `docs/agentic-workflows.md` listing every agentic workflow the team created, what it does, when it runs, and what outputs it produces. This is for future maintainers.

## Verification

- [ ] All team workflows reviewed for security and minimal permissions
- [ ] PR Fix workflow committed with lock file
- [ ] All workflows visible and runnable in the GitHub Actions tab
- [ ] `docs/agentic-workflows.md` written with a summary of all workflows

---

Previous: [Phase 4 -- DevOps Engineer Tasks](../phase-4-deploy-demo/devops-engineer.md)
