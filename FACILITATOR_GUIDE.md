# Facilitator guide

## Overview

Help teams define what to deliver, use Copilot during the work, and demonstrate
the result. At the end, ask what changed and which practices they can use again.

Participants choose a challenge from the
[track catalog](./tracks/README.md).

## Pre-session setup

Start one week before the session.

### 1. Verify prerequisites

- [ ] All participants have GitHub accounts
- [ ] GitHub Copilot licenses are provisioned
- [ ] Codespaces are enabled for the organization
- [ ] Test the devcontainer setup

### 2. Prepare the environment

Create a Codespace from the main branch. Verify that the selected devcontainer
builds, its extensions install, and its post-create script runs successfully.

### 3. Review the tracks

Review the tracks your participants will use.

**Core tracks:**

- [ ] [Challenge 1: Web API Track](./tracks/challenge-1-web-api-track.md)
- [ ] [Challenge 2: ML & AI Track](./tracks/challenge-2-ml-ai-track.md)
- [ ] [Challenge 3: DevOps Track](./tracks/challenge-3-devops-track.md)
- [ ] [Challenge 4: Frontend Track](./tracks/challenge-4-frontend-track.md)
- [ ] [Challenge 5: QA & Testing Track](./tracks/challenge-5-qa-track.md)

**SDK, full-stack, and team tracks:**

- [ ] [Copilot SDK Track](./tracks/challenge-7-copilot-sdk-track.md)
- [ ] [Flight Delay Predictor Track](./tracks/challenge-8-flight-delay-track.md)
- [ ] [Cross-Functional Team Sprint Track](./tracks/challenge-9-team-sprint-track.md)
- [ ] [Technical Team Sprint Track](./tracks/challenge-10-tech-sprint-track.md)

### 4. Send session details

Send participants:

- [ ] Repository link
- [ ] **[Tracks Overview](./tracks/README.md)** - Ask them to review before the event
- [ ] Session schedule
- [ ] Setup instructions
- [ ] Slack/Teams channel for questions

## Day of the session

### Opening session

Allow 30 minutes.

**Welcome & Introduction (10 min)**

- Introduce GitHub Copilot
- Ask participants to deliver a result they can demonstrate
- Review schedule
- Show the [Tracks Overview](./tracks/README.md)

**Demo: Copilot Basics (15 min)**

- Show inline suggestions
- Demonstrate chat commands (`/explain`, `/fix`, `/tests`)
- Quick example of workspace context
- Show MCP servers (briefly)

**Track Selection (5 min)**

- Suggest a track based on the result participants need to deliver or their role
- Direct them to the [Tracks Guide](./tracks/README.md)

### Challenge time

Allow 4-5 hours.

Participants work through their chosen challenge's stages, individually or in
pairs. Facilitators rotate between teams, ask what they are trying to deliver,
and help them use Copilot rather than solving the problem for them. Share
techniques that helped another team complete its work.

### Mid-day check-in

Allow 15 minutes.

Around lunch, gather everyone:

- Ask which outcome and stage each team is working on
- Have 2-3 teams show their progress
- Address common issues

### Demo session

Allow 1-2 hours.

**Format Options:**

**Option A: Outcome-Based Demos (recommended)**

- Group participants by the outcome they delivered
- Each team presents its result and any supported business impact
- Compare approaches across similar outcomes
- Share Copilot patterns that helped deliver the result

**Option B: Demo Stations**

- Set up tables for each outcome theme
- Participants show their work and explain the impact
- Informal walk-around format

**Option C: Presentations**

- Each person/team presents (5 min each)
- Show the outcome they delivered and demo it
- Explain the impact, using evidence for claims about time saved, risk reduced,
  or quality improved
- Highlight Copilot patterns that accelerated the work

**Option D: Lightning Talks**

- 2-minute rapid-fire presentations
- Focus on the outcome and one key Copilot pattern

### Wrap-up session (30 min)

**Outcome Review (15 min)**

- What outcomes did teams deliver?
- What business impact did each produce?
- Where did Copilot help or slow the work?
- Which practices can teams reuse?

**Q&A (5 min)**

**Next Steps (10 min)**

- Apply these patterns to your own projects
- Track impact over time

## Facilitation tips

### Encouraging Copilot usage

**Good Prompts:**

- "Have you tried asking Copilot in chat?"
- "What if you describe what you want in a comment?"
- "Try using the /explain command on that code"

**Avoid:**

- Giving direct solutions
- Writing code for participants
- Skipping the Copilot learning

### Common issues & solutions

**Issue: "Copilot isn't suggesting anything"**

