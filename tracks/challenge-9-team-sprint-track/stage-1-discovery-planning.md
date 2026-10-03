# Stage 1: Discovery and Sprint Planning

**Duration:** 60 minutes for the core; role-page estimates cover the extended backlog
**Focus:** Product ideation, backlog creation, tooling setup, sprint planning

The PO develops the product idea while the rest of the team sets up tooling. End the stage with a planning session to agree on Sprint 1 scope.

Before setup, check that `.github/copilot-instructions.md` describes CityPulse for all roles. Agree on one shared custom skill, such as sprint board sync or Discovery Handoff.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | Time | Summary |
|------|------|---------|
| [Product Owner](stage-1-discovery-planning/product-owner.md) | Full 1.5 hours | Prototype with GitHub Spark, write stories, create GitHub Issues, lead sprint planning |
| [Backend Developer](stage-1-discovery-planning/backend-developer.md) | ~1 hr setup + 30 min planning | Scaffold backend, draft API spec, write custom instructions |
| [Frontend Developer](stage-1-discovery-planning/frontend-developer.md) | ~1 hr setup + 30 min planning | Scaffold frontend, review Spark prototype, coordinate with backend |
| [QA Engineer](stage-1-discovery-planning/qa-engineer.md) | ~1 hr setup + 30 min planning | Set up Playwright, write test plan, define test data needs |
| [DevOps Engineer](stage-1-discovery-planning/devops-engineer.md) | ~1 hr setup + 30 min planning | Devcontainer config, CI pipeline, branching strategy |
| [Business Analyst](stage-1-discovery-planning/business-analyst.md) | ~1 hr + 30 min planning | Refine acceptance criteria, data model, dashboard metrics *(optional role)* |

## The Spark Handover

Before sprint planning, the PO exports the GitHub Spark prototype to a GitHub repository and shares the link. The export defines the agreed screens, user flows, and data model.

Every team member should clone the repo and review it. The frontend developer should pay close attention to the component structure and page layouts. The backend developer should look at the data model and API patterns implied by the UI.

After export, make all changes in the repository through branches, pull requests, and code review. Do not return to Spark; the repository is now the source of truth.

## Sync Point: Sprint Planning Meeting (at ~1:00)

At the 1-hour mark, everyone pauses setup and joins a 30-minute planning session led by the PO:

1. PO walks through the backlog and GitHub Project board (10 min)
2. Each role picks their Sprint 1 stories (10 min)
3. Resolve blockers and dependencies, such as the frontend's API spec and QA's seed data (5 min)
4. Agree on a mid-sprint standup time (5 min)

After planning, everyone should have clear tasks and an unblocked path into Sprint 1.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Sprint 1 -- Core Features](stage-2-sprint-1-build.md)
