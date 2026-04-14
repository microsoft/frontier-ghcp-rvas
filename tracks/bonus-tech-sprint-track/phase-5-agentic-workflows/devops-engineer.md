# Phase 5: Agentic Workflows -- DevOps Engineer Tasks

[Back to Phase 5 Overview](../phase-5-agentic-workflows.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: ~1 hour**

## Tasks

1. **Create an issue triage workflow** -- Since there is no Product Owner on this track, the DevOps engineer owns the triage workflow. Write a workflow that triggers on new issues, assigns labels (bug, feature, question), sets priority (P0-P3), and posts a summary comment. Reference the [Issue Triage](https://github.com/githubnext/agentics/blob/main/docs/issue-triage.md) workflow from the Agentics gallery.

   ```yaml
   on:
     issues: opened
   permissions:
     contents: read
     issues: read
   safe-outputs:
     add-issue-comment:
       max-comments: 1
     add-issue-labels:
       labels: [bug, feature, question, P0, P1, P2, P3]
   tools:
     github:
   ```

2. **Review and harden all team workflows** -- Review every agentic workflow the team has created. For each one, verify:
   - Permissions are minimal (read-only by default, no unnecessary scopes)
   - Safe outputs are properly scoped (title prefixes, label constraints, max counts)
   - The Markdown instructions do not leak secrets or include sensitive patterns
   - Tools are limited to what the workflow actually needs

3. **Set up workflow monitoring** -- Verify that GitHub Actions logs show the agentic workflow runs clearly. Check that each workflow run is visible in the Actions tab, the runtime is reasonable, and failed runs surface useful error messages.

4. **Document the workflows** -- Add a section to `docs/agentic-workflows.md` listing every agentic workflow the team created, what it does, when it runs, and what outputs it produces.

## Verification

- [ ] Issue triage workflow committed with lock file
- [ ] All team workflows reviewed for security and minimal permissions
- [ ] All workflows visible and runnable in the GitHub Actions tab
- [ ] `docs/agentic-workflows.md` written with a summary of all workflows

---

Previous: [Phase 4 -- DevOps Engineer Tasks](../phase-4-deploy-demo/devops-engineer.md)
