# Spec-to-Ship Accelerator: Stages

## Stages

| Stage | Name | Duration | What You Do |
|-------|------|----------|-------------|
| 1 | [Spec to Backlog](stage-1-backlog.md) | 1.5-2 hours | Build a prompt that converts the spec into structured work items |
| 2 | [Technical Analysis](stage-2-analysis.md) | 1-1.5 hours | Build a prompt that generates a technical analysis from spec + existing code |
| 3 | [Code Generation](stage-3-code.md) | 2-2.5 hours | Use Copilot to implement the billing module from the generated stories |
| 4 | [Test Specs and Pipeline](stage-4-tests-pipeline.md) | 1.5-2 hours | Generate test specifications and a CI pipeline |

Each stage produces an artifact that feeds into the next. Stage 1 produces work items; Stage 2 analyzes impact; Stage 3 implements; Stage 4 validates.

> **Short on time?** Focus on Stages 1 and 2. The spec-to-backlog prompt and the technical analysis prompt are the most reusable artifacts. You can demonstrate the code generation and testing in a follow-up session.

---

Previous: [Track Overview](../challenge-17-spec-to-ship-track.md) | Next: [Stage 1: Spec to Backlog](stage-1-backlog.md)
