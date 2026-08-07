# BYOC Example Walkthrough

This walkthrough shows how a facilitator can use the BYOC kit with a team's
real repository. It uses an internal task management API as the example, but it
does not provide finished customizations for participants to copy.

## Scenario

The team owns a Node.js task API with no authentication, limited tests, and
plain-text logs. They want to make a production deployment possible during a
six-hour GitHub Copilot Adoption delivery session.

The outcome is to add authentication, raise test coverage, and introduce
structured logging without changing the existing task schema.

## 1. Complete the Outcome Canvas

The facilitator and repository owner record:

- The current security, testing, and observability gaps
- Acceptance criteria that can be demonstrated at the end of the session
- The existing Node.js and Express architecture
- Compatibility constraints and approved Azure services
- The code paths, tests, configuration, and documentation participants should
  inspect
- The specialist judgment needed for security and API tradeoffs
- A repeated engineering procedure that would benefit from a Custom Skill

These last three inputs are preparation notes. They are not Repository
Instructions, a Custom Agent, or a Custom Skill.

## 2. Decide Whether the Session Needs Challenge Pages

This session can run directly from the Outcome Canvas because the work is
limited to one repository and one day.

If the team plans to reuse the session, the facilitator can create:

1. An overview page from `track-template.md`
2. A committed contents page from `contents-template.md`
3. Dedicated stage pages for authentication, tests, and logging

The overview links to contents. Contents lists the full progression. Every
stage page links to the previous and next page.

## 3. Frame the Customization Trio Design Briefs

The facilitator turns the canvas notes into three short Design Briefs. Each
brief states the intended outcome, audience, constraints, and quality bar. It
does not contain a completed artifact or ready-to-paste wording.

### Repository Instructions Brief

The brief points participants toward stable facts they should verify in the
repository:

- Runtime, framework, test, and logging conventions
- Existing API and compatibility boundaries
- Security and data-handling expectations
- Approved Azure dependencies
- Commands and evidence used to judge a safe change

Participants decide what belongs in Repository Instructions after inspecting
the actual files.

### Custom Agent Brief

The brief identifies where specialist judgment matters:

- Reviewing authentication and authorization tradeoffs
- Checking proposed changes against the existing API contract
- Calling out security, testability, and operability risks
- Recognizing the Use Cues that should bring the specialist into the work

Participants define the Custom Agent's responsibility and boundaries from the
repository evidence they find.

### Custom Skill Brief

The brief identifies one repeatable procedure, such as validating a protected
API change from implementation through tests and operational evidence. It asks
participants to define:

- The Use Cues for the procedure
- Required repository inputs
- The sequence of work and decision points
- Expected outputs and verification evidence
- Constraints that apply at each part of the procedure

Participants choose the exact procedure and author the Custom Skill. The brief
does not prescribe its content.

For mechanics and authoring resources, use the
[shared getting started guide](../tracks/getting-started.md).

## 4. Run the Session

### Opening and Initial Drafting

The facilitator states the outcome, reviews the acceptance criteria, and
confirms that everyone can run the API and its tests.

Participants then spend 20--30 minutes across the opening and the start of work
time on the Customization Trio:

1. Inspect the repository areas named in the briefs.
2. Compare the briefs with the conventions and constraints they find.
3. Author Repository Instructions, a Custom Agent, and a Custom Skill.
4. Start using them while delivering the outcome.

This is part of the working session, not a separate submission exercise.

### Work Time

The team moves through four timeboxes:

1. Inspect current behavior and add authentication.
2. Add integration coverage around protected endpoints.
3. Add structured logging and request correlation.
4. Run the full verification path and prepare the demo.

Participants use Repository Instructions throughout the work. They use the
Custom Agent when a decision needs specialist judgment and the Custom Skill
when its Use Cue appears.

At the midpoint, the facilitator gives a short reminder: refine the
Customization Trio using what the repository and implementation work have
revealed. There is no formal check, approval, or submission.

### Demo and Outcome Review

The team demonstrates:

- Requests rejected or accepted according to the intended access rules
- Passing tests and the agreed coverage evidence
- Structured logs with request correlation
- A deployable result using the approved environment

The Outcome Scorecard records the delivered outcome and business impact.
Repository Instructions, Custom Agents, and Custom Skills can be listed as
reusable patterns produced during the work, but completing all three is not an
acceptance criterion for the product outcome.

## 5. Apply the Pattern to Another Repository

For the next BYOC session:

1. Fill in the Outcome Canvas with repository-specific evidence.
2. Decide whether the overview, contents, and stage page model is needed.
3. Prepare three tailored Design Briefs.
4. Let participants inspect the real repository and author the Customization
   Trio.
5. Reserve a midpoint reminder for refinement.
6. Score the working outcome and record reusable patterns.

The briefs guide the work. They do not replace participant judgment or
repository inspection.
