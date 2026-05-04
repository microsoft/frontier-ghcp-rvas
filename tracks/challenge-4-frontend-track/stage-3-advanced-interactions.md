# Stage 3: Advanced Interactions

[Back to Challenge 4: Frontend Track](../challenge-4-frontend-track.md)

**Difficulty:** ⭐⭐ | **Time:** 60-90 min

Add polish and interactivity that goes beyond basic CRUD.

## Tasks

1. Dark/light theme with system preference detection (`prefers-color-scheme`) and localStorage persistence. Theme applies to all components.
2. Drag-and-drop Kanban board view: tasks can be dragged between status columns (Todo, In Progress, Done). Dropping a task in a column updates its status.
3. Keyboard shortcuts: `n` to open new task form, `Escape` to close modals, arrow keys to navigate the task list, `d` to delete the selected task.
4. Toast notification system: success, error, and info variants. Auto-dismiss after 5 seconds with option to dismiss manually.
5. Loading skeleton components (not spinners) for all data-loading states.

## Verification

- Theme persists across page reload
- Drag-and-drop updates task status in state
- All keyboard shortcuts work (test each one)
- Toasts auto-dismiss after 5 seconds and can be manually closed
- Skeleton components display while loading (simulate with a delay)

---

Previous: [Stage 2: State Management and CRUD](stage-2-state-management.md) | Next: [Stage 4: Accessibility and Performance](stage-4-accessibility.md)
