# Challenge 8 Track: Full-Stack Flight Delay Predictor

**Duration:** 4-6 hours (five-hour core; advanced work is optional)

**Difficulty:** ⭐⭐⭐

**Focus:** Build a full-stack application with data science, API engineering, and frontend work using GitHub Copilot

## Who is this for

- Full-stack developers looking for a deep, cross-domain challenge
- Teams that finished their primary track early
- Experienced engineers who want to push Copilot's capabilities across multiple domains
- Anyone who wants to combine ML, API, and UI skills in a single project

## Prerequisites

- Python programming experience
- Basic understanding of machine learning concepts (classification, train/test split)
- Familiarity with REST APIs (Flask, FastAPI, or Express.js)
- Frontend development basics (HTML/CSS/JS or a framework like React, Svelte, Vue)
- Comfort working in Jupyter Notebooks

## Technology stack

- **Python 3.11+** -- data analysis and API
- **Jupyter Notebooks** -- data exploration and model building
- pandas, numpy, scikit-learn, matplotlib, seaborn -- data science
- **Flask or FastAPI** -- backend API serving the model and airport data
- **TypeScript / JavaScript** -- frontend application
- Framework of your choice (React, Svelte, Vue, or vanilla)
- **Vite** -- frontend build tooling (provided)
- **Impeccable** -- Participant-installed skill for reviewing the prediction flow

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Navigate to `challenges/challenge-8-flight-delay/`. A dedicated devcontainer is provided at `.devcontainer/challenge-8-flight-delay/` with Python 3.11, Jupyter, scikit-learn, Flask, FastAPI, and Node.js LTS. Read through the starter notebook and scaffolding across all three layers before writing any instructions.

### Install and use Impeccable

Follow the [shared manual installation and discovery checks](getting-started.md#5-install-impeccable-when-your-track-uses-it)
after clean setup. Preflight `client/src/main.ts`. In Stage 3, review the airport
selection and prediction result from the client folder. Fix one usability
problem without changing the model or API contract. **Show probability as an
estimate, never a guaranteed outcome.**

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Python version, key data science libraries (pandas, scikit-learn)
- Backend framework choice (Flask or FastAPI) and API design conventions
- Frontend framework choice and component patterns
- Code quality standards (PEP 8 for Python, ESLint for JS/TS)
- Testing expectations
- The project's overall goal: flight delay prediction from FAA data
- Non-negotiable: the API's input schema must match what the model actually expects, and the frontend must match the API in turn

### Suggested custom agents

- Use a Data Scientist Agent to recommend features, imbalance handling, and models from the flight dataset or notebook.
- Use an API Engineer Agent to propose request and response schemas, model loading, and validation from the model's expected inputs.
- Use a Frontend Developer Agent to propose form components, state handling, and result presentation from the API contract.

### Suggested custom skills

- An End-to-End Wiring Skill checks the model, API, and frontend schemas and traces a request through all three layers. Run it after changes to the model's feature set.
- A Cross-Layer Debugging Skill identifies the failing layer from the full traceback and checks its neighboring contract for CORS, serialization, or model-loading errors.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "full-stack ML agent", "API integration skill", and "flask instructions" before you draft your own.

---

## Tips for using Copilot on this track

- This track spans Python, Flask, and TypeScript. When switching layers, a comment describing the context ("Flask prediction endpoint" or "React form component") helps Copilot stay oriented.
- For the API, describe endpoint inputs and responses in comments before generating code.
- For CORS or model-loading errors, give Copilot the full traceback.
- For the frontend, describe the form fields and data flow in a comment. Copilot generates better UI code when it knows what API it's calling.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)

---

Next: [Stages](challenge-8-flight-delay-track/stages.md)
