# Stage 5: Production Readiness

[Back to Challenge 1: Web API Track](../challenge-1-web-api-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Prepare the API for production deployment.

## Tasks

1. Write an OpenAPI 3.0 specification that matches your actual API endpoints, request/response schemas, and error codes. Validate that the spec matches the implementation (no spec drift).
2. Caching: add ETag-based caching on `GET /tasks` and `GET /tasks/:id`. Subsequent requests with matching ETags return 304 Not Modified.
3. Graceful shutdown: when the server receives SIGTERM, stop accepting new connections, finish in-flight requests, close database connections, then exit.
4. Structured logging: all log output in JSON format with `timestamp`, `level`, `message`, `requestId` (correlation ID carried through the request lifecycle).
5. Load testing: use the skeleton in `load-test/benchmark.js` (or `benchmark.py`) to write a load test. The API must handle 500 concurrent connections with p95 latency under 200ms on the task listing endpoint.
6. Test suite achieving >80% code coverage, including edge cases for pagination boundaries, concurrent modifications, and auth token expiration.

## Verification

- OpenAPI spec validates with a linter and matches actual API behavior
- ETag caching returns 304 on unchanged data
- Server shuts down gracefully (no dropped connections)
- All log lines are parseable JSON with correlation IDs
- Load test passes performance targets
- Test coverage report shows >80%

## What Copilot Helps With vs. What Requires Your Judgment

Copilot generates OpenAPI specs, logging middleware, and test boilerplate efficiently. But calibrating load test thresholds, designing graceful shutdown sequences, and ensuring the spec accurately reflects your API (not a generic template) require manual verification and tuning.

---

Previous: [Stage 4: Advanced API Patterns and Debugging](stage-4-advanced.md)
