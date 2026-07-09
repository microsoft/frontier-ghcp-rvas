# Facilitator Guide

## Overview

This RVAS delivery session helps teams **drive real work outcomes** with GitHub Copilot, and use those outcomes to build lasting adoption. Your role as facilitator is to guide participants to define a measurable outcome, work through the stages that deliver it, and demonstrate the business impact at the end.

Participants can either pick a **worked-example challenge** from the 22 tracks or **bring their own app/repository** and run an RVAS delivery session on their own codebase. See the **[BYOC Facilitator Runbook](./byoc/facilitator-runbook.md)** for guidance on customer-codebase sessions.

## Pre-Session Setup (1 week before)

### 1. **Verify Prerequisites**

- [ ] All participants have GitHub accounts
- [ ] GitHub Copilot licenses are provisioned
- [ ] Codespaces are enabled for the organization
- [ ] Test the devcontainer setup

### 2. **Environment Preparation**

```bash

# Test the devcontainer builds successfully

# Create a Codespace from the main branch

# Verify all extensions install correctly

# Run the post-create script

```

### 3. **Understand the Track Structure**

Review the seven core tracks:

**Core Tracks (4-6 hours):**

- [ ] [Challenge 1: Web API Track](./tracks/challenge-1-web-api-track.md)
- [ ] [Challenge 2: ML & AI Track](./tracks/challenge-2-ml-ai-track.md)
- [ ] [Challenge 3: DevOps Track](./tracks/challenge-3-devops-track.md)
- [ ] [Challenge 4: Frontend Track](./tracks/challenge-4-frontend-track.md)
- [ ] [Challenge 5: QA & Testing Track](./tracks/challenge-5-qa-track.md)

**Challenge 7-18 Tracks:**

- [ ] [Copilot SDK Track](./tracks/challenge-7-copilot-sdk-track.md)
- [ ] [Flight Delay Predictor Track](./tracks/challenge-8-flight-delay-track.md)
- [ ] [Cross-Functional Team Sprint Track](./tracks/challenge-9-team-sprint-track.md)
- [ ] [Technical Team Sprint Track](./tracks/challenge-10-tech-sprint-track.md)

### 4. **Communication**

Send participants:

- [ ] Repository link
- [ ] **[Tracks Overview](./tracks/README.md)** - Ask them to review before the event
- [ ] Session schedule
- [ ] Pre-reading: `docs/copilot-guide.md`
- [ ] Setup instructions
- [ ] Slack/Teams channel for questions

## Day of the Session

### Opening Session (30 min)

**Welcome & Introduction (10 min)**

- Introduce GitHub Copilot
- Frame the session as **outcome-driven work** -- participants will deliver a demonstrable result, not just learn features
- Explain the two paths: pick a worked-example challenge, or bring your own app and define your own outcome
- Review schedule
- Show the [Tracks Overview](./tracks/README.md) and the [BYOC kit](./byoc/)

**Demo: Copilot Basics (15 min)**

- Show inline suggestions
- Demonstrate chat commands (`/explain`, `/fix`, `/tests`)
- Quick example of workspace context
- Show MCP servers (briefly)

**Track or Outcome Selection (5 min)**

- Help participants choose their worked-example track OR define their own outcome
- For worked examples: suggest track based on outcome they want to drive or their role
- For BYOC: point them to [Outcome Canvas](./byoc/outcome-canvas.md)
- Direct them to [Tracks Guide](./tracks/README.md) or [BYOC README](./byoc/README.md)

### Challenge Time (4-5 hours)

**Recommended Flow (Outcome-Based):**

1. Participants define or choose their outcome
2. Work through the challenge stages (or their own app) to deliver it
3. Work individually or in pairs
4. Facilitators rotate to help teams stay focused on the outcome
5. Encourage using Copilot Chat for help

**Tips for Facilitators:**

- Don't solve problems directly
- Guide participants to use Copilot
- Keep the conversation tied to the outcome: "What are you trying to deliver? How will you demo it?"
- Share interesting outcome-driven patterns with the group

### Mid-Day Check-in (15 min)

Around lunch, gather everyone:

