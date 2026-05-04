# Stage 1: Containerization and Local Development

[Back to Challenge 3: DevOps Track](../challenge-3-devops-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

Containerize the Node.js application and set up a local development workflow.

## Tasks

1. Complete the multi-stage Dockerfile in `app/Dockerfile`. Use `node:18-alpine` as base. Include a non-root user, optimized layer caching, and minimal final image.
2. Create a Docker Compose file (`docker-compose.yml`) for local development with hot-reload: volume mount the source directory, use nodemon for file watching.
3. Container security: scan the built image with `trivy` or `docker scout`. Fix any HIGH or CRITICAL vulnerabilities.

## Verification

- `docker build` succeeds and final image is under 100MB
- `docker compose up` serves the application with live reload on code changes
- Security scan reports no HIGH or CRITICAL CVEs

---

Next: [Stage 2: Kubernetes Orchestration](stage-2-kubernetes.md)
