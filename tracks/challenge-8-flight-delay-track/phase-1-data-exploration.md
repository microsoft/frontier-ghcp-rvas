# Phase 1: Data Exploration and Model Building

**Duration:** 3-4 hours
**Focus:** Jupyter Notebook, data science, machine learning

## Objective

Explore the FAA flights dataset, clean it, perform exploratory data analysis, and train a classification model that predicts whether a flight arriving at a given airport on a given day of the week will be delayed by more than 15 minutes.

## Dataset

The dataset (`data/flights.csv`) contains ~272,000 records of US flights from 2013, sourced from the FAA. It includes:

| Column | Description |
|--------|-------------|
| Year, Month, DayofMonth, DayOfWeek | Date information |
| Carrier | Airline carrier code (e.g., DL, WN, AA) |
| OriginAirportID, OriginAirportName, OriginCity, OriginState | Origin airport details |
| DestAirportID, DestAirportName, DestCity, DestState | Destination airport details |
| CRSDepTime, DepDelay, DepDel15 | Scheduled departure and delay info |
| CRSArrTime, ArrDelay, ArrDel15 | Scheduled arrival and delay info |
| Cancelled | Whether the flight was cancelled |

## Requirements

Before you open the notebook, use your full setup: keep your repository instructions open for the project's goal and conventions, bring in the data scientist agent you built for feature and model judgment, and run your end-to-end wiring or leakage-check skill as you go rather than checking for leakage only at the end.

1. **Load & Inspect** -- Load `data/flights.csv`, display shape, column types, first rows, summary statistics.
2. **Clean** -- Identify null/missing values and handle them (e.g., replace with 0 or drop).
3. **Explore** -- Create visualizations:
   - Delay rates by day of week
   - Delay rates by destination airport (top 20 busiest)
   - Delay distribution by carrier
   - Correlation heatmap for numerical features
4. **Feature Engineering** -- Select features for the model. At minimum use `DayOfWeek` and `DestAirportID`. Optionally add `Carrier`, `Month`, `CRSDepTime`, or engineered features.
5. **Train Model** -- Train a classification model (e.g., Logistic Regression, Random Forest, Gradient Boosting) to predict `ArrDel15`.
6. **Evaluate** -- Report accuracy, precision, recall, F1-score, and display a confusion matrix.
7. **Export** -- Save the trained model to `model.pkl` using pickle or joblib. Extract unique destination airports (ID + name) and save to `airports.csv`.

## Getting Started

1. Navigate to `challenges/challenge-8-flight-delay/`.
2. Install requirements: `pip install -r requirements.txt`.
3. Open `flight_delay_analysis.ipynb` and follow the guided cells.
4. Use Copilot Agent Mode to help you write each cell.

## Copilot Tips for This Phase

- Start each notebook cell with a descriptive comment -- Copilot uses this as context.
- Use `/explain` to understand ML concepts like precision vs. recall.
- Ask Copilot: *"What's the best model for binary classification on imbalanced data?"*
- Use Agent Mode (`Ctrl+Alt+I`) to generate entire analysis blocks from natural language.

## Success Criteria

- [ ] Dataset loaded and inspected
- [ ] Missing values identified and handled
- [ ] At least 4 visualizations created
- [ ] Model trained and evaluated (report metrics)
- [ ] `model.pkl` saved to disk
- [ ] `airports.csv` created with airport IDs and names

---

Previous: [Phases](phases.md) | Next: [Phase 2: Build the Prediction API](phase-2-prediction-api.md)
