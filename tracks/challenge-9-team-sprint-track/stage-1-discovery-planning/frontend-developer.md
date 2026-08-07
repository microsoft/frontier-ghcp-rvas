# Phase 1: Discovery and Planning -- Frontend Developer Tasks

**Time: ~1 hour setup + 30 min planning**

## Tasks

Plan to actually use the ui-builder agent for the component-structure judgment calls it's meant for, not just to check the box of creating it.

1. **Set up the frontend project** -- Choose a framework (React + Vite recommended). Scaffold the project:
   - Initialize with `npm create vite@latest` (or equivalent)
   - Set up routing (React Router or similar)
   - Create a basic layout component (header, sidebar, main content area)
   - Add a placeholder home page

2. **Review the Spark handover repo** -- The PO exported the GitHub Spark prototype into a repository. Clone it and study the generated code. This repo is the contract -- it defines the screens, data model, and user flows the team agreed to build. Decide what to keep as-is, what to adapt into your chosen framework, and what to rewrite from scratch. Use the Spark-generated components as a visual and structural reference, not necessarily as production code.

3. **Write custom instructions** -- Add frontend context to `.github/copilot-instructions.md`: framework, component patterns, styling approach (Tailwind, CSS modules, etc.).

4. **Create a frontend agent** -- Create `.github/agents/ui-builder.agent.md` with component patterns and styling conventions.

5. **Coordinate with the backend developer** -- Review the draft API spec. Agree on endpoint shapes so you can start building against mocked data if the API is not ready yet.

6. **Sprint planning** -- Join the PO's planning session. Pick your Sprint 1 stories.

## Verification

- [ ] Frontend project scaffolded and rendering in browser
- [ ] Basic layout and routing in place
- [ ] Custom instructions and agent created

---

Previous: [Phases](../phases.md) | Next: [Phase 2: Sprint 1 -- Frontend Developer Tasks](../phase-2-sprint-1-build/frontend-developer.md)
