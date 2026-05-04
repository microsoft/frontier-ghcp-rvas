# Stage 4: Class Imbalance and Interpretability

[Back to Challenge 2: ML & AI Track](../challenge-2-ml-ai-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

The dataset has class imbalance. Address it rigorously and explain your model to the business.

## Tasks

1. Implement and compare at least 3 imbalance techniques: SMOTE, class weights, and random undersampling.
2. For each technique, report all metrics (accuracy, precision, recall, F1, AUC-ROC). Explain which metric matters most for the churn prediction business case and why.
3. SHAP analysis: generate a summary plot for global feature importance. Create dependence plots for the top 3 features. Create force plots for 3 individual predictions: 1 churner correctly predicted, 1 non-churner correctly predicted, and 1 misclassification.
4. Write a **Model Explainability Report** cell translating SHAP insights into actionable business recommendations. Be specific (e.g., "customers with contracts under 6 months and monthly charges above $70 should receive a retention offer within the first 3 months").

## Verification

- Comparison table with all metrics across all 3 imbalance techniques
- Explanation of which metric matters most and why
- SHAP summary, dependence, and force plots rendered
- Business recommendations are specific and actionable (not generic)

## What Copilot Helps With vs. What Requires Your Judgment

Copilot generates SMOTE code, SHAP plot boilerplate, and metric comparison tables efficiently. But deciding which metric matters most for the business, interpreting SHAP dependence plots to find actionable patterns, and writing recommendations that a product team could act on require domain understanding.

---

Previous: [Stage 3: Model Development and Rigorous Evaluation](stage-3-model-development.md) | Next: [Stage 5: Deployment Pipeline and Monitoring](stage-5-deployment.md)
