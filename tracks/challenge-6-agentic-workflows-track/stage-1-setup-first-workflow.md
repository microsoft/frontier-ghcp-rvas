# Stage 1: Setup and First Workflow

[Back to Challenge 6: Agentic Workflows Track](../challenge-6-agentic-workflows-track.md)

**Difficulty:** ⭐
**Time:** 1 hour

## Tasks

1. **Prepare your GitHub repository** -- You need a repository with real code, a CI pipeline, and some open issues to get meaningful results from agentic workflows. If you completed a previous challenge, push that code to a new GitHub repository. Otherwise, fork a repository with active development. Confirm that GitHub Actions is enabled on the repository.

2. **Install the `gh-aw` CLI extension** -- Run the following in your terminal:

   ```bash
   gh extension install github/gh-aw
   gh aw --help
   ```

   Verify the extension is installed and shows available commands.

3. **Read the documentation** -- Spend 10 minutes reviewing the [GitHub Agentic Workflows overview](https://github.github.com/gh-aw/) and the [How They Work](https://github.github.com/gh-aw/introduction/how-they-work/) page. Understand the frontmatter schema (triggers, permissions, safe-outputs, tools) and the security model (read-only tokens, sandboxed execution, safe outputs).

4. **Create your first workflow: Daily Repo Status** -- Create `daily-repo-status.md` in `.github/workflows/`:

   ```markdown
   ---
   on:
     schedule: daily

   permissions:
     contents: read
     issues: read
     pull-requests: read

   safe-outputs:
     create-issue:
       title-prefix: "[repo status] "
       labels: [report, daily-status]
       close-older-issues: true

   tools:
     github:
   ---

   # Daily Repo Status Report

   Create a daily status report for the repository maintainers.

   Include:
   - Recent repository activity (new issues, merged PRs, open PRs)
   - Summary of recent commits and code changes
   - Open blockers or stale issues
   - Actionable next steps
   - Links to the relevant issues and PRs

   Keep it concise. Use markdown formatting with headers and bullet lists.
   ```

5. **Compile the workflow** -- Generate the lock file:

   ```bash
   gh aw compile
   ```

   This creates `daily-repo-status.lock.yml` alongside your Markdown file.

6. **Push and trigger** -- Commit both files, push to GitHub. Then trigger the workflow manually from the Actions tab, or wait for the scheduled run. Check the Actions log and verify that a new issue was created with the `[repo status]` prefix.

7. **Review the output** -- Read the generated status report issue. Is it accurate? Does it reference real issues and PRs? If not, refine the Markdown instructions and re-run.

## Verification

- [ ] `gh-aw` CLI extension installed and working
- [ ] `daily-repo-status.md` and `daily-repo-status.lock.yml` committed to `.github/workflows/`
- [ ] Workflow has been triggered at least once (manually or on schedule)
- [ ] A status report issue was created in the repository with the correct title prefix and labels
- [ ] The report content is relevant and references real repository activity

---

Next: [Stage 2: Issue and PR Management](stage-2-issue-pr-management.md)
