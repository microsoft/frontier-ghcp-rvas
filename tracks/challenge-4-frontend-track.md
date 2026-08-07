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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-4-frontend/`, install dependencies (`npm install`), and start the dev server (`npm run dev`). Open the starter files -- `src/App.tsx` is an empty shell and `src/types/task.ts` has basic type definitions -- and read them before writing any instructions. Work through the stages in order.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- Project context (React version, TypeScript, styling approach)
- Component standards and patterns
- Accessibility requirements (WCAG compliance level)
- Testing approach and coverage goals
- Non-negotiable: every interactive component ships keyboard-navigable, not retrofitted later

### Suggested Custom Agents

- **React Developer Agent** -- Applies judgment on component structure: when to split a component, which hook fits the state need, and how prop types should shape the API. Give it a feature description; it proposes the component breakdown. Use it when starting a new component, not for styling decisions.
- **UI Stylist Agent** -- Focuses on visual and responsive design judgment: layout approach, breakpoints, and animation restraint. Give it a component and its intended look; it proposes the styling approach. Use it once the component's behavior works.
- **Accessibility Expert Agent** -- Applies WCAG judgment: keyboard navigation, focus order, and ARIA usage that fits the actual markup. Give it a rendered component or its JSX; it flags gaps. Use it before considering a component done.

### Suggested Custom Skills

- **Component Test Scaffolding Skill** -- A repeatable sequence that generates a test file matching a component's props and states: render, interaction, and snapshot cases in the same order every time. Use it right after a component's first working version.
- **Type-First Scaffolding Skill** -- A fixed workflow that starts from a TypeScript interface and generates the component shell, prop destructuring, and default state from it. Use it before writing any JSX, so the types drive the implementation.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "react component agent", "accessibility review skill", and "typescript instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- Define your TypeScript interfaces first, then generate the components that use them. Types give Copilot much better context.
- Describe a component's props and behavior in a comment before asking Copilot to generate it. A few lines of intent produce better JSX than a vague prompt.
- Keep the file you're testing open when asking for test cases -- Copilot reads it as context.
- For state management hooks, outline the public API (what it returns, what side effects it has) before generating the implementation.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)

---

Next: [Stages](challenge-4-frontend-track/stages.md)
