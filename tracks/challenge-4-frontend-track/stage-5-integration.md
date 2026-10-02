# Stage 5: Integration and Testing

**Difficulty:** ⭐⭐⭐ | **Time:** 75 min

Connect the frontend to a mocked backend and test the task flow before final polish.

## Tasks

1. Install MSW and use the skeleton in `src/mocks/handlers.ts` to mock task API calls. Seed the mock with the supplied fixtures. Include a delayed response and a failed mutation.
2. Show loading and error states. Preserve entered values on submission failure and roll back a failed optimistic update.
3. Test the reducer and task flows with Vitest and React Testing Library. Cover create/edit validation, delete with undo, and a failed API mutation. Use `npm test -- --run` for a single test run.
4. Use Impeccable's `polish` on the completed task creation flow. Limit changes to problems you can verify within this stage. Rerun affected tests and the keyboard walkthrough after edits.
5. Add the Stage 1 before-and-after evidence to the pull request, together with any final polish decision. Explain what improved and how you checked that task behavior still works.

## Verification

- App fetches mocked data and displays loading and error states
- A failed mutation leaves task state consistent and offers a retry
- Tests cover the required user flows and pass
- Final polish preserves validation and keyboard behavior
- The pull request includes the required critique-and-fix evidence

## Stretch Tasks

- Replace the mocked API with a running Challenge 1 API.
- Add offline caching and queue mutations for later sync.
- Install Vitest's compatible coverage provider and reach at least 80% coverage.
- Add Playwright visual regression checks at fixed viewports.
- Add Storybook stories for relevant component states, including loading and error.

---

Previous: [Stage 4: Accessibility and Performance](stage-4-accessibility.md)
