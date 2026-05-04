# Challenge 4 Track: Frontend

**Duration:** 6-8 hours

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Building modern, interactive user interfaces with GitHub Copilot

## Who Is This For

- Frontend Developers and UI/UX Engineers
- React Developers
- Web Developers focused on client-side
- Full-stack developers interested in frontend

## Prerequisites

- JavaScript fundamentals
- Basic React knowledge (components, props, state)
- HTML and CSS understanding
- Familiarity with npm/package managers
- TypeScript helpful but not required

## Technology Stack

- **React 18+** -- UI framework
- **TypeScript** -- Type safety
- **Modern CSS** -- Styling (CSS Modules, Styled Components, or Tailwind)
- **State Management** -- Context API or Redux
- **Testing** -- Jest and React Testing Library

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Project context (React version, TypeScript, styling approach)
- Component standards and patterns
- Accessibility requirements (WCAG compliance level)
- Testing approach and coverage goals

### Suggested Agents

**Agents to consider creating:**

- **React Developer Agent** -- Expert in React patterns, hooks, and TypeScript
- **UI Stylist Agent** -- Specialized in CSS, responsive design, and animations
- **Accessibility Expert Agent** -- Focused on WCAG compliance and keyboard navigation

### Open the Challenge

Navigate to `challenges/challenge-4-frontend/`, install dependencies (`npm install`), and start the dev server (`npm run dev`). Open the starter files -- `src/App.tsx` is an empty shell and `src/types/task.ts` has basic type definitions. Work through the stages in order.

---

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Component Architecture and Layout](challenge-4-frontend-track/stage-1-component-architecture.md) | ⭐ | 60-75 min | Responsive dashboard, routing, static components |
| 2 | [State Management and CRUD](challenge-4-frontend-track/stage-2-state-management.md) | ⭐⭐ | 60-90 min | Context + useReducer, forms, optimistic updates, undo |
| 3 | [Advanced Interactions](challenge-4-frontend-track/stage-3-advanced-interactions.md) | ⭐⭐ | 60-90 min | Theme switching, drag-and-drop Kanban, keyboard shortcuts, toasts |
| 4 | [Accessibility and Performance](challenge-4-frontend-track/stage-4-accessibility.md) | ⭐⭐⭐ | 60-90 min | WCAG AA compliance, fix 5 a11y bugs, virtualized list, code splitting |
| 5 | [Integration and Testing](challenge-4-frontend-track/stage-5-integration.md) | ⭐⭐⭐ | 60-90 min | API integration or MSW mocking, offline support, >80% test coverage |

Each stage builds on the previous one. Copilot excels at scaffolding React components and generating TypeScript types. The later stages demand architectural decisions (state management patterns, performance trade-offs) and finding accessibility violations that require understanding what makes a UI usable for everyone.

> **Short on time?** In the compressed schedule, skip keyboard shortcuts in Stage 3, do only the a11y bug hunt in Stage 4, and skip offline support and Storybook in Stage 5.

## Tips for Using Copilot on This Track

- Define your TypeScript interfaces first, then generate the components that use them. Types give Copilot much better context.
- Describe a component's props and behavior in a comment before asking Copilot to generate it. A few lines of intent produce better JSX than a vague prompt.
- Keep the file you're testing open when asking for test cases -- Copilot reads it as context.
- For state management hooks, outline the public API (what it returns, what side effects it has) before generating the implementation.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
