# Stage 1: Basic CRUD

[Back to Challenge 1: Web API Track](../challenge-1-web-api-track.md)

**Difficulty:** ⭐ | **Time:** 60-75 min

Build the core task management endpoints using the in-memory data store.

## Tasks

1. Implement task CRUD endpoints: `POST /tasks`, `GET /tasks`, `GET /tasks/:id`, `PUT /tasks/:id`, `DELETE /tasks/:id`, `PATCH /tasks/:id/complete`.
2. Input validation: title is required (3-100 characters), status must be a valid enum value (`todo`, `in_progress`, `done`), priority must be valid (`low`, `medium`, `high`).
3. Proper HTTP status codes: 201 for creation, 400 for invalid input, 404 for not found, 200 for success.
4. Filter tasks by status and priority via query parameters.
5. Search tasks by title/description via a `q` query parameter.
6. Pagination: `page` and `limit` query parameters with sensible defaults.

## Verification

- All CRUD endpoints return correct responses
- Invalid input returns 400 with a descriptive error message
- Filtering, search, and pagination work correctly
- Non-existent task IDs return 404

---

Next: [Stage 2: Authentication and Authorization](stage-2-auth.md)
