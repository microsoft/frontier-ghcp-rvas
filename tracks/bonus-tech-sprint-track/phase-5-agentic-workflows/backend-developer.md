# Phase 5: Agentic Workflows -- Backend Developer Tasks

[Back to Phase 5 Overview](../phase-5-agentic-workflows.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: ~1 hour**

## Tasks

1. **Create a code simplifier workflow** -- Write a Markdown workflow that runs on a daily schedule, analyzes recently modified source files, and opens a pull request with targeted simplifications (remove dead code, reduce nesting, extract helpers). Use the [Code Simplifier](https://github.com/githubnext/agentics/blob/main/docs/code-simplifier.md) from the Agentics gallery as reference.

   Key frontmatter elements:

   ```yaml
   on:
     schedule: daily
   permissions:
     contents: read
   safe-outputs:
     create-pull-request:
       title-prefix: "[simplify] "
       labels: [code-quality, automated]
       max-pull-requests: 1
   tools:
     github:
   ```

   In the Markdown body, describe what "simplification" means for your TrailMate codebase -- which directories to focus on, what language the backend uses, and any patterns to preserve.

2. **Create a test improver workflow** -- Write a workflow that runs daily, assesses test coverage, identifies under-tested areas of the backend, and opens a PR adding meaningful tests. Reference the [Daily Test Improver](https://github.com/githubnext/agentics/blob/main/docs/daily-test-improver.md).

3. **Compile and commit** -- Run `gh aw compile` for each workflow. Commit the `.md` and `.lock.yml` files.

4. **Trigger and review** -- Trigger at least one workflow manually via GitHub Actions and review the resulting pull request. Check that the proposed changes make sense before merging.

## Verification

- [ ] Code simplifier workflow committed with lock file
- [ ] Test improver workflow committed with lock file
- [ ] At least one workflow has produced a pull request
- [ ] Safe outputs use title prefixes and labels correctly

---

Previous: [Phase 4 -- Backend Developer Tasks](../phase-4-deploy-demo/backend-developer.md)
