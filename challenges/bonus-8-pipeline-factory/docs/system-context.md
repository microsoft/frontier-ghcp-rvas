# TaskBoard -- System Context

TaskBoard is a simple kanban-style task management application with two components:

- **api-service**: Node.js/Express REST API with an in-memory SQLite database
- **web-app**: Static HTML/CSS/JS frontend that consumes the API

The application has no CI/CD pipeline, no automated tests, and no standardized deployment process. The only deployment mechanism is a shell script (`scripts/deploy.sh`) with commented-out scp commands.

## What Needs Building

1. A GitHub Actions CI pipeline that builds, lints, and tests both services
2. Reusable workflow templates so future projects can adopt the same pattern
3. Fix the broken staging deployment in `stage-broken/` (5 deliberate bugs)
4. Deployment automation with environment gates (staging must pass before production)
5. An incident response process -- currently, when something breaks, someone manually SSHs in and reads `pm2 logs`

## Known Issues

- No tests of any kind
- No linting configured
- Deployment is manual (scp + ssh)
- The staging environment has configuration drift from production (see `stage-broken/`)
- No health check validation after deployment
- No rollback mechanism
- Secrets (database paths, API keys) are hardcoded or missing
