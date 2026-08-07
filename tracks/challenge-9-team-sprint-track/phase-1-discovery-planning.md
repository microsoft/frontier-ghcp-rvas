# Phase 1: Discovery and Sprint Planning

**Duration:** 1.5 hours
**Focus:** Product ideation, backlog creation, tooling setup, sprint planning

This phase sets the foundation. The PO drives ideation while everyone else sets up their development environment and tooling. The phase ends with a sprint planning session where the team commits to Sprint 1 scope.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | Time | Summary |
|------|------|---------|
| [Product Owner](phase-1-discovery-planning/product-owner.md) | Full 1.5 hours | Prototype with GitHub Spark, write stories, create GitHub Issues, lead sprint planning |
| [Backend Developer](phase-1-discovery-planning/backend-developer.md) | ~1 hr setup + 30 min planning | Scaffold backend, draft API spec, write custom instructions |
| [Frontend Developer](phase-1-discovery-planning/frontend-developer.md) | ~1 hr setup + 30 min planning | Scaffold frontend, review Spark prototype, coordinate with backend |
| [QA Engineer](phase-1-discovery-planning/qa-engineer.md) | ~1 hr setup + 30 min planning | Set up Playwright, write test plan, define test data needs |
| [DevOps Engineer](phase-1-discovery-planning/devops-engineer.md) | ~1 hr setup + 30 min planning | Devcontainer config, CI pipeline, branching strategy |
| [Business Analyst](phase-1-discovery-planning/business-analyst.md) | ~1 hr + 30 min planning | Refine acceptance criteria, data model, dashboard metrics *(optional role)* |

## The Spark Handover

Before sprint planning, the PO exports the GitHub Spark prototype into a GitHub repository and shares the link with the team. This exported repo is the contract between the PO and the developers -- it captures the screens, user flows, and data model that the team agreed to build.

Every team member should clone the repo and review it. The frontend developer should pay close attention to the component structure and page layouts. The backend developer should look at the data model and API patterns implied by the UI.

Once the Spark prototype lands in a repo, the team does not go back to Spark. All further changes happen through the normal development workflow: branches, pull requests, code review. The Spark app was a rapid ideation tool. From this point on, the repository is the single source of truth.

## Sync Point: Sprint Planning Meeting (at ~1:00)

At the 1-hour mark, everyone pauses setup and joins a 30-minute planning session led by the PO:

1. PO walks through the backlog and GitHub Project board (10 min)
2. Each role picks their Sprint 1 stories (10 min)
3. Team resolves blockers and dependencies -- for example, frontend needs the API spec, QA needs seed data (5 min)
4. Agree on a mid-sprint standup time (5 min)

After planning, everyone should have clear tasks and an unblocked path into Sprint 1.

---

Previous: [Phases](phases.md) | Next: [Phase 2: Sprint 1 -- Core Features](phase-2-sprint-1-build.md)
