# Stage 4: Ship and Demo

**Duration:** 30 minutes for a tested core demo

**Focus:** Production deployment, final testing, demo, retrospective

Use the core scope from the [contents page](stages.md). Azure deployment is optional if no environment was prepared before the session, and the full deployment tasks below are stretch work. A local demo still needs integration and test evidence.

Run final tests and finish UI fixes before the demo. Pick one person to lead it, usually the frontend developer.

## Jump to Your Role

Pick your role for the detailed task list:

| Role | Focus This Stage | Key Deliverable |
|------|-----------------|-----------------|
| [Backend Developer](stage-4-deploy-demo/backend-developer.md) | Critical bug fixes, performance check, deployment help | API stable and ready for demo |
| [Frontend Developer](stage-4-deploy-demo/frontend-developer.md) | Critical UI fixes, visual polish, lead or co-lead demo | UI polished for demo |
| [QA Engineer](stage-4-deploy-demo/qa-engineer.md) | Final regression, production smoke test, test report | Test results ready for demo |
| [DevOps Engineer](stage-4-deploy-demo/devops-engineer.md) | Verify environment, write docs, confirm CI smoke test | Full stack running cleanly, environment documented |

## Demo Format (last 20-30 minutes)

Present as a team. Suggested structure:

1. **What is TrailMate** (2 min) -- Describe the application and the problem it solves. Reference the functional spec.
2. **Live walkthrough** (8-10 min) -- Use the deployed application:
   - Browse the trail directory, filter by difficulty
   - View a trail's detail page with condition reports
   - Submit a new condition report
   - Show the dashboard (if built)
   - Show the public URL
3. **Architecture overview** (5 min) -- The backend developer describes the API design, and the frontend developer walks through the component structure.
4. **Quality and infrastructure** (3 min) -- QA shows test results. DevOps shows the CI/CD pipeline and the Codespace environment setup.
5. **Copilot retrospective** (3 min) -- Each person shares one moment where Copilot helped a lot and one where they had to correct or override it.

## Retrospective (last 10 minutes)

After the demo, discuss:

1. **What went well?** -- How did the parallel sprint structure work? Which Copilot features helped most?
2. **What would we change?** -- Where did the team get stuck? Where did communication break down? Was working without a PO harder or easier than expected?
3. **What surprised us?** -- Any unexpected wins or problems?

Capture notes in `docs/retrospective.md` or as a GitHub Issue labeled `retrospective`.

## Final Checklist

You're done when:

- [ ] Application is running and accessible inside the Codespace (use port forwarding to share the URL with the team)
- [ ] At least the core flow works end-to-end: browse trails, view trail details, submit a condition report
- [ ] Final E2E test suite has been run (results available)
- [ ] Release notes are written (a short `docs/release-notes.md`)
- [ ] Demo has been delivered
- [ ] Retrospective has been discussed

If time allows, continue to the optional [Stage 5: Agentic Workflows](stage-5-agentic-workflows.md).

---

Previous: [Stage 3: Sprint 2 -- Integration and Polish](stage-3-sprint-2-integration.md) | Next: [Stage 5: Agentic Workflows](stage-5-agentic-workflows.md)
