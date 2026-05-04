# Stage 3: Model Development and Rigorous Evaluation

[Back to Challenge 2: ML & AI Track](../challenge-2-ml-ai-track.md)

**Difficulty:** ⭐⭐⭐ | **Time:** 60-90 min

Reproducibility matters. Use sklearn Pipelines for all preprocessing and training.

## Tasks

1. Train at least 4 models: Logistic Regression, Random Forest, Gradient Boosting, and one additional (SVM, Neural Net, or XGBoost).
2. Wrap preprocessing and model training in sklearn Pipeline objects.
3. Stratified k-fold cross-validation (k=5 minimum). Report mean and standard deviation for each metric.
4. Hyperparameter tuning with GridSearchCV or RandomizedSearchCV. Document the search space and best parameters found.
5. Define a custom scoring function where false negatives (missing a churner) cost 5x more than false positives. Use this scorer during tuning.

## Verification

- 4+ models trained using Pipeline objects
- Cross-validation scores include mean and std dev
- Hyperparameter tuning documents search space and best params
- Custom cost-sensitive scorer is used in tuning (not just standard accuracy)

---

Previous: [Stage 2: Exploratory Analysis and Feature Engineering](stage-2-exploratory-analysis.md) | Next: [Stage 4: Class Imbalance and Interpretability](stage-4-class-imbalance.md)
