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

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-2-ml-ai/` and install requirements (`pip install -r requirements.txt`). Open `customer_churn_analysis.ipynb` in VS Code and read through the existing cells and dataset before writing any instructions, then work through the stages in order.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should cover:

- Python version and key libraries (pandas, scikit-learn, etc.)
- Coding standards (PEP 8, type hints, docstrings)
- Data science best practices (EDA, validation, pipelines)
- Notebook documentation standards
- The actual outcome: predicting customer churn from the provided dataset, not a generic ML exercise
- Non-negotiable: any train/test split must happen before scaling or encoding touches the full dataset

### Suggested Custom Agents

- **Data Scientist Agent** -- Applies judgment on feature engineering and model choice: which encodings fit the data, and what a reasonable baseline looks like. Give it a dataset description or notebook cell; it recommends the next analytical step. Use it while exploring data, not once a pipeline is locked in.
- **ML Engineer Agent** -- Focuses on pipeline and deployment concerns: reproducibility, avoiding data leakage, and model packaging. Give it a working notebook; it flags what needs to change before it becomes a script or service. Use it once a model performs well enough to formalize.
- **Visualization Expert Agent** -- Judges what a chart should show and for whom: chart type and what to annotate. Give it a metric you want to communicate; it proposes the visualization approach. Use it when a result needs explaining, not for routine plotting.

### Suggested Custom Skills

- **Notebook Documentation Skill** -- A repeatable pass that adds a markdown summary above each analysis section: what the cell does, key assumptions, and the result. Run it before sharing a notebook, not while still iterating.
- **Leakage Check Skill** -- A fixed checklist run against a pipeline before evaluation: confirm the split happens before any fitting, scaling, or encoding step touches the full dataset. Run it once before trusting a reported metric.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "data science agent", "notebook documentation skill", and "pandas instructions" before you draft your own.

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
