# Stage 3: Advanced Interactions

**Difficulty:** ⭐⭐ | **Time:** 30 min

Make the task form's feedback clear and handle an empty task list.

## Tasks

1. Show a useful empty state with an accessible action to create the first task.
2. Make validation messages explain how to fix the input. Preserve entered values after a failed submission.
3. Use Impeccable's `critique` on the task creation flow. Apply a useful recommendation or explain why the current behavior should stay.
4. Make dialog dismissal work with Escape and return focus to the trigger. Keep the delete undo action keyboard-accessible.

If your UI agent or custom skill produces feedback that conflicts with the Stage 2 state model, refine that customization before another pass.

## Verification

- An empty list explains the next action
- Invalid input has a clear inline error without losing entered values
- Dialog dismissal returns focus; delete undo works with the keyboard
- The review does not change task data or break validation

## Stretch Tasks

- Add a dark/light theme with system preference detection and persistence.
- Build a drag-and-drop Kanban board with a keyboard-accessible way to change status.
- Add task-list shortcuts that do not intercept typing in form fields.
- Add loading skeletons after connecting the API in Stage 5.

---

Previous: [Stage 2: State Management and CRUD](stage-2-state-management.md) | Next: [Stage 4: Accessibility and Performance](stage-4-accessibility.md)
