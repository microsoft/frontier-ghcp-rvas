# Phase 1: CI Pipeline

[Back to Pipeline Factory Track](../bonus-pipeline-factory-track.md)

**Duration:** 1.5-2 hours

**Focus:** Creating GitHub Actions workflows for build, lint, and test

## Tasks

1. **Set up linting for the API.** Add ESLint to the `api-service`. Use Copilot to generate an `.eslintrc.json` configuration appropriate for a Node.js/Express project. Fix any linting errors in `server.js`.

2. **Write basic tests for the API.** Add a test framework (Jest or Vitest) and write tests for the key endpoints: health check, list tasks, create task, update task, delete task. Use supertest for HTTP-level testing.

3. **Create a CI workflow for PRs.** Create `.github/workflows/ci.yml` that runs on pull requests to `main` and does:
   - Install dependencies for `api-service`
   - Run the linter
   - Run the tests
   - Use Node.js LTS version
   - Cache `node_modules` for faster builds

4. **Create a build workflow for pushes.** Create `.github/workflows/build.yml` that runs on pushes to `main` and does everything the CI workflow does, plus:
   - Runs a production build check (verify the app starts and the health endpoint responds)
   - Uploads test results as artifacts

5. **Validate the workflows.** Use Copilot to review your workflow YAML for common mistakes: unpinned action versions, missing `permissions` blocks, unnecessary `secrets` exposure, and incorrect trigger configurations.

## Verification

- [ ] ESLint configured and all linting errors in `api-service/server.js` fixed
- [ ] At least 5 API tests written and passing
- [ ] CI workflow created (runs lint + tests on PRs)
- [ ] Build workflow created (runs on pushes to main)
- [ ] Both workflows pass validation (pinned versions, proper permissions)

---

Next: [Phase 2: Debug Staging](phase-2-debug.md)
