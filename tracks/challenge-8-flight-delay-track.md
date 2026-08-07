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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Python version, key data science libraries (pandas, scikit-learn)
- Backend framework choice (Flask or FastAPI) and API design conventions
- Frontend framework choice and component patterns
- Code quality standards (PEP 8 for Python, ESLint for JS/TS)
- Testing expectations
- The project's overall goal: flight delay prediction from FAA data

### Suggested Agents

**Agents to consider creating:**

- **Data Scientist Agent** -- Expert in EDA, feature engineering, and model training
- **API Engineer Agent** -- Focused on REST API design, Flask/FastAPI, and data serialization
- **Frontend Developer Agent** -- Specialized in building UIs with your chosen framework
- **Full-Stack Integrator Agent** -- Understands the entire pipeline from model to UI

### Open the Challenge

Navigate to `challenges/challenge-8-flight-delay/`. A dedicated devcontainer is provided at `.devcontainer/challenge-8-flight-delay/` with Python 3.11, Jupyter, scikit-learn, Flask, FastAPI, and Node.js LTS.

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

Next: [Phases](challenge-8-flight-delay-track/phases.md)