- Quick poll: What outcome are you working on? What stage?
- Share 2-3 outcome wins from different teams
- Address common issues
- Reinforce outcome focus: "Show me what you're delivering"

### Showcase Session (1-2 hours)

**Format Options:**

**Option A: Outcome-Based Demos** RECOMMENDED

- Group participants by the outcome they delivered
- Each team presents their result and the business impact
- Compare approaches across similar outcomes
- Share outcome-driven Copilot patterns

**Option B: Demo Stations**

- Set up tables for each outcome theme
- Participants showcase their work and explain the impact
- Informal walk-around format

**Option C: Presentations**

- Each person/team presents (5 min each)
- Show the outcome they delivered and demo it
- State the business impact: time saved, risk reduced, quality improved
- Highlight Copilot patterns that accelerated the work

**Option D: Lightning Talks**

- 2-minute rapid-fire presentations
- Focus on the outcome and one key Copilot pattern

### Wrap-Up Session (30 min)

**Outcome Review (15 min)**

- What outcomes did teams deliver?
- What business impact did each produce?
- How did Copilot accelerate the work?
- Patterns discovered

**Q&A (5 min)**

**Next Steps (10 min)**

- Apply these patterns to your own projects
- Use the **[Outcome Scorecard](./byoc/outcome-scorecard.md)** for future work sessions
- Track impact over time

## Facilitation Tips

### Encouraging Copilot Usage

**Good Prompts:**

- "Have you tried asking Copilot in chat?"
- "What if you describe what you want in a comment?"
- "Try using the /explain command on that code"

**Avoid:**

- Giving direct solutions
- Writing code for participants
- Skipping the Copilot learning

### Common Issues & Solutions

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

- Perfect! Use `/explain`
- This is a learning opportunity
- Review together with participant

**Issue: "Challenge is too hard/easy"**

- Suggest different challenge within their track
- Point to additional challenges in the track guide
- Consider switching tracks if significantly mismatched
- Encourage helping others on same track

**Issue: "I picked the wrong track"**

- It's okay to switch tracks!
- Help them find a better fit
- Suggest starting the recommended challenge for new track

### Time Management

**If running behind:**

- Focus on required challenges in the track
- Skip optional challenges
- Focus on quality over quantity
- Extend showcase if needed

**If ahead of schedule:**

- Complete more challenges from the track
- Try challenges from another track
- Explore advanced features

## Track-Specific Facilitation Guide

### Backend Developer Track

**Common challenges:**

- Participants get stuck on JWT token validation errors, usually because they've hardcoded the secret or forgotten to check `Authorization` header casing. Ask them to paste the error into Copilot Chat and describe the flow -- it usually surfaces the missing piece quickly.
- Test setup (Jest or pytest) stalls when participants skip the package install step or can't find the right test config. Point them to the existing test file in the starter code and ask Copilot to explain it before writing new tests.

**Facilitation tips:**

- This is the most forgiving track for new Copilot users. The starter code is intentionally simple, so Copilot suggestions are accurate and easy to evaluate.
- When someone gets a long Copilot suggestion they don't understand, stop them and use `/explain` before accepting it. This is a better learning moment than accepting and moving on.
- If participants finish Stage 3 early, push them to Stage 4's bug hunt rather than polishing earlier stages -- debugging with Copilot is more instructive than adding more CRUD endpoints.

### Data Science & ML Track

**Common challenges:**

- Feature engineering decisions block participants who expect Copilot to make the choices for them. Redirect: ask them to write a comment explaining what the feature should capture, then let Copilot suggest code for it.
- Jupyter notebook inline suggestions can be slow or absent if the kernel is restarting. If suggestions stop appearing, have them save, restart the kernel, and re-run prior cells.

**Facilitation tips:**

- Copilot works better in notebooks when cells are small and comments describe intent. Participants who write one giant cell get worse suggestions. Ask them to split by logical step and add a comment at the top of each.
- The ML model quality is not the goal -- the goal is using Copilot to move through the data pipeline faster. Don't let participants spend more than 30 minutes tuning hyperparameters.
- `/explain` on scikit-learn estimators is unusually good. Show this early to build confidence.

