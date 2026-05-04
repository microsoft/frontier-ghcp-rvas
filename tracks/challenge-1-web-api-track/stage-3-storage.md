# Stage 3: Persistent Storage and Relationships

[Back to Challenge 1: Web API Track](../challenge-1-web-api-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-90 min

Replace the in-memory store with a real database and add data relationships.

## Tasks

1. Replace the in-memory arrays with SQLite. Use knex or Sequelize for Node.js, or SQLAlchemy for Python.
2. Create database migrations for the initial schema (users, tasks tables).
3. Add a `categories` entity. Tasks can belong to multiple categories (many-to-many relationship).
4. Add `comments` on tasks (one-to-many). Each comment has a body, author, and timestamp.
5. Bulk operations: `POST /tasks/bulk/categorize` assigns a category to multiple task IDs in a single transactional request. If any task ID is invalid, the entire operation rolls back.

## Verification

- Restart the server and data persists (no data loss)
- Many-to-many relationship between tasks and categories works (create, assign, query)
- Comments are associated with tasks and retrievable
- Bulk categorize operation is atomic: all-or-nothing on invalid task IDs

---

Previous: [Stage 2: Authentication and Authorization](stage-2-auth.md) | Next: [Stage 4: Advanced API Patterns and Debugging](stage-4-advanced.md)
