# Phase 5: Agentic Workflows -- QA Engineer Tasks

[Back to Phase 5 Overview](../phase-5-agentic-workflows.md) | [Back to Team Sprint Track](../../bonus-team-sprint-track.md)

**Time: ~1 hour**

## Tasks

1. **Create a CI Doctor workflow** -- Write a Markdown workflow that monitors CI workflows and investigates failures automatically. When a CI run fails, the workflow should analyze the logs, identify the root cause, and post a comment on the relevant PR or commit with a diagnosis and a suggested fix. Reference the [CI Doctor](https://github.com/githubnext/agentics/blob/main/docs/ci-doctor.md) from the Agentics gallery.

   Key frontmatter:

   ```yaml
   on:
     workflow-run: completed
   permissions:
     contents: read
     actions: read
     issues: read
     pull-requests: read
   safe-outputs:
     add-issue-comment:
       max-comments: 1
   tools:
     github:
   ```

2. **Create a daily QA workflow** -- Write a workflow based on [Daily Adhoc QA](https://github.com/githubnext/agentics/blob/main/docs/daily-qa.md) that performs exploratory quality checks on the codebase. The workflow should look for common issues: unhandled error states, missing input validation, inconsistent API responses, and report its findings as a GitHub Issue.

3. **Compile and commit** -- Run `gh aw compile` for each workflow. Commit and push both `.md` and `.lock.yml` files.

4. **Validate CI Doctor** -- If there is a recent failed CI run, trigger the CI Doctor manually and check whether its diagnosis is accurate.

## Verification

- [ ] CI Doctor workflow committed with lock file
- [ ] Daily QA workflow committed with lock file
- [ ] At least one workflow triggered and produced useful output
- [ ] Workflow permissions are read-only (no write permissions granted)

---

Previous: [Phase 4 -- QA Engineer Tasks](../phase-4-deploy-demo/qa-engineer.md)
