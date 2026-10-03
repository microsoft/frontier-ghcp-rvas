# BYOC facilitator runbook

Use this runbook when participants work on their own app or repository.
Agree on what to deliver before preparing the session.

## Pre-session preparation

Start 1-2 weeks before the session.

### 1. Define the outcome

Work with the team to fill in the **[Outcome Canvas](./outcome-canvas.md)**:

- Target type of outcome
- Current problem and baseline metrics
- Definition of done with concrete acceptance criteria
- Constraints (time, team size, architecture, access)
- Stable repository context and constraints for Repository Instructions
- Specialist judgment that could be assigned to a Custom Agent
- One repeatable procedure worth encoding as a Custom Skill
- Demo plan
- Success measurement (before/after business impact)

Schedule a 30-minute outcome-definition discussion if needed. Keep it short
and concrete.

### 2. Prepare the Customization Trio Design Briefs

Turn the Customization Trio inputs from the canvas into three tailored Design
Briefs:

- Repository Instructions: intended outcome, audience, stable context,
  constraints, and quality bar
- Custom Agent: specialist responsibility, judgment required, Use Cues,
  boundaries, and quality bar
- Custom Skill: repeatable procedure, Use Cues, inputs, outputs, constraints,
  and quality bar

Keep each brief specific to the customer's repository, but do not author the
customization for participants. They must inspect the real repository, confirm
the brief against what they find, and write the three artifacts themselves.
Use the
[shared getting started guide](../tracks/getting-started.md)
for authoring mechanics and resources.

### 3. Choose the session pages

For a reusable challenge, author the page set before the session:

1. Start with the overview page.
2. Add and commit a `stages.md` contents page.
3. Add one dedicated page for each stage.
4. Check the route from overview to contents, then through every previous and
   next link.

Use `byoc/templates/` as the starting point. For a one-time session with a clear
plan, the Outcome Canvas is enough.

### 4. Environment and access

**Codebase Access:**

- [ ] Participants have read/write access to the repository
- [ ] Repository is cloned or accessible in Codespaces
- [ ] Any required secrets or credentials are provisioned (API keys, database connection strings, Azure access)

**Development Environment:**

- Option A: Create a **devcontainer** for the app. See `.devcontainer/` in this repo for examples. Include required dependencies, tools, and setup scripts.
- Option B: Provide a **local setup script** (install dependencies, seed data, start services).
- Option C: Use **GitHub Codespaces** with a custom devcontainer.

**Test Environment:**

- [ ] Participants can run the app locally or in a sandbox
- [ ] Test data is available
- [ ] CI/CD pipelines are accessible (if in scope for the outcome)

### 5. Pre-session communication

Send participants:

- [ ] Link to the repository
- [ ] **[Outcome Canvas](./outcome-canvas.md)** (filled in)
- [ ] The three tailored Design Briefs
- [ ] Environment setup instructions
- [ ] Any pre-reading (existing architecture docs, ADRs, relevant code paths)
- [ ] Schedule with timeboxes
- [ ] The result participants should deliver and demonstrate

## Session structure

### Opening and initial drafting

**Outcome Framing:**

- State the target outcome clearly
- Show the definition of done
- Walk through the demo plan
- Explain how success will be measured (business impact, not activity metrics)

**Repository Orientation:**

- Confirm access and show where the app, tests, configuration, and supporting
  documentation live
- Introduce the three Design Briefs without showing completed customizations

**Customization Trio Drafting:**

- Set aside 20-30 minutes across the opening and the start of work time
- Have participants inspect the real repository before they write
- Ask them to author Repository Instructions, a Custom Agent, and a Custom Skill
  from the briefs and repository evidence
- Keep the drafting time inside the session schedule rather than adding a
  separate exercise

### Work time

Allow 4-5 hours.

**Timeboxes:**

Break the work into checkpoints aligned to the outcome. Example for a "Migrate API to REST" outcome:

