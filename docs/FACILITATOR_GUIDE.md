# Facilitator Guide

## Overview

This hackathon is organized into **7 core tracks** plus **15 challenge 7-21 tracks** to provide structured learning paths for different team roles. As a facilitator, you'll guide participants to choose the right track and support them through their journey.

## Pre-Hackathon Setup (1 week before)

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

**Challenge 7-21 Tracks:**

- [ ] [Copilot SDK Track](./tracks/challenge-7-copilot-sdk-track.md)
- [ ] [Flight Delay Predictor Track](./tracks/challenge-8-flight-delay-track.md)
- [ ] [Cross-Functional Team Sprint Track](./tracks/challenge-9-team-sprint-track.md)
- [ ] [Technical Team Sprint Track](./tracks/challenge-10-tech-sprint-track.md)

### 4. **Communication**

Send participants:

- [ ] Repository link
- [ ] **[Tracks Overview](./tracks/README.md)** - Ask them to review before the event
- [ ] Hackathon schedule
- [ ] Pre-reading: `docs/copilot-guide.md`
- [ ] Setup instructions
- [ ] Slack/Teams channel for questions

## Day of Hackathon

### Opening Session (30 min)

**Welcome & Introduction (10 min)**

- Introduce GitHub Copilot
- **Explain the track-based format** NEW
- Review schedule
- Show the [Tracks Overview](./tracks/README.md)

**Demo: Copilot Basics (15 min)**

- Show inline suggestions
- Demonstrate chat commands (`/explain`, `/fix`, `/tests`)
- Quick example of workspace context
- Show MCP servers (briefly)

**Track Selection (5 min)** NEW

- Help participants choose their track
- Suggest track based on their role
- Point them to [Tracks Guide](./tracks/README.md)

### Challenge Time (4-5 hours)

**Recommended Flow (Track-Based):** UPDATED

1. Participants choose their track based on their role
2. Each track provides a curated sequence of challenges
3. Work individually or in pairs
4. Facilitators rotate to help teams
5. Encourage using Copilot Chat for help

**Tips for Facilitators:**

- Don't solve problems directly
- Guide participants to use Copilot
- Encourage experimentation
- Share interesting discoveries with the group

### Mid-Day Check-in (15 min)

Around lunch, gather everyone:

- Quick poll: What track are you on? What challenge?
- Share 2-3 "aha!" moments from different tracks
- Address common issues
- **Track-specific tips**: Share insights relevant to each track

### Showcase Session (1-2 hours)

**Format Options:**

**Option A: Track-Based Demos** RECOMMENDED

- Group participants by track
- Each track presents their solutions
- Compare approaches across similar challenges
- Share track-specific Copilot insights

**Option B: Demo Stations**

- Set up tables for each track (or challenge)
- Participants showcase their work
- Informal walk-around format
- Cross-track learning

**Option C: Presentations**

- Each person/team presents (5 min each)
- Show their solution
- Highlight best Copilot interactions
- Track-specific learnings

**Option D: Lightning Talks**

- 2-minute rapid-fire presentations
- Focus on most interesting Copilot use

### Wrap-Up Session (30 min)

**Best Practices Discussion (15 min)**

- What worked well?
- When did Copilot excel?
- When did it struggle?
- Tips and tricks discovered

**Productivity Insights (10 min)**

- Estimate time saved
- Code generated vs written
- Most useful features

**Q&A (5 min)**

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

- **Which track they chose** (challenge number or track name)
- Time spent per challenge
- Percentage of code generated by Copilot
- Number of chat interactions
- Most helpful feature
- Track-specific learnings
- Time saved (estimate)
- Whether a challenge 7-21 track was attempted

## Post-Hackathon

### Follow-Up (within 1 week)

**Send to Participants:**

- [ ] Thank you email
- [ ] Feedback survey (include track-specific questions)
- [ ] Additional resources
- [ ] Link to solutions (if available)
- [ ] Next steps for continued learning

**Collect Feedback on:**

- Track structure effectiveness NEW
- Track difficulty and guidance NEW
- Challenge quality
- Difficulty levels
- Time allocation
- Copilot effectiveness
- Overall experience

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

A successful hackathon means:

- All participants tried Copilot features
- Everyone completed at least 1 challenge
- Participants can explain Copilot benefits
- Team discovered productivity improvements
- Positive feedback on experience
- Plans to use Copilot in daily work

## Questions & Support

For facilitation questions:

- Review this guide
- Check challenge READMEs
- Consult docs folder
- Ask in organizer chat

---

Remember: The goal is learning and discovery, not perfection!
