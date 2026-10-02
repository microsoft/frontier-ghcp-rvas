# Stage 1: Component Architecture and Layout

**Difficulty:** ⭐ | **Time:** 60 min

Build the visual foundation with static data. Focus on component composition and responsive design.

## Tasks

Before you scaffold the first component, use what you set up: keep your repository instructions open for the accessibility and styling conventions, bring in the agent you built for component-structure judgment, and run your type-first scaffolding skill so the types drive the layout instead of guessing at props.

1. Define who uses the dashboard and what they need to do first. Use Impeccable's `shape` guidance to choose the layout and visual hierarchy. Keep the work focused on finding and updating tasks.
2. Build a responsive dashboard layout with header, sidebar, and main content area using Tailwind CSS.
3. Create TaskCard, TaskList, and Dashboard components with proper TypeScript interfaces.
4. Implement React Router with at least 3 routes: Dashboard, Task List, and Task Detail.
5. Use `sampleTasks` from `src/fixtures/tasks.ts` for now -- no state management yet. Check mixed statuses and the long title.
6. **Complete a critique-and-fix cycle.** Capture the first working dashboard, use Impeccable's `critique` to identify a concrete usability problem, and decide whether to apply its recommendation. Fix at least one problem and capture the result at the same viewport. Record an accepted or rejected recommendation and your reason in the pull request.

## Verification

- App renders correctly at 3 breakpoints: mobile (375px), tablet (768px), desktop (1440px)
- Routes navigate correctly without page reload
- TypeScript compiles in strict mode with no errors
- Components accept properly typed props
- The long task title stays readable without obscuring actions
- Before-and-after screenshots show the change; the pull request explains the problem and how you checked the fix

---

Previous: [Stages](stages.md) | Next: [Stage 2: State Management and CRUD](stage-2-state-management.md)
