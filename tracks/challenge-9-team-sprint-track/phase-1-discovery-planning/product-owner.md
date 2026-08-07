# Phase 1: Discovery and Planning -- Product Owner Tasks

**Time: Full 1.5 hours**

## Tasks

Before you start writing stories, put the product strategist agent from your setup to real use: run early feature ideas past it for trade-off framing before they reach the backlog, instead of treating the backlog as a first draft.

1. **Read the stakeholder brief** -- Open the [stakeholder brief](../../../challenges/challenge-9-team-sprint/docs/stakeholder-brief.md) and internalize the requirements. This is your specification from the "client."

2. **Prototype with GitHub Spark** -- Go to [github.com/spark](https://github.com/spark) (requires a GitHub Copilot license) and use GitHub Spark to create a quick interactive prototype of CityPulse. Describe screens in natural language:
   - A form where residents submit issue reports (title, description, category, location)
   - A page listing all reported issues with colored status badges
   - A page showing upcoming community events
   - A dashboard with basic stats

3. **Export Spark to a repository (the handover)** -- Once the prototype looks right, export the Spark app into a new GitHub repository. This is the official handover to the development team. Create the repo under the team's GitHub organization (or your personal account) and share the link with everyone.

   What this repo represents:
   - It is the **contract** between the PO and the developers. The screens, data model, and user flows captured in the Spark export define what the team agreed to build.
   - Developers will clone this repo, study the generated code, and use it as a reference -- or as a starting point they adapt into the real application architecture.
   - The frontend developer in particular should review the component structure and page layout, then decide what to keep, what to rewrite, and what to throw away.

   > **There is no way back.** Once the Spark prototype is exported to the repo, the team works from real code in a real repository. You do not go back to iterating in GitHub Spark. Any further changes go through the normal development workflow -- branches, PRs, code review. The Spark app served its purpose: rapid ideation. From this point forward, the repo is the source of truth.

4. **Write the product vision** -- Create `docs/product-vision.md` in the challenge folder. Include: problem statement, target users, key features for this sprint, and what success looks like.

5. **Define epics and user stories** -- Write at least 10 user stories across these epics:
   - **Issue Reporting** -- creating, viewing, and updating reports
   - **Community Events** -- browsing and creating events
   - **Dashboard** -- viewing neighborhood statistics
   - **User Accounts** -- registration and authentication (stretch goal for Sprint 2)

6. **Create GitHub Issues** -- Convert each story into a GitHub Issue. Use the template in `challenges/challenge-9-team-sprint/templates/user-story-issue.md`. For each:
   - Add a descriptive title and body with acceptance criteria
   - Label by epic (`epic:reporting`, `epic:events`, `epic:dashboard`, `epic:accounts`)
   - Label by priority (`priority:must`, `priority:should`, `priority:could`)
   - Add a size estimate label (`size:S`, `size:M`, `size:L`)
   - Assign to the team member whose role matches the work

7. **Set up GitHub Project board** -- Create a project board with columns: Backlog, Sprint 1, In Progress, In Review, Done. Move Sprint 1 stories into the Sprint 1 column.

8. **Sprint planning** -- At the 1-hour mark, walk the team through the backlog. Let each role pick their Sprint 1 stories. Resolve questions about scope or acceptance criteria.

## Verification

- [ ] GitHub Spark prototype created
- [ ] Spark app exported to a GitHub repository and link shared with team
- [ ] Product vision document written
- [ ] At least 10 GitHub Issues created with labels, priorities, and assignments
- [ ] GitHub Project board set up with Sprint 1 column populated

---

Previous: [Phases](../phases.md) | Next: [Phase 2: Sprint 1 -- Product Owner Tasks](../phase-2-sprint-1-build/product-owner.md)
