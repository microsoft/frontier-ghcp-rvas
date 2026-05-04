# Stage 2: Authentication and Authorization

[Back to Challenge 1: Web API Track](../challenge-1-web-api-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

Add user management and protect all task endpoints.

## Tasks

1. Registration endpoint: `POST /auth/register` accepting email and password. Hash passwords with bcrypt. Validate email format.
2. Login endpoint: `POST /auth/login` returning a JWT token.
3. Authentication middleware: all task endpoints require a valid JWT in the `Authorization` header.
4. User-scoped tasks: users can only see and modify their own tasks. The `userId` is embedded in the JWT.
5. Role-based access: add an `admin` role. Admin users can list all tasks across all users via `GET /admin/tasks`.
6. Token refresh endpoint: `POST /auth/refresh` issuing a new token.

## Verification

- Unauthenticated requests to task endpoints return 401
- Users cannot access, modify, or delete another user's tasks
- Admin users can list all tasks; non-admin users cannot access `/admin/tasks`
- Token refresh works and old tokens can optionally be invalidated

---

Previous: [Stage 1: Basic CRUD](stage-1-basic-crud.md) | Next: [Stage 3: Persistent Storage and Relationships](stage-3-storage.md)
