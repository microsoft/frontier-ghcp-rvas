# Challenge 2 Track: ML & AI

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐ to ⭐⭐⭐ (progressive stages)

**Focus:** Data analysis, machine learning, and AI development with GitHub Copilot

## Who is this for

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

Navigate to `challenges/challenge-2-ml-ai/` and install requirements (`pip install -r requirements.txt`). Open `customer_churn_analysis.ipynb` in VS Code and read through the existing cells and dataset before writing any instructions, then work through the stages in order.

### Repository instructions for this track

Your `.github/copilot-instructions.md` should cover:

- Python version and key libraries (pandas, scikit-learn, etc.)
- Coding standards (PEP 8, type hints, docstrings)
- Data science best practices (EDA, validation, pipelines)
- Notebook documentation standards
- The actual outcome: predicting customer churn from the provided dataset, not a generic ML exercise
- Non-negotiable: any train/test split must happen before scaling or encoding touches the full dataset

### Suggested custom agents

- Use a Data Scientist Agent during exploration to recommend features, encodings, and baseline models from the dataset or notebook.
- Use an ML Engineer Agent to review a working notebook for reproducibility, leakage, and packaging issues before turning it into a service.
- Use a Visualization Expert Agent to choose a chart and annotations for a metric and its audience.

### Suggested custom skills

- A Notebook Documentation Skill adds a summary above each analysis section with its purpose, assumptions, and result. Run it before sharing the notebook.
- A Leakage Check Skill checks that the train/test split occurs before fitting, scaling, or encoding the full dataset. Run it before evaluation.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "data science agent", "notebook documentation skill", and "pandas instructions" before you draft your own.

---

## Tips for using Copilot on this track

- Start each notebook cell with a comment describing the analysis step. Copilot generates better pandas and sklearn code when it knows the intent.
- For visualizations, describe the layout (subplot grid, axes, colors) in a comment. Copilot handles matplotlib well with a clear spec.
- When Copilot suggests an algorithm you're not sure about, use `/explain` on it before moving on.
- For feature engineering, specify the binning strategy, encoding approach, or interaction terms in comments.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)

---

Next: [Stages](challenge-2-ml-ai-track/stages.md)
