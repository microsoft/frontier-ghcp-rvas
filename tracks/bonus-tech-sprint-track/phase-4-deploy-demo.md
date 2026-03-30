# Phase 4: Ship and Demo

[Back to Technical Team Sprint Track](../bonus-tech-sprint-track.md)

**Duration:** 1.5 hours
**Focus:** Production deployment, final testing, demo, retrospective

The final stretch. The team polishes the application, runs final tests on the production environment, and delivers a demo. Without a PO, the team picks one person to lead the demo -- usually the frontend developer, since they can walk through the UI naturally.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | Focus This Phase | Key Deliverable |
|------|-----------------|-----------------|
| [Backend Developer](phase-4-deploy-demo/backend-developer.md) | Critical bug fixes, performance check, deployment help | API stable and ready for demo |
| [Frontend Developer](phase-4-deploy-demo/frontend-developer.md) | Critical UI fixes, visual polish, lead or co-lead demo | UI polished for demo |
| [QA Engineer](phase-4-deploy-demo/qa-engineer.md) | Final regression, production smoke test, test report | Test results ready for demo |
| [DevOps Engineer](phase-4-deploy-demo/devops-engineer.md) | Verify stack, write docs, confirm CI smoke test | Full stack running cleanly, deployment documented |

## Demo Format (last 20-30 minutes)

The team presents together. Suggested structure:

1. **What is TrailMate** (2 min) -- Briefly describe the application and the problem it solves. Reference the functional spec.
2. **Live walkthrough** (8-10 min) -- Use the deployed application:
   - Browse the trail directory, filter by difficulty
   - View a trail's detail page with condition reports
   - Submit a new condition report
   - Show the dashboard (if built)
   - Show the public URL
3. **Architecture overview** (5 min) -- Backend developer describes the API design. Frontend developer walks through the component structure.
4. **Quality and infrastructure** (3 min) -- QA shows test results. DevOps shows the CI/CD pipeline and a live `docker compose up`.
5. **Copilot retrospective** (3 min) -- Each person shares one moment where Copilot made a significant difference and one where they had to correct or override it.

## Retrospective (last 10 minutes)

After the demo, the team discusses:

1. **What went well?** -- What worked about the parallel sprint structure? Which Copilot features were most useful?
2. **What would we change?** -- Where did the team get stuck? Were there communication gaps? Was self-management without a PO harder or easier than expected?
3. **What surprised us?** -- Any unexpected wins or challenges?

Capture notes in `docs/retrospective.md` or as a GitHub Issue labeled `retrospective`.

## Final Checklist

The team is done when:

- [ ] Application is running and accessible -- either at a public URL (Azure deployment) or locally via `docker compose up`
- [ ] At least the core flow works end-to-end: browse trails, view trail details, submit a condition report
- [ ] Final E2E test suite has been run (results available)
- [ ] Release notes are written (a short `docs/release-notes.md`)
- [ ] Demo has been delivered
- [ ] Retrospective has been discussed

There is no next phase. The sprint is over.

---

Previous: [Phase 3: Sprint 2 -- Integration and Polish](phase-3-sprint-2-integration.md)
