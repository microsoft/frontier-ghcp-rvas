# Challenge 2 Track: ML & AI

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Data analysis, machine learning, and AI development with GitHub Copilot

## Prerequisites

- Python programming experience
- Understanding of pandas and numpy
- Basic statistics and ML concepts
- Jupyter Notebook familiarity
- Experience with scikit-learn (helpful but not required)

## Technology stack

- **Python 3.11+**
- **Jupyter Notebooks**
- pandas, numpy for data manipulation
- scikit-learn for machine learning
- matplotlib, seaborn for visualization
- Optional: TensorFlow/PyTorch for deep learning

## Getting started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and inspect the challenge

Go to `challenges/challenge-2-ml-ai/` and install requirements (`pip install -r requirements.txt`). Open `customer_churn_analysis.ipynb` in VS Code and read the existing cells and dataset before you write instructions, then work through the stages in order.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Python version and key libraries (pandas, scikit-learn, etc.)
- Coding standards (PEP 8, type hints, docstrings)
- Data science best practices (EDA, validation, pipelines)
- Notebook documentation standards
- The goal: predicting customer churn from the provided dataset, not a generic ML exercise
- Split train/test before scaling or encoding touches the full dataset

### Suggested custom agents

- A Data Scientist Agent that recommends features, encodings, and baseline models from the dataset or notebook during exploration.
- An ML Engineer Agent that reviews a working notebook for reproducibility, leakage, and packaging issues before you turn it into a service.
- A Visualization Expert Agent that picks a chart and annotations for a metric and its audience.

### Suggested custom skills

- A Notebook Documentation Skill that adds a summary above each analysis section with its purpose, assumptions, and result. Run it before sharing the notebook.
- A Leakage Check Skill that checks the train/test split happens before fitting, scaling, or encoding the full dataset. Run it before evaluation.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "data science agent", "notebook documentation skill", and "pandas instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Start each notebook cell with a comment describing the analysis step.
- For visualizations, describe the layout (subplot grid, axes, colors) in a comment.
- When Copilot suggests an algorithm you're unsure about, run `/explain` on it.
- For feature engineering, specify the binning strategy, encoding approach, or interaction terms in comments.

## Resources

- [Troubleshooting](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-2-ml-ai-track/stages.md)
