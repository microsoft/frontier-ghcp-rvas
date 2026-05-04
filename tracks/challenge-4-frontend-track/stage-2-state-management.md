# Stage 2: State Management and CRUD

[Back to Challenge 4: Frontend Track](../challenge-4-frontend-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-90 min

Replace static data with real state management. Users must be able to create, edit, and delete tasks.

## Tasks

1. Implement state management using Context API with `useReducer`. All task state goes through a single reducer -- no scattered `useState` calls for task data.
2. Task CRUD: create, edit, and delete with confirmation dialogs on destructive actions.
3. Form validation: title required (3-100 characters), due date must be in the future, description max 500 characters. Show validation errors inline.
4. Optimistic UI updates: show changes immediately in the UI, roll back if the action fails.
5. Undo support: at minimum, undo delete (toast with "Undo" action before deletion is finalized).

## Verification

- Task state persists across route navigation (no reset when changing pages)
- Validation prevents invalid form submissions with visible error messages
- Undo reverts the last delete action
- Optimistic updates show immediately (no loading spinner for local operations)

---

Previous: [Stage 1: Component Architecture and Layout](stage-1-component-architecture.md) | Next: [Stage 3: Advanced Interactions](stage-3-advanced-interactions.md)