### DevOps & Platform Track

**Common challenges:**

- Cloud credentials are the most common blocker. Verify before the session that sandbox accounts have the necessary roles assigned. If someone hits an auth error mid-session, have them switch to the local Docker path while you resolve it.
- Terraform state errors (locked state, missing backend) confuse participants who've never used Terraform. Ask Copilot to explain the error message -- it usually gives a clear diagnosis and a `terraform force-unlock` or `terraform init` fix.

**Facilitation tips:**

- This track has the highest setup complexity. Do a dry run with the devcontainer before the session, especially for the Terraform stages.
- Participants often paste Terraform errors into inline chat rather than the Chat view. The Chat view gives better responses for multi-line error output -- redirect them there.
- CI/CD stage failures in GitHub Actions are easier to debug by fetching the raw log URL and pasting it into Copilot Chat than by reading the folded UI.

### Frontend Developer Track

**Common challenges:**

- TypeScript type errors from generated components are the most common friction point. Participants accept a suggestion, get a red underline, and don't know why. Ask them to hover the error and use `/fix` in inline chat -- this closes the loop fast.
- State management decisions (where to put state, when to lift it) stall participants who don't have a React mental model yet. Ask them to describe what the component should do in a comment; Copilot usually picks a reasonable approach.

**Facilitation tips:**

- Component generation works well when participants open an existing component as a reference tab before prompting. Tell them: "Show Copilot what you already have before asking for something new."
- The accessibility stage (Stage 4) is easy to skip but high-value for demonstrating Copilot's breadth. Prompt: "Ask Copilot to audit this component for ARIA issues."
- Participants who came from a non-TypeScript background benefit from asking Copilot to explain inferred types rather than adding `any` casts. Set that expectation early.

### QA Tester Track

**Common challenges:**

- Playwright installation and browser download takes 2-3 minutes the first time and participants think it's stuck. Let them know it's downloading browser binaries.
- Page Object Model patterns are unfamiliar to participants who've only written procedural tests. Have them open an existing POM file from the starter code and ask Copilot to explain the pattern before generating new pages.
- Flaky tests are usually caused by missing `await` or a hard-coded timeout. Ask Copilot to review the failing test for race conditions -- it catches most of these.

**Facilitation tips:**

- The Playwright MCP integration (Stage 3) is the most impressive demo in this track. Reserve time for it and make sure the dev server is running before they start.
- Test generation with `/tests` works best when the function under test has a clear signature and docstring. If suggestions are vague, ask participants to add a one-line comment describing the expected behavior first.
- This track rewards participants who think like testers, not just developers. Encourage them to ask: "What would break this?" rather than "Does this work?".

### Challenge 7: Copilot SDK Track

**Common challenges:**

- Understanding the Copilot SDK architecture (SDK communicates with Copilot CLI via JSON-RPC)
- Defining and handling custom tool calls
- Managing session lifecycle and streaming events

**Facilitation tips:**

- Only for participants who finished a core track
- Requires solid Node.js/Express experience
- Significantly longer (8-12 hours)
- Help with GitHub App registration and debugging

### Challenge 8: Flight Delay Predictor Track

**Common challenges:**

- Integration between ML model, API, and frontend
- Time management across multiple domains

**Facilitation tips:**

- Only for experienced full-stack developers
- Spans data science, backend, and frontend
- Significantly longer (8-12 hours)
- Help with prioritization across the stack

### Challenge 9: Cross-Functional Team Sprint Track

**Common challenges:**

- Coordinating between PO, developers, QA, and DevOps in parallel
- Managing scope when multiple people contribute to the same codebase
- The Spark handover -- converting a prototype into a development repo

**Facilitation tips:**

- Requires a team of 4-6 people, not for solo participants
- The PO drives the first phase; make sure they have GitHub Spark access
- Help the team stick to timeboxes for sprint planning
- Intervene if the team skips sprint planning or standup sync points

### Challenge 10: Technical Team Sprint Track

**Common challenges:**

- Self-organizing without a PO can lead to scope creep or unclear priorities
- Breaking the provided specification into actionable Issues
- Integration between frontend and backend without a coordinator

