# Agentic Workflows -- Sample Repository

This directory contains a minimal sample repository structure that you can use
as a starting point for adding GitHub Agentic Workflows.

## Getting Started

You need a GitHub repository with real code, issues, and CI workflows to get
meaningful results from agentic workflows. You have two options:

### Option A: Use an Existing Challenge Repository

If you completed another challenge (e.g., challenge-1 Web API, bonus-4 TrailMate),
push that code to a new GitHub repository and add agentic workflows on top.

### Option B: Fork a Public Repository

Fork a repository with active issues and CI pipelines. Good candidates:

- A repository from your organization
- Any open-source project where you have write access to a fork

## Important

Agentic workflows **run on GitHub**, not locally. Your code must be pushed to a
GitHub repository with GitHub Actions enabled before any workflows will execute.

## Setup

1. Install the `gh-aw` CLI extension:

   ```bash
   gh extension install github/gh-aw
   ```

2. Create your first workflow file in `.github/workflows/` (see the track guide
   for examples)

3. Compile the lock file:

   ```bash
   gh aw compile
   ```

4. Commit both the `.md` and `.lock.yml` files and push to GitHub.

5. Check the Actions tab to see your workflow run.
