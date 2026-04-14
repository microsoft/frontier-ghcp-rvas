# Stage 2: Issue and PR Management

[Back to Agentic Workflows Track](../agentic-workflows-track.md)

**Difficulty:** ⭐⭐
**Time:** 1.5 hours

## Tasks

1. **Create an issue triage workflow** -- Write a Markdown workflow that triggers when a new issue is opened. The agent should read the issue title and body, assign one type label (bug, feature, question, documentation) and one priority label (P0-P3), and post a summary comment explaining the triage decision.

   Points to consider in your Markdown instructions:
   - Define what each label means for your project (e.g., P0 = service down, P1 = broken feature, P2 = degraded experience, P3 = minor improvement)
   - Tell the agent how to handle ambiguous issues (default to P2 and `question` if unclear)
   - Specify the comment format (brief, actionable, linking to related issues if found)

   Use the [Issue Triage](https://github.com/githubnext/agentics/blob/main/docs/issue-triage.md) workflow from the Agentics gallery as a reference.

2. **Test the triage workflow** -- Create 3-4 test issues with different intents: a clear bug report, a feature request, a vague question, and a documentation request. Trigger the triage workflow for each (or let it trigger automatically). Review the labels and comments the agent assigned. Did it get them right?

3. **Create a contribution check workflow** -- Write a workflow based on [Contribution Check](https://github.com/githubnext/agentics/blob/main/docs/contribution-check.md) that periodically reviews open pull requests against contribution guidelines. If you don't have a `CONTRIBUTING.md`, create a minimal one first. The workflow should create a report issue listing PRs that need attention.

4. **Create a Grumpy Reviewer workflow (stretch)** -- Write a ChatOps-style workflow based on [Grumpy Reviewer](https://github.com/githubnext/agentics/blob/main/docs/grumpy-reviewer.md) that triggers when someone comments `/review` on a pull request. The agent should perform an opinionated code review -- focusing on naming, complexity, error handling, and testing -- and post its findings as a PR comment.

   ```yaml
   on:
     issue-comment: /review

   permissions:
     contents: read
     pull-requests: read

   safe-outputs:
     add-pull-request-comment:
       max-comments: 1

   tools:
     github:
   ```

5. **Compile, commit, and push** -- Run `gh aw compile` after creating each workflow. Commit both `.md` and `.lock.yml` files.

## What Copilot Helps With vs. What Requires Your Judgment

**Copilot helps with:** generating the frontmatter schema, writing the Markdown body based on your description, adapting gallery examples to your project.

**Your judgment:** deciding the right label taxonomy for your project, defining what each priority level means, scoping safe outputs (how many comments, which labels are allowed), and reviewing triage accuracy.

## Verification

- [ ] Issue triage workflow committed with lock file
- [ ] At least 3 test issues have been auto-triaged with correct labels and comments
- [ ] Contribution check workflow committed with lock file (or Grumpy Reviewer as alternative)
- [ ] All workflows use read-only permissions
- [ ] Safe outputs are scoped with appropriate constraints (max comments, label allowlists)

---

Previous: [Stage 1: Setup and First Workflow](stage-1-setup-first-workflow.md) | Next: [Stage 3: Code Quality and Documentation](stage-3-code-quality-docs.md)
