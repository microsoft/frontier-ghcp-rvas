# Bring Your Own Challenge (BYOC) Kit

This kit helps you run an outcome-driven GitHub Copilot Adoption delivery session on your own app or repository. Use it when you want to deliver a real work result on your team's codebase instead of working through a pre-built example.

## What's in the Kit

- **[Outcome Canvas](./outcome-canvas.md)** -- a fill-in worksheet to define your target outcome, constraints, demo plan, and inputs for Customization Trio Design Briefs
- **[Challenge Templates](./templates/)** -- skeletons for an overview page, a committed contents page, and a dedicated page for each stage or phase
- **[Facilitator Runbook](./facilitator-runbook.md)** -- how to prepare tailored Design Briefs and run a session on a customer codebase
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
- You're running a session and want a repeatable, tested experience
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
- The stable context, specialist judgment, and repeatable procedure that should
  shape the Customization Trio

The facilitator turns those inputs into three tailored Design Briefs.
Participants then inspect the real repository and author Repository
Instructions, a Custom Agent, and a Custom Skill. The
[shared getting started guide](../tracks/getting-started.md)
covers authoring mechanics and resources.

### 2. Author Your Challenge Pages (Optional)

If you want a structured progression path, use the **[challenge templates](./templates/)** to create:

- An overview page describing the challenge and setup
- A committed `stages.md` or `phases.md` contents page listing the full progression
- A dedicated page for each stage or phase, with previous and next links
- A devcontainer or environment setup guide

Copy `track-template.md` first, then create its track folder. Copy
`contents-template.md` into that folder as `stages.md` or `phases.md`, and add one
page from `stage-template.md` for each progression step. Keep the overview's next
link, `contents_url` in `meta.yml`, the contents links, and every page footer in
sync.

If you already have a clear path, skip this step and work directly on your app.

### 3. Run Your Session

Follow the **[Facilitator Runbook](./facilitator-runbook.md)** to:

- Prepare the environment and codebase access
- Prepare Design Briefs without supplying completed customizations
- Reserve 20--30 minutes for participants to inspect the repository and draft
  the Customization Trio
- Set timeboxes and checkpoints
- Guide the work session
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

1. Open the **[Outcome Canvas](./outcome-canvas.md)** and fill it in for your app,
   including the Customization Trio design inputs
2. If you need a progression path, copy the overview, contents, and stage templates from **[templates/](./templates/)** and wire their navigation in order
3. Prepare the three tailored Design Briefs
4. Set up your environment (devcontainer, local dev, or Codespaces)
5. Run the session following the **[Facilitator Runbook](./facilitator-runbook.md)**
6. Demo the result and fill in the **[Outcome Scorecard](./outcome-scorecard.md)**

## Questions?

- See the **[Example Walkthrough](./example-walkthrough.md)** for a concrete end-to-end flow
- Review the **[Facilitator Runbook](./facilitator-runbook.md)** for session prep and facilitation guidance
- Check the worked-example challenges for outcome-driven patterns to adapt
