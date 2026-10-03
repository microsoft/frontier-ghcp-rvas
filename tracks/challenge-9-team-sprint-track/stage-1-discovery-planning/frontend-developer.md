# Stage 1: Discovery and Planning -- Frontend Developer Tasks

**Time: ~1 hour setup + 30 min planning**

## Tasks

Use your ui-builder agent to review component structure.

1. **Set up the frontend project** -- Choose a framework (React + Vite recommended). Scaffold the project:
   - Initialize with `npm create vite@latest` (or equivalent)
   - Set up routing (React Router or similar)
   - Create a basic layout component (header, sidebar, main content area)
   - Add a placeholder home page

2. Clone the Spark handover repo and study the generated code. It defines the agreed screens, data model, and user flows. Decide which components to keep, adapt, or rewrite for your chosen framework. Treat the export as a visual and structural reference; you do not have to use its code in production.

3. **Write custom instructions** -- Add frontend context to `.github/copilot-instructions.md`: framework, component patterns, styling approach (Tailwind, CSS modules, etc.).

4. **Create a frontend agent** -- Create `.github/agents/ui-builder.agent.md` with component patterns and styling conventions.

5. **Coordinate with the backend developer** -- Review the draft API spec. Agree on endpoint shapes so you can start building against mocked data if the API is not ready yet.

6. **Sprint planning** -- Join the PO's planning session. Pick your Sprint 1 stories.

## Verification

- [ ] Frontend project scaffolded and rendering in browser
- [ ] Basic layout and routing in place
- [ ] Custom instructions and agent created

---

Previous: [Stages](../stages.md) | Next: [Stage 2: Sprint 1 -- Frontend Developer Tasks](../stage-2-sprint-1-build/frontend-developer.md)