**Facilitation tips:**

- Requires a team of 4 technical people, not for solo participants
- No business roles -- the spec is provided, so the team jumps straight to technical planning
- Encourage the team to write a clear technical spec before coding
- Watch for teams that skip the planning phase and dive into code too early
- Help the team self-organize by suggesting one person manage the project board

## Challenge & Track Difficulty Guide

### By Track Difficulty

**Beginner-Friendly Tracks:**

- Backend Developer Track (recommended starting point)
- Frontend Developer Track

**Intermediate Tracks:**

- Data Science & ML Track
- DevOps & Platform Track
- QA Tester Track

**Advanced Individual Challenge Tracks (8-12 hours):**

- Copilot SDK Track (requires completion of a core track)
- Flight Delay Predictor Track (full-stack, multi-domain)

**Team Challenge Tracks (8 hours):**

- Cross-Functional Team Sprint Track (4-6 people, all roles)
- Technical Team Sprint Track (4 developers/engineers, no business roles)

### By Individual Challenge

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

## Metrics to Track

Ask participants to note:

- **Outcome delivered** (what they built/shipped/modernized)
- **Business impact** (time saved, risk reduced, quality improved, toil eliminated)
- How Copilot accelerated the work
- Patterns discovered (prompts, agents, workflow changes)
- Time spent
- Supporting evidence: percentage of code generated by Copilot, chat interactions

## Post-Session

### Follow-Up (within 1 week)

**Send to Participants:**

- [ ] Thank you email
- [ ] Feedback survey (include outcome-driven questions: What did you deliver? What was the business impact?)
- [ ] Link to **[Outcome Scorecard](./byoc/outcome-scorecard.md)** for future work sessions
- [ ] Additional resources
- [ ] Next steps for continued use

**Collect Feedback on:**

- Outcome clarity and achievement
- Business impact realized
- Copilot effectiveness in driving the outcome
- Patterns discovered
- Overall experience

## BYOC Sessions

If you're running an RVAS delivery session on a customer's own app or repository, see the **[BYOC Facilitator Runbook](./byoc/facilitator-runbook.md)** for:

- How to run outcome-definition workshops
- Environment and devcontainer guidance for customer codebases
- Timeboxes and checkpoints for custom challenges
- Outcome review and scorecard facilitation

### Share Results

Create a summary:

- Participation stats
- Productivity gains reported
- Common learnings
- Success stories
- Areas for improvement

## Sample Schedule

### Full Day (8 hours)

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

### Half Day (4 hours)

```text
09:00 - 09:20   Welcome & Quick Demo
09:20 - 11:30   Challenge Time
11:30 - 11:45   Break
11:45 - 12:45   Showcase
12:45 - 13:00   Wrap-up

```

## Resources for Facilitators

### Preparation Materials

- Read all challenge READMEs
- Complete at least 2 challenges yourself
- Review documentation
- Test the Codespace setup

### During Event

- Keep docs open: `docs/` folder
- Have solutions ready (for reference only)
- Monitor Slack/Teams for questions
- Take photos/notes for recap

### Backup Plans

- Network issues: Local development setup
- Codespace quota: Local Docker
- Copilot outage: Focus on manual learning, reschedule

## Success Criteria

A successful RVAS delivery session means:

- Each team delivered a **demonstrable outcome** (working code, shipped feature, modernized system, or automated process)
- Participants can **articulate the business impact** (faster delivery, reduced risk, lower toil, improved quality)
- Teams used Copilot to accelerate the work and can **explain the patterns** they applied
- Participants leave with a **plan to adopt** these patterns in daily work, so the session drives lasting Copilot adoption rather than a one-off result

Track activity metrics (Copilot usage percentage, chat interactions) as supporting evidence, but measure success by the outcomes delivered and the business impact produced.

## Questions & Support

For facilitation questions:

- Review this guide
- Check challenge READMEs
- Consult docs folder
- Ask in organizer chat

---

For outcome review and scorecard facilitation, see the [BYOC Facilitator Runbook](./byoc/facilitator-runbook.md).
