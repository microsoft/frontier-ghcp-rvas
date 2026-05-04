# Challenge 2 Track: ML & AI

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Data analysis, machine learning, and AI development with GitHub Copilot

## Who Is This For

- Data Scientists and ML Engineers
- Data Analysts
- AI/ML Researchers
- Analytics Engineers

## Prerequisites

- Python programming experience
- Understanding of pandas and numpy
- Basic statistics and ML concepts
- Jupyter Notebook familiarity
- Experience with scikit-learn (helpful but not required)

## Technology Stack

- **Python 3.11+**
- **Jupyter Notebooks**
- pandas, numpy for data manipulation
- scikit-learn for machine learning
- matplotlib, seaborn for visualization
- Optional: TensorFlow/PyTorch for deep learning

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents), then continue below.

### Custom Instructions for This Track

**What to include:**

- Python version and key libraries (pandas, scikit-learn, etc.)
- Coding standards (PEP 8, type hints, docstrings)
- Data science best practices (EDA, validation, pipelines)
- Notebook documentation standards

### Suggested Agents

**Agents to consider creating:**

- **Data Scientist Agent** -- Expert in EDA, feature engineering, and model development
- **ML Engineer Agent** -- Focused on model optimization, pipelines, and deployment
- **Visualization Expert Agent** -- Specialized in creating insightful charts and dashboards

### Open the Challenge

Navigate to `challenges/challenge-2-ml-ai/` and install requirements (`pip install -r requirements.txt`). Open `customer_churn_analysis.ipynb` in VS Code and work through the stages in order.

---

## Stages

| Stage | Name | Difficulty | Est. Time | Key Deliverable |
|-------|------|------------|-----------|----------------|
| 1 | [Data Discovery and Cleaning](challenge-2-ml-ai-track/stage-1-data-discovery.md) | ⭐⭐ | 60-75 min | Data quality report documenting all 7+ issues |
| 2 | [Exploratory Analysis and Feature Engineering](challenge-2-ml-ai-track/stage-2-exploratory-analysis.md) | ⭐⭐ | 60-90 min | 8+ visualizations with interpretation, hypothesis tests, feature selection |
| 3 | [Model Development and Rigorous Evaluation](challenge-2-ml-ai-track/stage-3-model-development.md) | ⭐⭐⭐ | 60-90 min | 4+ models with pipelines, cross-validation, cost-sensitive scoring |
| 4 | [Class Imbalance and Interpretability](challenge-2-ml-ai-track/stage-4-class-imbalance.md) | ⭐⭐⭐ | 60-90 min | Imbalance comparison table, SHAP analysis, business recommendations |
| 5 | [Deployment Pipeline and Monitoring](challenge-2-ml-ai-track/stage-5-deployment.md) | ⭐⭐⭐ | 60-90 min | Prediction API, drift detection, model card |

The dataset is intentionally messy. Copilot can generate pandas and scikit-learn code efficiently, but discovering subtle data quality issues, interpreting SHAP values for business decisions, and building drift detection require your analytical judgment.

> **Short on time?** Skip hypothesis testing in Stage 2, train 3 models instead of 4 in Stage 3, do only SHAP analysis in Stage 4, and skip the API + drift detection in Stage 5.

## Tips for Using Copilot on This Track

- Start each notebook cell with a comment describing the analysis step. Copilot generates better pandas and sklearn code when it knows the intent.
- For visualizations, describe the layout (subplot grid, axes, colors) in a comment. Copilot handles matplotlib well with a clear spec.
- When Copilot suggests an algorithm you're not sure about, use `/explain` on it before moving on.
- Feature engineering is where comments pay off most -- specify the binning strategy, encoding approach, or interaction terms you want.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
