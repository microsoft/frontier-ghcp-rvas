# Stage 3: Code Quality and Documentation

[Back to Challenge 6: Agentic Workflows Track](../challenge-6-agentic-workflows-track.md)

**Difficulty:** ⭐⭐
**Time:** 1.5 hours

## Tasks

1. **Create a code simplifier workflow** -- Write a workflow that runs on a daily or weekly schedule. The agent should analyze recently modified source files, identify opportunities to simplify the code (dead code, excessive nesting, duplicated logic, overly complex functions), and open a pull request with the improvements.

   In your Markdown instructions, be specific about your codebase:
   - Which directories contain the source code (e.g., `src/`, `server/`, `client/`)
   - What language and framework the project uses
   - Any patterns or conventions to preserve (e.g., "keep the Express middleware structure," "don't merge route handlers")
   - The maximum scope of a single PR (target small, focused changes)

   Reference the [Code Simplifier](https://github.com/githubnext/agentics/blob/main/docs/code-simplifier.md) from the Agentics gallery.

2. **Create a test improver workflow** -- Write a workflow that runs on a schedule, identifies under-tested areas of the codebase, and opens a PR adding meaningful test cases. The Markdown instructions should specify your test framework (Jest, pytest, Playwright), the test directory structure, and what kinds of tests to prioritize (unit tests for business logic, integration tests for API endpoints).

   Reference the [Daily Test Improver](https://github.com/githubnext/agentics/blob/main/docs/daily-test-improver.md).

3. **Create a documentation updater workflow** -- Write a workflow that runs daily, detects recent code changes from merged PRs, and opens a pull request updating relevant documentation (README, API docs, component docs). Tell the agent which files are documentation, what format to use (Markdown, JSDoc, docstrings), and how to match code changes to doc sections.

   Reference the [Daily Documentation Updater](https://github.com/githubnext/agentics/blob/main/docs/daily-doc-updater.md).

4. **Review PR quality** -- After triggering each workflow, review the pull requests they produce. For each PR, evaluate:
   - Does the change actually improve the code/tests/docs?
   - Is the scope appropriate (not too broad, not trivial)?
   - Are there any incorrect changes?

   If a PR is not useful, refine the workflow instructions and re-run. This iterative refinement is a core part of working with agentic workflows.

5. **Compile, commit, and push** -- Run `gh aw compile` after each new or modified workflow.

## Verification

- [ ] Code simplifier workflow committed with lock file
- [ ] Test improver workflow committed with lock file
- [ ] Documentation updater workflow committed with lock file
- [ ] Each workflow has produced at least one pull request
- [ ] Pull request safe outputs use title prefixes (e.g., `[simplify]`, `[tests]`, `[docs]`) and labels
- [ ] At least one PR was reviewed and either merged or the workflow instructions were refined

---

Previous: [Stage 2: Issue and PR Management](stage-2-issue-pr-management.md) | Next: [Stage 4: CI Monitoring and ChatOps](stage-4-ci-monitoring-chatops.md)
