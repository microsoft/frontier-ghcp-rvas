# Phase 1: Technical Planning -- Frontend Developer Tasks

[Back to Phase 1 Overview](../phase-1-technical-planning.md) | [Back to Technical Team Sprint Track](../../bonus-tech-sprint-track.md)

**Time: ~1 hour setup + 30 min planning**

## Tasks

1. **Set up the frontend project** -- Choose a framework (React + Vite recommended). Scaffold the project:
   - Initialize with `npm create vite@latest` (or equivalent)
   - Set up routing (React Router or similar)
   - Create a basic layout component (header, sidebar or nav, main content area)
   - Add a placeholder home page

2. **Design the component hierarchy** -- Based on the functional spec, sketch out the pages and components you will need. Create a quick outline in `docs/frontend-components.md`:
   - Trail list page (with filter controls)
   - Trail detail page (with condition reports section)
   - Condition report form
   - Dashboard page (if scoped for Sprint 2)
   - Navigation and layout components

3. **Write custom instructions** -- Add frontend context to `.github/copilot-instructions.md`: framework, component patterns, styling approach (Tailwind, CSS modules, etc.).

4. **Create a frontend agent** -- Create `.github/agents/ui-builder.agent.md` with component patterns and styling conventions.

5. **Coordinate with the backend developer** -- Review the draft API spec. Agree on endpoint shapes so you can start building against mocked data if the API is not ready yet.

6. **Write user stories** -- Create 3-5 GitHub Issues for the frontend-facing features (trail browsing, condition report submission, navigation). Use the template in `challenges/bonus-4-tech-sprint/templates/user-story-issue.md`.

7. **Sprint planning** -- Join the planning session. Pick your Sprint 1 stories.

## Verification

- [ ] Frontend project scaffolded and rendering in browser
- [ ] Basic layout and routing in place
- [ ] Component hierarchy documented
- [ ] Custom instructions and agent created

---

Next: [Phase 2 -- Frontend Developer Tasks](../phase-2-sprint-1-build/frontend-developer.md)
