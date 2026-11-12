# Stage 1: Discovery and Sprint Planning

**Duration:** 60 minutes for the core; role-page estimates cover the extended backlog
**Focus:** Product ideation, backlog creation, tooling setup, sprint planning

The PO develops the product idea while the rest of the team sets up tooling. The stage ends with a planning session that fixes Sprint 1 scope.

Before setup, check that `.github/copilot-instructions.md` describes CityPulse for all roles. Agree on one shared custom skill, such as sprint board sync or Discovery Handoff.

## Jump to Your Role

Open your role for the detailed task list:

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

Everyone clones and reviews the repo. The frontend developer studies the component structure and page layouts. The backend developer looks at the data model and the API patterns the UI implies.

After export, make all changes through branches, pull requests, and code review. Do not return to Spark. The repository is the source of truth.

## Sync Point: Sprint Planning Meeting (at ~1:00)

At the 1-hour mark, everyone pauses setup for a 30-minute planning session led by the PO:

1. PO walks through the backlog and GitHub Project board (10 min)
2. Each role picks their Sprint 1 stories (10 min)
3. Resolve blockers and dependencies, such as the frontend's API spec and QA's seed data (5 min)
4. Agree on a mid-sprint standup time (5 min)

Afterward, everyone should know their Sprint 1 tasks and have no blockers.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Sprint 1 -- Core Features](stage-2-sprint-1-build.md)
