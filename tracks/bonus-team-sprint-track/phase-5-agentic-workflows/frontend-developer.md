# Phase 5: Agentic Workflows -- Frontend Developer Tasks

[Back to Phase 5 Overview](../phase-5-agentic-workflows.md) | [Back to Team Sprint Track](../../bonus-team-sprint-track.md)

**Time: ~1 hour**

## Tasks

1. **Create a documentation updater workflow** -- Write a Markdown workflow that runs on a daily schedule, checks for recent code changes (merged PRs), and opens a pull request updating the project's documentation to reflect those changes. Reference the [Daily Documentation Updater](https://github.com/githubnext/agentics/blob/main/docs/daily-doc-updater.md) from the Agentics gallery.

   In the Markdown body, specify which documentation files to target (README, component docs, API usage examples) and the tone or style to use.

2. **Create an accessibility review workflow** -- Write a workflow that uses the [Daily Accessibility Review](https://github.com/githubnext/agentics/blob/main/docs/daily-accessibility-review.md) pattern. It should create an issue with accessibility findings -- contrast ratios, missing ARIA labels, keyboard navigation gaps -- based on reviewing the frontend code.

   ```yaml
   on:
     schedule: weekly
   permissions:
     contents: read
   safe-outputs:
     create-issue:
       title-prefix: "[a11y] "
       labels: [accessibility, automated]
       max-issues: 1
   tools:
     github:
   ```

3. **Compile and commit** -- Run `gh aw compile` for each workflow. Commit and push.

4. **Review output** -- Trigger the documentation updater manually and review the pull request it creates. Does it accurately reflect recent changes?

## Verification

- [ ] Documentation updater workflow committed with lock file
- [ ] Accessibility review workflow committed with lock file
- [ ] At least one workflow triggered and produced output (issue or PR)

---

Previous: [Phase 4 -- Frontend Developer Tasks](../phase-4-deploy-demo/frontend-developer.md)
