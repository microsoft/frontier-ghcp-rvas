# Stage 4: Advanced API Patterns and Debugging

[Back to Challenge 1: Web API Track](../challenge-1-web-api-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

This stage introduces a broken v2 API module and advanced features.

## Tasks

1. **Bug hunt**: Import the module from `stage-4-bugs/v2-routes.js` (or `v2_routes.py`). It contains 3 intentional bugs -- a security vulnerability, a missing authorization check, and a pagination logic error. Find and fix all three. Document each bug (what it is, why it is dangerous, and how you fixed it).
2. Real-time notifications via WebSocket: when a task is modified, notify the task's assignee in real time.
3. File attachments on tasks: `POST /tasks/:id/attachments` for upload, `GET /tasks/:id/attachments/:fileId` for download. Enforce a 5MB file size limit.
4. Audit log: record every mutation (create, update, delete) with who made the change, which field changed, before/after values, and timestamp. Make the audit log queryable via `GET /tasks/:id/audit`.
5. Rate limiting: 100 requests per minute per user. Return 429 when exceeded.

## Verification

- All 3 bugs are identified and fixed with documentation
- WebSocket connection delivers task change notifications
- File upload rejects files over 5MB; download returns correct file
- Audit log records all mutations with before/after values
- Rate limiter returns 429 after 100 requests within a minute

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can generate WebSocket boilerplate, rate limiting middleware, and audit log schemas. But identifying the 3 bugs in the v2 module requires reading and reasoning about code -- Copilot alone may not spot the security vulnerability or the off-by-one pagination error without guidance.

---

Previous: [Stage 3: Persistent Storage and Relationships](stage-3-storage.md) | Next: [Stage 5: Production Readiness](stage-5-production.md)
