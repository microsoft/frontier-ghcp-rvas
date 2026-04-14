# Phase 5: Agentic Workflows -- Product Owner Tasks

[Back to Phase 5 Overview](../phase-5-agentic-workflows.md) | [Back to Team Sprint Track](../../bonus-team-sprint-track.md)

**Time: ~1 hour**

## Tasks

1. **Create an issue triage workflow** -- Write a Markdown workflow that triggers on new issues. It should read the issue body, assign a label (bug, feature, question, or documentation), set a priority (P0-P3), and post a comment summarizing the issue and suggesting next steps. Use the [Issue Triage](https://github.com/githubnext/agentics/blob/main/docs/issue-triage.md) workflow from the Agentics gallery as a reference.

   ```markdown
   ---
   on:
     issues: opened

   permissions:
     contents: read
     issues: read

   safe-outputs:
     add-issue-comment:
       max-comments: 1
     add-issue-labels:
       labels: [bug, feature, question, documentation, P0, P1, P2, P3]

   tools:
     github:
   ---

   # Issue Triage

   When a new issue is opened, analyze its title and body.
   Assign exactly one type label (bug, feature, question, documentation)
   and one priority label (P0 through P3).
   Post a comment summarizing what the issue is about and what the
   recommended next steps are for the team.
   ```

2. **Create a daily status report workflow** -- Write a workflow that runs on a daily schedule and creates a GitHub Issue summarizing recent repository activity: new issues, merged PRs, open blockers, and action items. Reference the [Daily Repo Status](https://github.com/githubnext/agentics/blob/main/docs/daily-repo-status.md) workflow.

3. **Compile and commit** -- Run `gh aw compile` to generate the lock files. Commit both the `.md` and `.lock.yml` files. Push to the repository.

4. **Test the triage workflow** -- Create a test issue in the repository and verify that the workflow triggers, labels it, and posts a comment.

## Verification

- [ ] Issue triage workflow committed with lock file
- [ ] Daily status report workflow committed with lock file
- [ ] At least one test issue has been auto-triaged by the workflow

---

Previous: [Phase 4 -- Product Owner Tasks](../phase-4-deploy-demo/product-owner.md)
