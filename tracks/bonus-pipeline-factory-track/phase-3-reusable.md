# Phase 3: Reusable Workflows

[Back to Pipeline Factory Track](../bonus-pipeline-factory-track.md)

**Duration:** 1.5-2 hours

**Focus:** Creating reusable workflow templates for standardization across projects

## Tasks

1. **Identify what varies between projects.** Review the CI and Build workflows from Phase 1. What would change if you applied the same pipeline to a different Node.js project? Typical variables: Node version, test command, build command, artifact paths, code coverage threshold.

2. **Create a reusable CI workflow.** Create `.github/workflows/reusable-node-ci.yml` as a [reusable workflow](https://docs.github.com/en/actions/sharing-automations/reusing-workflows) with `workflow_call` trigger. Parameterize:
   - Node.js version (default to LTS)
   - Working directory (for mono-repo support)
   - Test command (default to `npm test`)
   - Lint command (default to `npm run lint`)
   - Whether to upload test results as artifacts

3. **Create a reusable deploy workflow.** Create `.github/workflows/reusable-deploy.yml` that handles the deployment pattern:
   - Environment parameter (staging, production)
   - Environment-specific secrets passed as inputs
   - Health check URL to validate after deployment
   - Automatic rollback if the health check fails (conceptual -- use workflow conditions)

4. **Refactor your Phase 1 workflows.** Update `ci.yml` and `build.yml` to call the reusable workflows instead of duplicating steps. Verify they still work the same way.

5. **Document the templates.** Create a brief guide explaining how another team would adopt these reusable workflows in their project. Include an example `caller` workflow.

## Verification

- [ ] Reusable CI workflow created with parameterized inputs
- [ ] Reusable deploy workflow created with environment and health check inputs
- [ ] Phase 1 workflows refactored to use the reusable workflows
- [ ] Adoption guide written with example caller workflow
- [ ] All workflows pass YAML validation

---

Previous: [Phase 2: Debug Staging](phase-2-debug.md) | Next: [Phase 4: Deployment Gates and Runbooks](phase-4-gates.md)
