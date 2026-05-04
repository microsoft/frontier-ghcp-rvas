# Stage 5: Integration and Testing

[Back to Challenge 4: Frontend Track](../challenge-4-frontend-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Connect the frontend to a real (or mocked) backend and write thorough tests.

## Tasks

1. Connect the frontend to the Challenge 1 REST API, or set up MSW (Mock Service Worker) using the skeleton in `src/mocks/handlers.ts` to mock all API calls.
2. Offline support: implement a service worker that caches the app shell. When offline, show cached data and queue mutations for sync when connectivity returns.
3. Testing with at least 80% code coverage:
   - Unit tests for reducer functions and utility code
   - Integration tests for user flows (create task, edit task, delete with undo) using React Testing Library
   - Visual regression tests using Playwright screenshots for key pages
4. Create a Storybook instance documenting all components. Each component must have at least 3 stories: default, loading, and error states.

## Verification

- App fetches data from API (or MSW mock) and displays it
- App works offline (disable network in DevTools -- cached content displays, mutations queue)
- Tests pass with >80% coverage report
- Storybook builds and shows all components with multiple states

---

Previous: [Stage 4: Accessibility and Performance](stage-4-accessibility.md)
