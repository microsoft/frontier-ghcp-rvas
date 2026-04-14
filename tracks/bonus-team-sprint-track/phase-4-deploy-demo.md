# Phase 4: Ship and Demo

[Back to Team Sprint Track](../bonus-team-sprint-track.md)

**Duration:** 1.5 hours
**Focus:** Production deployment, final testing, demo, retrospective

The final stretch. The team polishes the application, runs final tests on the production environment, and delivers a demo. The PO leads the demo and the team runs a brief retrospective afterward.

## Jump to Your Role

Find your role and follow the link for your detailed task list:

| Role | Focus This Phase | Key Deliverable |
|------|-----------------|-----------------|
| [Product Owner](phase-4-deploy-demo/product-owner.md) | Final acceptance, release notes, lead demo, run retro | Demo delivered, retrospective completed |
| [Backend Developer](phase-4-deploy-demo/backend-developer.md) | Critical bug fixes, performance check, deployment help | API stable and ready for demo |
| [Frontend Developer](phase-4-deploy-demo/frontend-developer.md) | Critical UI fixes, visual polish | UI polished for demo |
| [QA Engineer](phase-4-deploy-demo/qa-engineer.md) | Final regression, production smoke test, test report | Test results ready for demo |
| [DevOps Engineer](phase-4-deploy-demo/devops-engineer.md) | Verify environment, write docs, demo contribution | Codespace environment documented and running |
| [Business Analyst](phase-4-deploy-demo/business-analyst.md) | Final walkthrough, known issues, retro notes *(optional role)* | Known issues finalized |

## Demo Format (last 20-30 minutes)

The PO leads. Suggested structure:

1. **Problem statement** (2 min) -- What is CityPulse and why does it matter? Briefly reference the stakeholder brief.
2. **Live walkthrough** (8-10 min) -- Use the deployed application:
   - Submit a new issue report (fill in the form, show it appear in the list)
   - Browse community events
   - Show the dashboard (if built)
   - Show the public URL
3. **Architecture overview** (5 min) -- Backend developer describes the API design. Frontend developer walks through the component structure.
4. **Quality and infrastructure** (3 min) -- QA shows test results. DevOps shows the CI/CD pipeline and Codespace environment setup.
5. **Copilot retrospective** (3 min) -- Each person shares one moment where Copilot made a significant difference and one where they had to correct or override it.

## Retrospective (last 10 minutes)

After the demo, the team discusses:

1. **What went well?** -- What worked about the parallel sprint structure? Which Copilot features were most useful?
2. **What would we change?** -- Where did the team get stuck? Were there communication gaps? Was the scope right?
3. **What surprised us?** -- Any unexpected wins or challenges?

Capture notes in `docs/retrospective.md` or as a GitHub Issue labeled `retrospective`.

## Final Checklist

The team is done when:

- [ ] Application is running and accessible inside the Codespace (use port forwarding to share the URL with the team)
- [ ] At least the core flow works end-to-end: submit a report, view reports, browse events
- [ ] Final E2E test suite has been run (results available)
- [ ] Release notes are written
- [ ] Demo has been delivered
- [ ] Retrospective has been discussed

There is no next phase. The sprint is over. If time allows, continue to [Phase 5: Agentic Workflows](phase-5-agentic-workflows.md) to add AI-powered repository automation.

---

Previous: [Phase 3: Sprint 2 -- Integration and Polish](phase-3-sprint-2-integration.md) | Next: [Phase 5: Agentic Workflows](phase-5-agentic-workflows.md) (optional)
