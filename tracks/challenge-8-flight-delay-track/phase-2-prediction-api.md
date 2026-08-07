# Phase 2: Build the Prediction API

**Duration:** 2-3 hours
**Focus:** REST API, Flask or FastAPI, model serving

## Objective

Create a REST API that serves the trained model and the list of airports so the frontend can consume them.

## Requirements

1. **`GET /predict`** -- Accepts `day_of_week` (int, 1-7) and `airport_id` (int) as query parameters. Loads the trained model, runs `predict_proba`, and returns:

   ```json
   {
     "delay_probability": 0.23,
     "confidence": 0.77
   }
   ```

   Where `delay_probability` is the chance the flight is delayed >15 min, and `confidence` is the model's certainty.

2. **`GET /airports`** -- Returns the list of airports from `airports.csv`, sorted alphabetically by name:

   ```json
   [
     { "id": 10397, "name": "Atlanta Hartsfield-Jackson International" },
     { "id": 12478, "name": "John F. Kennedy International" }
   ]
   ```

3. **CORS** -- Enable cross-origin requests so the frontend can call this API.

4. **Input validation** -- Validate that `day_of_week` is between 1 and 7, and that `airport_id` exists in the dataset.

5. **Error handling** -- Return meaningful error messages with appropriate HTTP status codes.

## Getting Started

1. Navigate to `challenges/challenge-8-flight-delay/server/`.
2. Open `app.py` -- it contains a description of what to build.
3. Copy your `model.pkl` and `airports.csv` (from Phase 1) into the `server/` folder.
4. Install dependencies: `pip install -r requirements.txt`.
5. Use Copilot to implement the endpoints.

## Copilot Tips for This Phase

- Start the file with a multi-line comment describing your API -- Copilot uses this to generate endpoint code.
- Ask Copilot: *"Create a Flask API that loads a scikit-learn model and serves predictions"*.
- Use Agent Mode for scaffolding, then refine individual endpoints.
- Ask Copilot to add Swagger/OpenAPI documentation if using FastAPI.

## Success Criteria

- [ ] `/predict` endpoint works and returns delay probability
- [ ] `/airports` endpoint returns sorted list of airports
- [ ] CORS is enabled
- [ ] Input validation is implemented
- [ ] Error handling with proper HTTP status codes
- [ ] API tested manually (e.g., via browser or curl)

---

Previous: [Phase 1: Data Exploration and Model Building](phase-1-data-exploration.md) | Next: [Phase 3: Build the Frontend](phase-3-frontend.md)