- Check they're signed in
- Verify Copilot status icon
- Suggest restarting VS Code
- Check internet connection

**Issue: "Suggestions aren't relevant"**

- Ask to see their comments/prompts
- Suggest being more specific
- Show how to provide context
- Use chat instead of inline

**Issue: "I don't understand the generated code"**

- Use `/explain` and review the code with the participant

**Issue: "Challenge is too hard/easy"**

- Suggest different challenge within their track
- Point to additional challenges in the track guide
- Consider switching tracks if significantly mismatched
- Encourage helping others on same track

### Time management

**If running behind:**

- Finish required stages before optional work
- Extend demo time if needed

**If ahead of schedule:**

- Complete more challenges from the track
- Try challenges from another track
- Explore advanced features

## Track-specific facilitation guide

### Backend developer track

**Common challenges:**

- For JWT validation errors, ask participants to check the configured secret
  and `Authorization` header handling. Have them give Copilot the error and
  request flow, without sharing secrets.
- If Jest or pytest setup stalls, check dependencies and test configuration.
  Ask Copilot to explain an existing starter test before adding new ones.

**Facilitation tips:**

- The simple starter makes this track a useful starting point for new Copilot users.
- If participants do not understand a long Copilot suggestion, have them use
  `/explain` before accepting it.
- If participants finish Stage 3 early, move to Stage 4's bug hunt before
  adding more CRUD endpoints.

### Data science & ML track

**Common challenges:**

- If participants expect Copilot to choose features for them, ask them to
  describe what each feature should capture before requesting code.
- Jupyter notebook inline suggestions can be slow or absent if the kernel is restarting. If suggestions stop appearing, have them save, restart the kernel, and re-run prior cells.

**Facilitation tips:**

- Ask participants to split notebook cells by logical step and describe their intent.
- Keep hyperparameter tuning within 30 minutes so participants can complete
  the data pipeline and evaluate the model.
- Demonstrate `/explain` on a scikit-learn estimator early in the session.

### DevOps & platform track

**Common challenges:**

- Verify before the session that Azure sandbox accounts have the necessary
  roles. If authentication fails during the session, use the local Docker path
  while you resolve it.
- For Terraform state errors, ask Copilot to explain the message and check
  whether the backend is initialized. Verify who owns a lock before considering
  `terraform force-unlock`.

**Facilitation tips:**

- Test the devcontainer before the session, especially the Terraform stages.
- Use the Chat view for multi-line Terraform errors.
- For GitHub Actions failures, give Copilot the relevant log and workflow
  context. Remove secrets before sharing logs.

### Frontend developer track

**Common challenges:**

- For generated TypeScript errors, inspect the editor diagnostic and use
  `/fix` in inline chat. Review the fix before accepting it.
- Before deciding where React state belongs, ask participants to describe
  which components need it and what should happen when it changes.

**Facilitation tips:**

- Open an existing component as context before requesting another.
- Keep time for accessibility checks. Ask Copilot to review ARIA usage, then
  verify the component in the browser.
- For participants new to TypeScript, set the expectation early: ask Copilot to
  explain inferred types rather than adding `any` casts.

### QA tester track

**Common challenges:**

- Playwright's first installation downloads browser binaries and takes
  2-3 minutes. Explain the wait before participants assume it is stuck.
- Page Object Model patterns are unfamiliar to participants who've only written procedural tests. Have them open an existing POM file from the starter code and ask Copilot to explain the pattern before generating new pages.
- For flaky tests, check for missing `await` and hard-coded timeouts. Ask
  Copilot to review the failure for race conditions.

**Facilitation tips:**

- Reserve time for Playwright MCP and start the dev server before using it.
- Give `/tests` the function's signature and expected behavior. If suggestions
  are vague, add a one-line comment describing that behavior.
- Ask participants to test failure cases as well as the expected flow.

### Challenge 7: Copilot SDK Track

**Common challenges:**

- Understanding the Copilot SDK architecture (SDK communicates with Copilot CLI via JSON-RPC)
- Defining and handling custom tool calls
- Managing session lifecycle and streaming events

**Facilitation tips:**

- Only for participants who finished a core track
- Requires solid Node.js/Express experience
- Check the track's time budget before assigning it
- Help with GitHub App registration and debugging

### Challenge 8: Flight Delay Predictor Track

**Common challenges:**

- Integration between ML model, API, and frontend
- Time management across multiple domains

**Facilitation tips:**

- Only for experienced full-stack developers
- Spans data science, backend, and frontend
- Keep the work within the track's 4-6-hour core
- Help with prioritization across the stack

