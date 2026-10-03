# Challenge 4 Track: Frontend

**Duration:** 4-6 hours (five-hour core; stretch tasks are optional)

**Difficulty:** ⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Build an accessible task dashboard with GitHub Copilot and use Impeccable to improve one user flow

## Who is this for

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
- A current VS Code version with Copilot Chat access and a trusted workspace
- Network access to npm and Impeccable's skill and engine downloads

## Technology stack

- **React 18+** -- UI framework
- **TypeScript** -- Type safety
- **Modern CSS** -- Styling (CSS Modules, Styled Components, or Tailwind)
- **State Management** -- Context API with useReducer
- **Testing** -- Vitest and React Testing Library; MSW for API mocking
- **Impeccable** -- An external design skill installed by participants with npx

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Use the dedicated devcontainer at `.devcontainer/challenge-4-frontend/`. It installs the frontend tooling. **Install Impeccable yourself after the common clean setup**, which removes existing customizations. The devcontainer does not install it for you.

Navigate to `challenges/challenge-4-frontend/`, install dependencies (`npm install`), and start the dev server (`npm run dev`). Read `src/App.tsx`, the task types, and `src/fixtures/tasks.ts` before writing instructions. The app is an empty shell; the fixtures provide mixed statuses and a long title for layout reviews. Work through the stages in order.

### Install and check Impeccable

Follow the [shared Impeccable installation and discovery checks](getting-started.md#5-install-impeccable-when-your-track-uses-it).
Use `src/App.tsx` in the challenge folder for the read-only preflight.
Keep your own custom skill separate from the supplied skill, and do not edit
Impeccable's files to hold project instructions.

### Use Impeccable on this track

Keep Impeccable's working directory at `challenges/challenge-4-frontend/` so it reviews the task dashboard rather than the repository's documentation site. Initialize its product context there before planning the UI. Describe the intended users and their main task; inspect any generated context files for accuracy.

Use `shape` before building the layout, then `critique` to review the first working version. Later, use `audit` for an additional quality review and `polish` on the completed task flow. Follow the command syntax offered by the installed skill.

**One critique-and-fix cycle is required.** Capture the same page before and after the change. In the pull request, explain the problem, which recommendation you accepted or rejected, and how you checked the result. Keep screenshots and review evidence in the pull request; do not create a separate workshop report. Inspect generated files before committing and leave runtime caches out of the change.

Impeccable's feedback is advisory. Check the rendered app yourself, and keep keyboard testing and axe checks as separate requirements.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Project context (React version, TypeScript, styling approach)
- Component standards and patterns
- Accessibility requirements (WCAG compliance level)
- Testing approach and coverage goals
- Intended users, the main task flow, and visual constraints that Impeccable must respect
- Non-negotiable: every interactive component ships keyboard-navigable, not retrofitted later

### Suggested custom agents

- Use a React Developer Agent to propose component boundaries, hooks, and prop types from a feature description.
- Use a UI Stylist Agent to review layout, breakpoints, and animation for a working component.
- Use an Accessibility Expert Agent to check a rendered component or its JSX for keyboard navigation, focus order, and ARIA issues before marking it done.

### Suggested custom skills

- A Component Test Scaffolding Skill generates render, interaction, and snapshot tests for a component's props and states after its first working version.
- A Type-First Scaffolding Skill creates a component shell, prop destructuring, and default state from a TypeScript interface before you write JSX.

Impeccable supplies general design guidance. Author a small project-specific skill for a repeatable check that matters to this dashboard, such as reviewing task-form states. Define what it checks and what evidence it returns. Avoid copying Impeccable's commands into a second skill.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "react component agent", "accessibility review skill", and "typescript instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Define your TypeScript interfaces first, then generate the components that use them. Types give Copilot much better context.
- Describe a component's props and behavior in a comment before asking Copilot to generate it. A few lines of intent produce better JSX than a vague prompt.
- Keep the file you're testing open when asking for test cases so Copilot can use it as context.
- For state management hooks, outline the public API (what it returns, what side effects it has) before generating the implementation.
- Give Impeccable a specific page or flow to review. Apply the smallest useful change and rerun the relevant checks.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Impeccable source and installation](https://github.com/pbakaus/impeccable)

---

Next: [Stages](challenge-4-frontend-track/stages.md)
