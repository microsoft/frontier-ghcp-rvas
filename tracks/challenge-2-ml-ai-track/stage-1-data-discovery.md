# Stage 1: Data Discovery and Cleaning

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

The dataset has 7+ distinct data quality problems. Your job is to find every one of them
without being told what to look for.

## Tasks

Before cleaning, open `.github/copilot-instructions.md` for the churn dataset's context. Use your data scientist agent to review cleaning and feature choices. Run your notebook documentation skill as you work.

1. Load the dataset and inspect shape, dtypes, and null counts.
2. Discover and document every data quality issue. Inspect the data for inconsistent casing, mixed date formats, type mismatches, blank strings vs. NaN, missing values, duplicate rows, and string-typed numeric columns.
3. Clean each issue and justify your approach (why not a different method?).
4. Write a **Data Quality Report** markdown cell listing every issue found, its impact on analysis, and the fix applied.

## Verification

- Cleaned dataset has 0 duplicates
- All columns have consistent, correct dtypes
- No nulls in critical columns (or documented justification for remaining nulls)
- Data quality report lists all discovered issues

---

Previous: [Stages](stages.md) | Next: [Stage 2: Exploratory Analysis and Feature Engineering](stage-2-exploratory-analysis.md)