### Challenge 9: Cross-Functional Team Sprint Track

**Common challenges:**

- Coordinating between PO, developers, QA, and DevOps in parallel
- Managing scope when multiple people contribute to the same codebase
- Converting the Spark prototype into a development repository

**Facilitation tips:**

- Requires a team of 4-6 people, not for solo participants
- The PO drives the first stage; make sure they have GitHub Spark access
- Help the team stick to timeboxes for sprint planning
- Intervene if the team skips sprint planning or standup sync points

### Challenge 10: Technical Team Sprint Track

**Common challenges:**

- Self-organizing without a PO can lead to scope creep or unclear priorities
- Breaking the provided specification into actionable Issues
- Integration between frontend and backend without a coordinator

**Facilitation tips:**

- Requires a team of 2-4 technical people, not solo participants
- The supplied specification lets the team start with technical planning
- Clarify the supplied specification before coding
- Keep teams from skipping technical planning
- Help the team self-organize by suggesting one person manage the project board

## Challenge & track difficulty guide

### By track difficulty

**Beginner-Friendly Tracks:**

- Backend Developer Track (recommended starting point)
- Frontend Developer Track

**Intermediate Tracks:**

- Data Science & ML Track
- DevOps & Platform Track
- QA Tester Track

**Advanced Individual Challenge Tracks:**

- Copilot SDK Track (requires completion of a core track)
- Flight Delay Predictor Track (full-stack, multi-domain)

**Team Challenge Tracks:**

- Cross-Functional Team Sprint Track (4-6 people, all roles)
- Technical Team Sprint Track (2-4 developers/engineers, no business roles)

### By individual challenge

**Beginner-Friendly:**

- Challenge 1: Web API (with Node.js)
- Challenge 4: Frontend (start with components)

**Intermediate:**

- Challenge 1: Web API (with Python)
- Challenge 2: ML/AI
- Challenge 3: DevOps (Terraform basics)

**Advanced:**

- Challenge 3: DevOps (full stack)
- Challenge 5: QA (advanced automation patterns)
- Challenge 7: Copilot SDK (building SDK applications)
- Challenge 8: Flight Delay Predictor (full-stack ML app)

## Metrics to track

Ask participants to note:

- **Outcome delivered** (what they built/shipped/modernized)
- **Business impact**, with evidence for time saved, risk reduced, quality
  improved, or toil eliminated
- Where Copilot helped or slowed the work
- Reusable skills and agents, plus any useful chat techniques
- Time spent
- Supporting activity metrics, such as chat interactions, when useful

## Post-session

### Follow-up (within 1 week)

**Send to Participants:**

- [ ] Thank you email
- [ ] Feedback survey (include outcome-driven questions: What did you deliver? What was the business impact?)
- [ ] Additional resources
- [ ] Next steps for continued use

Ask what participants delivered, what evidence supports the impact, where
Copilot helped or slowed the work, and which practices they will reuse.
Collect feedback on the overall experience.

### Share results

Create a summary:

- Participation stats
- Reported productivity gains, distinguished from measured results
- Practices teams can reuse
- Results teams demonstrated
- Areas for improvement

## Sample schedule

### Full day (8 hours)

```text
09:00 - 09:30   Welcome & Copilot Demo
09:30 - 09:45   Environment Setup
09:45 - 12:00   Challenge Time (Session 1)
12:00 - 13:00   Lunch
13:00 - 13:15   Mid-day Check-in
13:15 - 15:30   Challenge Time (Session 2)
15:30 - 15:45   Break
15:45 - 17:00   Showcase & Presentations
17:00 - 17:30   Best Practices & Wrap-up

```

### Half day (4 hours)

```text
09:00 - 09:20   Welcome & Quick Demo
09:20 - 11:30   Challenge Time
11:30 - 11:45   Break
11:45 - 12:45   Showcase
12:45 - 13:00   Wrap-up

```

## Resources for facilitators

### Preparation materials

- Read the selected track and stage guides
- Complete at least 2 challenges yourself
- Review documentation
- Test the Codespace setup

### During event

- Keep docs open: `docs/` folder
- Have solutions ready (for reference only)
- Monitor Slack/Teams for questions
- Take photos/notes for recap

### Backup plans

- Network issues: Local development setup
- Codespace quota: Local Docker
- Copilot outage: Focus on manual learning, reschedule

## Success criteria

Each team demonstrates its result and explains the impact. Participants
identify where Copilot helped and which practices they will use in daily work.
Use activity metrics as supporting evidence, not the main measure of success.

## Questions & support

Check the selected track guide or ask in the organizer chat.
