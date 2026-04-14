# Stage 4: CI Monitoring and ChatOps

[Back to Agentic Workflows Track](../agentic-workflows-track.md)

**Difficulty:** ⭐⭐⭐
**Time:** 1.5 hours

## Tasks

1. **Create a CI Doctor workflow** -- Write a workflow that triggers when a CI workflow run completes with a failure. The agent should read the failure logs, identify the root cause (test failure, build error, dependency issue, flaky test), and post a comment on the associated PR or commit with:
   - A summary of what went wrong
   - The specific file(s) and line(s) involved
   - A suggested fix or workaround

   Reference the [CI Doctor](https://github.com/githubnext/agentics/blob/main/docs/ci-doctor.md) from the Agentics gallery.

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

2. **Create a ChatOps `/plan` command** -- Write a command-triggered workflow that activates when a maintainer comments `/plan` on an issue. The agent should read the issue, break it down into actionable sub-tasks, and post them as a comment (or create sub-issues if your repository supports them).

   Reference the [Plan Command](https://github.com/githubnext/agentics/blob/main/docs/plan.md) from the Agentics gallery.

   ```yaml
   on:
     issue-comment: /plan
   permissions:
     contents: read
     issues: read
   safe-outputs:
     add-issue-comment:
       max-comments: 1
   tools:
     github:
   ```

3. **Create a ChatOps `/ask` command** -- Write a command-triggered workflow based on [Repo Ask](https://github.com/githubnext/agentics/blob/main/docs/repo-ask.md). When someone comments `/ask <question>` on an issue, the agent should research the repository (code, issues, PRs, docs) and post an answer as a comment. This turns your repository into a searchable knowledge base.

4. **Test the ChatOps workflows** -- Create a test issue and try the `/plan` and `/ask` commands. Verify that the agent responds with useful output. Test edge cases: vague issues, multi-part questions, issues that reference external resources.

5. **Compile, commit, and push** -- Run `gh aw compile` for all new workflows.

## What Copilot Helps With vs. What Requires Your Judgment

**Copilot helps with:** generating the frontmatter, writing command parsing logic in the Markdown body, adapting gallery workflows.

**Your judgment:** deciding which ChatOps commands to support, defining the scope of CI Doctor analysis (should it only diagnose or also attempt fixes?), calibrating the response format (brief vs. detailed), and testing with realistic scenarios.

## Verification

- [ ] CI Doctor workflow committed with lock file
- [ ] At least one ChatOps command workflow committed (`/plan` or `/ask`)
- [ ] CI Doctor has been triggered on a failing CI run (create one intentionally if needed)
- [ ] ChatOps command has been tested with at least 2 different inputs
- [ ] All workflows use read-only permissions and scoped safe outputs

---

Previous: [Stage 3: Code Quality and Documentation](stage-3-code-quality-docs.md) | Next: [Stage 5: Security and Advanced Patterns](stage-5-security-advanced.md)
