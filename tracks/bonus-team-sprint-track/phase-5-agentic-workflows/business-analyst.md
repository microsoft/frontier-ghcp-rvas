# Phase 5: Agentic Workflows -- Business Analyst Tasks

[Back to Phase 5 Overview](../phase-5-agentic-workflows.md) | [Back to Team Sprint Track](../../bonus-team-sprint-track.md)

**Time: ~1 hour**

## Tasks

1. **Create a weekly summary workflow** -- Write a Markdown workflow based on [Weekly Issue Summary](https://github.com/githubnext/agentics/blob/main/docs/weekly-issue-summary.md) that creates a weekly report of issue activity: how many were opened, closed, and are still open, grouped by label. The report should include trend observations and recommendations for the team.

   ```yaml
   on:
     schedule: weekly
   permissions:
     contents: read
     issues: read
     pull-requests: read
   safe-outputs:
     create-issue:
       title-prefix: "[weekly-summary] "
       labels: [report, weekly]
       close-older-issues: true
   tools:
     github:
   ```

2. **Create a discussion task miner workflow** -- Write a workflow based on [Discussion Task Miner](https://github.com/githubnext/agentics/blob/main/docs/discussion-task-miner.md) that scans GitHub Discussions (or issue comments, if Discussions are not enabled) for actionable items and creates tracked issues from them.

3. **Compile and commit** -- Run `gh aw compile` for each workflow. Commit and push.

4. **Trigger and validate** -- Trigger the weekly summary manually. Review the generated issue for accuracy and usefulness.

## Verification

- [ ] Weekly summary workflow committed with lock file
- [ ] Discussion task miner workflow committed with lock file
- [ ] At least one workflow triggered and produced a useful report

---

Previous: [Phase 4 -- Business Analyst Tasks](../phase-4-deploy-demo/business-analyst.md)
