# BYOC Facilitator Runbook

This runbook describes how to run an outcome-driven hackathon on a customer's own app or repository. Use this when participants are working on their own codebase instead of a pre-built challenge.

## Pre-Session Prep (1-2 weeks before)

### 1. Define the Outcome

Work with the team to fill in the **[Outcome Canvas](./outcome-canvas.md)**:

- Target outcome category
- Current pain and baseline metrics
- Definition of done with concrete acceptance criteria
- Constraints (time, team size, architecture, access)
- Demo plan
- Success measurement (before/after business impact)

Schedule a 30-minute outcome-definition workshop if needed. Keep it short and concrete.

### 2. Environment and Access

**Codebase Access:**

- [ ] Participants have read/write access to the repository
- [ ] Repository is cloned or accessible in Codespaces
- [ ] Any required secrets or credentials are provisioned (API keys, database connection strings, Azure access)

**Development Environment:**

- Option A: Create a **devcontainer** for the app. See `devcontainers/` in this repo for examples. Include all dependencies, tooling, and pre-create scripts.
- Option B: Provide a **local setup script** (install dependencies, seed data, start services).
- Option C: Use **GitHub Codespaces** with a custom devcontainer.

**Test Environment:**

- [ ] Participants can run the app locally or in a sandbox
- [ ] Test data is available
- [ ] CI/CD pipelines are accessible (if in scope for the outcome)

### 3. Pre-Session Communication

Send participants:

- [ ] Link to the repository
- [ ] **[Outcome Canvas](./outcome-canvas.md)** (filled in)
- [ ] Environment setup instructions
- [ ] Any pre-reading (existing architecture docs, ADRs, relevant code paths)
- [ ] Schedule with timeboxes
- [ ] Reminder: the goal is to deliver a demonstrable outcome, not just explore

## Day-Of Structure

### Opening (30 min)

**Outcome Framing (15 min):**

- State the target outcome clearly
- Show the definition of done
- Walk through the demo plan
- Explain how success will be measured (business impact, not activity metrics)

**Copilot Demo (10 min):**

- Quick demo of inline suggestions, chat commands, workspace context
- Show how Copilot can accelerate the work toward the outcome

**Environment Check (5 min):**

- Verify everyone can run the app
- Confirm access to the repository and any required services

### Work Time (4-5 hours)

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
- Don't solve technical problems directly -- guide participants to use Copilot
- If someone is stuck, ask: "What would you need to demo this part? Work backward from that."
- Share patterns as you see them: "Team A just used `/explain` to understand a legacy module -- that might help you too."

### Demo and Outcome Review (1 hour)

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

## Post-Session Follow-Up

### Within 1 Week

- [ ] Send filled-in **[Outcome Scorecard](./outcome-scorecard.md)** to participants
- [ ] Collect feedback: Was the outcome clear? Did you deliver it? What was the business impact?
- [ ] Share the patterns discovered with the broader team
- [ ] Schedule a follow-up session if the outcome was not fully delivered

### Measuring Success

A successful BYOC session produces:

- **A demonstrable outcome** -- working code, shipped feature, modernized system, automated process
- **Articulated business impact** -- time saved, risk reduced, quality improved, toil eliminated
- **Reusable patterns** -- prompts, agents, workflow changes that the team can apply to future work

Activity metrics (Copilot usage percentage, chat interactions) are supporting evidence, not the goal.

## Common Challenges and Mitigations

### Challenge: Outcome is Too Vague

**Symptoms:** Participants aren't sure what "done" looks like. Work drifts.

**Mitigation:** Stop and refine the outcome. Fill in the canvas more concretely. Define 3-5 acceptance criteria that can be checked yes/no.

### Challenge: Environment Setup Takes Too Long

**Symptoms:** First hour is spent installing dependencies, debugging devcontainer issues.

**Mitigation:** Pre-test the environment. Provide a working devcontainer or setup script. Have a backup plan (cloud-hosted sandbox, pre-configured Codespace).

### Challenge: Outcome is Too Ambitious

**Symptoms:** Clear from the first checkpoint that the team won't finish.

**Mitigation:** Adjust the definition of done mid-session. Deliver a smaller slice of the outcome and call it a success if the impact is still demonstrable.

### Challenge: Participants Treat It as Exploration, Not Delivery

**Symptoms:** Lots of investigation, no working artifacts. No demo plan.

**Mitigation:** Reinforce the outcome framing at every checkpoint. Ask: "What will you demo in 2 hours?" Push for incremental delivery.

## Example Timeboxes for Common Outcomes

### Modernize Legacy System (6 hours)

- 0:00 - 1:00: Understand the legacy code
- 1:00 - 2:30: Write characterization tests
- 2:30 - 4:00: Implement the modern replacement
- 4:00 - 5:00: Integrate and verify behavior parity
- 5:00 - 6:00: Demo and scorecard

### Ship Product Feature (4 hours)

- 0:00 - 0:30: Review the spec and existing code
- 0:30 - 2:00: Implement the feature (API + UI)
- 2:00 - 3:00: Write tests and fix issues
- 3:00 - 3:30: Deploy to staging or demo environment
- 3:30 - 4:00: Demo and scorecard

### Automate Delivery (4 hours)

- 0:00 - 0:30: Document the current manual process
- 0:30 - 2:00: Build the automation (script, CI workflow, runbook)
- 2:00 - 3:00: Test the automation end-to-end
- 3:00 - 3:30: Run it on a real use case
- 3:30 - 4:00: Demo and scorecard

## Integration with Worked-Example Challenges

The 22 worked-example challenges in this repository are reference implementations of this runbook. If a customer's outcome is similar to an existing challenge, you can:

- Use the challenge track file as a template for your session structure
- Adapt the stage progression to fit the customer's app
- Reference the verification steps as acceptance criteria
- Show the challenge as a worked example before the session

The difference: in a BYOC session, participants work on their own codebase and deliver a real business result instead of completing a tutorial.
