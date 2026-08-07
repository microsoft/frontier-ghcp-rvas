# Stage 3: Build the Frontend

**Duration:** 2-3 hours
**Focus:** Frontend, UI/UX, API integration

## Objective

Create a user-facing web application that allows someone to select a day of the week and a destination airport, and then see the predicted probability of their flight being delayed.

## Requirements

1. **Airport Dropdown** -- Fetch the list of airports from `GET /airports` and display them in a searchable dropdown, sorted alphabetically.
2. **Day of Week Selector** -- Display the 7 days of the week for selection (e.g., dropdown or button group).
3. **Predict Button** -- On click, call `GET /predict?day_of_week=X&airport_id=Y` and display the result.
4. **Result Display** -- Show the delay probability in a clear, user-friendly way (e.g., percentage, progress bar, color-coded indicator).
5. **Loading & Error States** -- Show a loading indicator while the API is called. Display meaningful error messages if the API fails.
6. **Responsive Design** -- The UI should work on both desktop and mobile screens.

## Getting Started

1. Navigate to `challenges/challenge-8-flight-delay/client/`.
2. Review the starter files: `index.html`, `package.json`, `src/main.ts`.
3. Choose your framework:
   - **Vanilla TypeScript** -- build directly in `src/main.ts`.
   - **React/Svelte/Vue** -- install your framework and set up the project.
4. Install dependencies: `npm install`.
5. Start dev server: `npm run dev`.

## Copilot Tips for This Stage

- Describe your UI in comments before writing code -- Copilot will generate component structures.
- Ask Copilot: *"Create a form with a dropdown for airports and days, with a submit button"*.
- Use `/fix` if you run into CORS or fetch issues.
- Ask Copilot to add styling -- describe what you want in natural language.

## Success Criteria

- [ ] Airport dropdown is populated from the API
- [ ] Day of week selection works
- [ ] Prediction API is called on submit
- [ ] Result is displayed clearly to the user
- [ ] Loading and error states are handled
- [ ] UI is reasonably styled and responsive

---

Previous: [Stage 2: Build the Prediction API](stage-2-prediction-api.md) | Next: [Stage 4: Polish and Advanced Features](stage-4-polish.md)