- 0:00 - 1:00: Understand the existing API (exploration, documentation)
- 1:00 - 2:30: Write characterization tests for current behavior
- 2:30 - 4:00: Implement the REST API (scaffolding, endpoints)
- 4:00 - 4:45: Integrate and test the new API
- 4:45 - 5:00: Prepare demo

Adjust timeboxes to fit your outcome and session length.

**Checkpoints:**

At each checkpoint, gather the team briefly (5 min):

- What did you deliver in this block?
- Are you on track for the outcome?
- Any blockers?

**Facilitator Tips:**

- Keep the conversation tied to the outcome: "How does this move you toward the definition of done?"
- Guide participants to use Copilot instead of solving problems for them
- If someone is stuck, ask: "What would you need to demo this part? Work backward from that."
- Share specific techniques that help, such as using `/explain` to understand
  a legacy module
- At the midpoint, remind participants to refine the Customization Trio using
  what they have learned. This is a reminder, not a review gate or submission.

### Demo and outcome review

Allow one hour.

**Demo (30 min):**

Each participant or team shows:

- The outcome they delivered (live demo, deployed artifact, test output, etc.)
- What changed (before/after comparison)
- How they used Copilot to accelerate the work

**Outcome Scorecard (20 min):**

Walk through the **[Outcome Scorecard](./outcome-scorecard.md)** as a group or have each team fill one in:

- Outcome statement
- Acceptance criteria met (yes/no with evidence)
- Before/after business impact
- Artifacts produced

**Wrap-Up (10 min):**

- What patterns emerged?
- What would you do differently next time?
- How will you apply this to your next sprint?

## Post-session follow-up

### Within one week

- [ ] Send filled-in **[Outcome Scorecard](./outcome-scorecard.md)** to participants
- [ ] Collect feedback: Was the outcome clear? Did you deliver it? What was the business impact?
- [ ] Share the patterns discovered with the broader team
- [ ] Schedule a follow-up session if the outcome was not fully delivered

### Measuring success

Each team should demonstrate its result and explain the impact. Record useful
Repository Instructions, Custom Agents, Custom Skills, and working practices
for future work. Copilot usage and chat counts are supporting evidence.

## Common problems

### Unclear outcome

Participants aren't sure what "done" means, so the work drifts.

Refine the canvas. Define 3-5 acceptance criteria that can be checked yes or no.

### Slow environment setup

Participants spend the first hour installing dependencies or debugging the devcontainer.

Test the environment before the session. Provide a working devcontainer or
setup script, with a prepared Codespace or sandbox as a backup.

### Too much work for the session

At the first checkpoint, the team can see it will not finish.

Reduce the scope and update the acceptance criteria. Keep a result the team
can demonstrate and explain what remains.

### Investigation without a result

Participants keep investigating without producing working artifacts or planning a demo.

Ask what the team can demonstrate in two hours. Choose a small part to finish first.

## Example timeboxes

### Modernize legacy system (6 hours)

- 0:00 - 1:00: Understand the legacy code
- 1:00 - 2:30: Write characterization tests
- 2:30 - 4:00: Implement the modern replacement
- 4:00 - 5:00: Integrate and verify behavior parity
- 5:00 - 6:00: Demo and scorecard

### Ship product feature (4 hours)

- 0:00 - 0:30: Review the spec and existing code
- 0:30 - 2:00: Implement the feature (API + UI)
- 2:00 - 3:00: Write tests and fix issues
- 3:00 - 3:30: Deploy to staging or demo environment
- 3:30 - 4:00: Demo and scorecard

### Automate delivery (4 hours)

- 0:00 - 0:30: Document the current manual process
- 0:30 - 2:00: Build the automation (script, CI workflow, runbook)
- 2:00 - 3:00: Test the automation end-to-end
- 3:00 - 3:30: Run it on a real use case
- 3:30 - 4:00: Demo and scorecard

## Integration with worked-example challenges

If the customer's work resembles an existing challenge, you can:

- Use the challenge track file as a template for your session structure
- Adapt the stage progression to fit the customer's app
- Reference the verification steps as acceptance criteria
- Show the challenge as a worked example before the session
