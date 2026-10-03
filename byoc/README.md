# Bring your own challenge kit

Use this kit to run a GitHub Copilot Adoption delivery session on your team's
codebase. Define what to deliver and how to demonstrate it.

## What's in the kit

- [Outcome Canvas](./outcome-canvas.md) defines the result, constraints, demo,
  and inputs for the Customization Trio Design Briefs.
- [Challenge templates](./templates/) provide an overview, contents page, and
  stage pages.
- [Facilitator Runbook](./facilitator-runbook.md) covers Design Briefs and
  session preparation.
- [Outcome Scorecard](./outcome-scorecard.md) records acceptance evidence and
  impact.
- [Example walkthrough](./example-walkthrough.md) shows the kit applied to an
  existing app.

## When to use this kit

**Use the BYOC kit when:**

- You want to deliver work on your own app or repository
- You have a specific business problem to solve (ship a feature, modernize legacy code, automate delivery, etc.)
- You need a result you can demonstrate
- You have access to a real codebase and can provision a working environment for it

**Use the worked-example challenges when:**

- You want to learn outcome-driven patterns before applying them to your own work
- You don't have access to a suitable codebase
- You need a repeatable session with supplied starter code
- You want to explore a specific technology or type of outcome

## Session flow

### 1. Define your outcome

Use the **[Outcome Canvas](./outcome-canvas.md)** to document:

- The type of outcome you're targeting (ship a feature, modernize legacy code, raise quality, automate delivery, stand up platform foundations, build AI capabilities, or a custom one)
- The current problem and baseline
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

### 2. Author your challenge pages

If you need a reusable sequence of stages, use the [challenge templates](./templates/) to create:

- An overview page describing the challenge and setup
- A committed `stages.md` contents page listing the full progression
- A dedicated page for each stage, with previous and next links
- A devcontainer or environment setup guide

Copy `track-template.md` first, then create its track folder. Copy
`contents-template.md` into that folder as `stages.md`, and add one
page from `stage-template.md` for each progression step. Keep the overview's next
link, `contents_url` in `meta.yml`, the contents links, and every page footer in
sync.

If you already have a clear path, skip this step and work directly on your app.

### 3. Run your session

Follow the **[Facilitator Runbook](./facilitator-runbook.md)** to:

- Prepare the environment and codebase access
- Prepare Design Briefs without supplying completed customizations
- Reserve 20-30 minutes for participants to inspect the repository and draft
  the Customization Trio
- Set timeboxes and checkpoints
- Guide the work session
- Guide the demo and outcome review

### 4. Score the outcome

Use the **[Outcome Scorecard](./outcome-scorecard.md)** to document:

- The outcome statement (what you delivered)
- Acceptance criteria met
- Evidence and demo artifacts
- Before/after business impact (time saved, risk reduced, quality improved)

Judge success by the result and its evidence. Copilot usage is a supporting metric.

## Worked example

See [example-walkthrough.md](./example-walkthrough.md) for a session plan built
around a team's task API.

## Integration with worked-example challenges

The worked-example challenges show how to apply this format. Each challenge:

- Drives a clear business outcome
- Defines acceptance criteria through its verification steps
- Provides starter code and a devcontainer
- Shows outcome-driven patterns you can adapt

## Quick start

1. Open the **[Outcome Canvas](./outcome-canvas.md)** and fill it in for your app,
   including the Customization Trio design inputs
2. If you need a progression path, copy the overview, contents, and stage templates from **[templates/](./templates/)** and wire their navigation in order
3. Prepare the three tailored Design Briefs
4. Set up your environment (devcontainer, local dev, or Codespaces)
5. Run the session following the **[Facilitator Runbook](./facilitator-runbook.md)**
6. Demo the result and fill in the **[Outcome Scorecard](./outcome-scorecard.md)**
