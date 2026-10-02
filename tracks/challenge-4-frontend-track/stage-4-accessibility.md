# Stage 4: Accessibility and Performance

**Difficulty:** ⭐⭐⭐ | **Time:** 45 min

This stage includes a pre-built component with intentional accessibility violations.

## Tasks

1. Use Impeccable's `audit` on the dashboard and task form. Check each finding against the rendered UI before changing code.
2. Run an axe-core accessibility audit on the app and fix reported violations. A clean automated scan alone does not establish WCAG 2.1 AA compliance.
3. **Bug hunt:** Render `src/audit/AccessibleCard.tsx` in a temporary review view. It contains five intentional accessibility issues involving image text, keyboard interaction, color-only status, an unlabeled icon button, and an overlay's Escape behavior. Inspect the hidden overlay in code and make it reachable to test dismissal. Fix all five, then remove the temporary view.
4. Walk through task creation and delete undo using only the keyboard. Check focus visibility and dialog focus return. Confirm that status is understandable without color and that the page works at 200% zoom.

## Verification

- axe-core reports 0 violations
- All 5 accessibility bugs in AccessibleCard.tsx are identified and fixed
- The main task flow works with the keyboard and at 200% zoom
- Impeccable findings are checked against browser behavior; accepted fixes preserve CRUD and undo

## Stretch Tasks

- Virtualize the task list and check scrolling with 10,000 tasks.
- Split existing routes with `React.lazy` and verify separate network chunks.
- Measure an initial bundle under 200KB gzipped and LCP under 2.5 seconds. Record the viewport and measurement conditions.

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can help set up axe-core and suggest fixes. But you still need to test browser behavior and inspect hidden UI. Neither Impeccable's feedback nor a clean axe scan replaces manual keyboard checks.

---

Previous: [Stage 3: Advanced Interactions](stage-3-advanced-interactions.md) | Next: [Stage 5: Integration and Testing](stage-5-integration.md)
