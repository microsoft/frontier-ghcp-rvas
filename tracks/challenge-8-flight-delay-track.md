# Challenge 8 Track: Full-Stack Flight Delay Predictor

**Duration:** 8-12 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Full-stack application development -- data science, API engineering, and frontend -- with GitHub Copilot

## Who Is This For

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

## Technology Stack

- **Python 3.11+** -- data analysis and API
- **Jupyter Notebooks** -- data exploration and model building
- pandas, numpy, scikit-learn, matplotlib, seaborn -- data science
- **Flask or FastAPI** -- backend API serving the model and airport data
- **TypeScript / JavaScript** -- frontend application
- Framework of your choice (React, Svelte, Vue, or vanilla)
- **Vite** -- frontend build tooling (provided)

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-8-flight-delay/`. A dedicated devcontainer is provided at `.devcontainer/challenge-8-flight-delay/` with Python 3.11, Jupyter, scikit-learn, Flask, FastAPI, and Node.js LTS. Read through the starter notebook and scaffolding across all three layers before writing any instructions.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- Python version, key data science libraries (pandas, scikit-learn)
- Backend framework choice (Flask or FastAPI) and API design conventions
- Frontend framework choice and component patterns
- Code quality standards (PEP 8 for Python, ESLint for JS/TS)
- Testing expectations
- The project's overall goal: flight delay prediction from FAA data
- Non-negotiable: the API's input schema must match what the model actually expects, and the frontend must match the API in turn

### Suggested Custom Agents

- **Data Scientist Agent** -- Applies judgment on EDA and feature engineering for flight delay data: which features carry signal, how to handle imbalance, and which model family fits. Give it the dataset or notebook state; it proposes the next analytical step. Use it during model development, not once the model is serving predictions.
- **API Engineer Agent** -- Focuses on REST design and serialization for the prediction endpoint: request/response shape, model loading strategy, and error handling for bad input. Give it the model's expected inputs; it proposes the endpoint contract. Use it when wiring the model into Flask/FastAPI.
- **Frontend Developer Agent** -- Applies UI judgment for the chosen framework: form design for prediction inputs, state handling, and how to present a result. Give it the API contract; it proposes the component structure. Use it once the API is callable.

### Suggested Custom Skills

- **End-to-End Wiring Skill** -- A fixed sequence for verifying the pipeline from model to UI: confirm the API's input schema matches what the model expects, confirm the frontend sends and renders that same shape, and trace one request through all three layers. Run it after any change to the model's feature set.
- **Cross-Layer Debugging Skill** -- A repeatable approach for CORS, serialization, or model-loading errors: capture the full traceback, identify which layer raised it, and check that layer's contract with its neighbor. Use it whenever a request fails without an obvious cause.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "full-stack ML agent", "API integration skill", and "flask instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- This track spans Python, Flask, and TypeScript. When switching layers, a comment describing the context ("Flask prediction endpoint" or "React form component") helps Copilot stay oriented.
- For the API, sketch your endpoints as comments before generating code. Copilot needs the blueprint to produce sensible Flask routes.
- When you hit CORS or model-loading errors, paste the traceback directly -- Copilot handles stack-specific debugging well when it can see the error.
- For the frontend, describe the form fields and data flow in a comment. Copilot generates better UI code when it knows what API it's calling.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)

---

Next: [Stages](challenge-8-flight-delay-track/stages.md)
