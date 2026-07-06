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

**Issue: "I picked the wrong track"** NEW

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

## Track-Specific Facilitation Guide NEW

### Backend Developer Track

**Common challenges:**

- Authentication complexity
- Testing setup

**Facilitation tips:**

- Show JWT debugging techniques
- Demo test generation with `/tests`
- Most beginner-friendly track

### Data Science & ML Track

**Common challenges:**

- Data cleaning decisions
- Feature engineering choices

**Facilitation tips:**

- Encourage using `/explain` for algorithms
- Show Copilot in Jupyter notebooks
- Requires intermediate Python skills

### DevOps & Platform Track

**Common challenges:**

- Cloud credentials/access
- Terraform syntax

**Facilitation tips:**

- Ensure sandbox accounts available
- Demo infrastructure code generation
- Most complex track technically

### Frontend Developer Track

**Common challenges:**

- TypeScript errors
- State management

**Facilitation tips:**

- Show component generation
- Demo type inference
- Good for visual learners

### QA Tester Track

**Common challenges:**

- Playwright setup and configuration
- Page Object Model patterns
- Test stability and flakiness

**Facilitation tips:**

- Demo Playwright MCP integration
- Show test generation with Copilot
- Encourage using `/tests` for generating test cases
- Intermediate-to-advanced track

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

## Challenge & Track Difficulty Guide UPDATED

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

Remember: The goal is learning and discovery, not perfection!
