# Stage 5: Deployment Pipeline and Monitoring

[Back to Challenge 2: ML & AI Track](../challenge-2-ml-ai-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

A model that exists only in a notebook is not deployed. Make it usable.

## Tasks

1. Serialize the best model and its full preprocessing pipeline using joblib. Create a prediction function that takes raw (uncleaned) customer data and returns a churn probability. The function must handle the same data quality issues you found in Stage 1.
2. Create a prediction API endpoint in `serve_model.py` using FastAPI. The endpoint accepts customer data as JSON and returns churn probability.
3. Data drift detection: implement KS-test or PSI (Population Stability Index) on key features. Compare incoming data distributions against training data distributions and flag when drift exceeds a threshold.
4. Write a **Model Card** using the template in `model_card_template.md`. Cover: intended use, training data description, performance metrics across demographic groups (if applicable), limitations, and ethical considerations.
5. Create a monitoring cell that simulates 100 new customers with progressively drifted features and shows how predictions and drift scores change.

## Verification

- Prediction function handles raw data (including quality issues) end-to-end
- API endpoint returns probability as JSON
- Drift detection correctly flags synthetic drifted data
- Model card covers all required sections with substantive content
- Monitoring simulation shows drift impact on predictions

---

Previous: [Stage 4: Class Imbalance and Interpretability](stage-4-class-imbalance.md)
