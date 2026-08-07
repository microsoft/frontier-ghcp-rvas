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

## Tips for Using Copilot on This Track

- Start each notebook cell with a comment describing the analysis step. Copilot generates better pandas and sklearn code when it knows the intent.
- For visualizations, describe the layout (subplot grid, axes, colors) in a comment. Copilot handles matplotlib well with a clear spec.
- When Copilot suggests an algorithm you're not sure about, use `/explain` on it before moving on.
- Feature engineering is where comments pay off most -- specify the binning strategy, encoding approach, or interaction terms you want.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)

---

Next: [Stages](challenge-2-ml-ai-track/stages.md)
