# Bring Your Own Challenge (BYOC) Kit

This kit helps you run an outcome-driven GitHub Copilot Adoption delivery session on your own app or repository. Use it when you want to deliver a real work result on your team's codebase instead of working through a pre-built example.

## What's in the Kit

- **[Outcome Canvas](./outcome-canvas.md)** -- a fill-in worksheet to define your target outcome, pain, definition of done, constraints, and demo plan
- **[Challenge Templates](./templates/)** -- skeletons for authoring a custom track structure (optional -- use if you need a progression path; otherwise work directly on your app)
- **[Facilitator Runbook](./facilitator-runbook.md)** -- how to run a session on a customer codebase (prep, environment, timeboxes, checkpoints, demo)
- **[Outcome Scorecard](./outcome-scorecard.md)** -- a reusable definition-of-done template that replaces usage metrics as the success measure
- **[Example Walkthrough](./example-walkthrough.md)** -- a worked example adapting an existing challenge app end-to-end through the kit

## When to Use This Kit

**Use the BYOC kit when:**

- You want to drive a real outcome on your own app or repository
- You have a specific business problem to solve (ship a feature, modernize legacy code, automate delivery, etc.)
- You want the session to produce demonstrable business value, not just learning
- You have access to a real codebase and can provision a working environment for it

**Use the worked-example challenges when:**

- You want to learn outcome-driven patterns before applying them to your own work
- You don't have access to a suitable codebase
- You're teaching a workshop and want a repeatable, tested experience
- You want to explore a specific technology or type of outcome

## End-to-End Flow

### 1. Define Your Outcome

Use the **[Outcome Canvas](./outcome-canvas.md)** to document:

- The type of outcome you're targeting (ship a feature, modernize legacy code, raise quality, automate delivery, stand up platform foundations, build AI capabilities, or a custom one)
- The current pain or baseline
- What "done" looks like (definition of done)
- Constraints (time, team size, existing architecture)
- The app or repository in scope
- How you'll demo the result
- How success is measured

### 2. Author Your Challenge (Optional)

If you want a structured progression path, use the **[challenge templates](./templates/)** to create:

- A track file describing the outcome, stages, and success criteria
- Stage files breaking the work into checkpoints
- A devcontainer or environment setup guide

If you already have a clear path, skip this step and work directly on your app.

### 3. Run Your Session

Follow the **[Facilitator Runbook](./facilitator-runbook.md)** to:

- Prepare the environment and codebase access
- Set timeboxes and checkpoints
- Facilitate the work session
- Guide the demo and outcome review

### 4. Score the Outcome

Use the **[Outcome Scorecard](./outcome-scorecard.md)** to document:

- The outcome statement (what you delivered)
- Acceptance criteria met
- Evidence and demo artifacts
- Before/after business impact (time saved, risk reduced, quality improved)

The scorecard replaces activity metrics (Copilot usage percentage) as the primary success measure.

## Worked Example

See **[example-walkthrough.md](./example-walkthrough.md)** for a full narrative walkthrough that takes an existing challenge app (the Web API challenge) and runs it through the BYOC kit as if it were a customer's own codebase.

## Integration with Worked-Example Challenges

The 22 worked-example challenges are reference implementations of this flow. Each challenge:

- Drives a clear business outcome
- Has a filled-in scorecard (implicitly defined by the verification steps)
- Provides starter code and a devcontainer
- Shows outcome-driven patterns you can adapt

When you bring your own challenge, you're authoring the 23rd (or 24th, or 25th) challenge for your own context.

## Quick Start

1. Open the **[Outcome Canvas](./outcome-canvas.md)** and fill it in for your app
2. If you need stage-by-stage guidance, copy a template from **[templates/](./templates/)** and adapt it
3. Set up your environment (devcontainer, local dev, or Codespaces)
4. Run the session following the **[Facilitator Runbook](./facilitator-runbook.md)**
5. Demo the result and fill in the **[Outcome Scorecard](./outcome-scorecard.md)**

## Questions?

- See the **[Example Walkthrough](./example-walkthrough.md)** for a concrete end-to-end flow
- Review the **[Facilitator Runbook](./facilitator-runbook.md)** for session prep and facilitation guidance
- Check the worked-example challenges for outcome-driven patterns to adapt
