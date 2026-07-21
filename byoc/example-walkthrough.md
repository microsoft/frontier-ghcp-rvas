# BYOC Example Walkthrough

This walkthrough shows how to use the BYOC kit end-to-end. We'll take the **Web API challenge** app and run it through the kit as if it were a customer's own codebase.

## Scenario

**Context:** Your team has an internal task management API built in Node.js. It works, but it has no authentication, no tests, and it's not production-ready. You want to run a GitHub Copilot Adoption delivery session to make it deployable to production.

**Goal:** Use the BYOC kit to define the outcome, structure the work, run the session, and measure the business impact.

## Step 1: Fill in the Outcome Canvas

### Target Outcome

**Type of Outcome:** Raise Quality and Confidence

**One-Sentence Outcome Statement:** "Make the task management API production-ready by adding JWT authentication, writing integration tests, and adding structured logging."

### Current Pain / Baseline

**What problem are you solving?**

The API currently has no auth, so anyone can read/write/delete tasks. There are no tests, so we can't safely refactor or deploy with confidence. Logs are just console.log statements, so we can't debug production issues.

**Why does it matter?**

We can't deploy this to production because it's insecure and untested. The business is blocked from shipping a customer-facing task management feature.

### Definition of Done

- [ ] JWT authentication implemented with role-based access (admin can delete, user can only create/read)
- [ ] Integration tests cover all endpoints with 80%+ coverage
- [ ] Structured logging (JSON format) added to all routes
- [ ] API runs in a Docker container and can be deployed

**Acceptance Criteria:**

1. All endpoints require a valid JWT token
2. Test suite passes with 80%+ coverage
3. Logs are JSON-formatted and include request IDs

### Constraints

- **Time:** 6 hours
- **Team Size:** 2-3 backend developers
- **Technology:** Node.js + Express (existing stack, cannot change)
- **Access:** Repository is internal, team has read/write access
- **Non-Negotiables:** Must maintain backwards compatibility with existing task schema

### App / Repository in Scope

**Name:** TaskAPI

**Repository URL:** `https://github.com/our-org/task-api` (internal)

**Brief Description:** A REST API for managing tasks. Currently supports CRUD operations on tasks (create, read, update, delete). No auth, no tests.

**Current Architecture:** Node.js 20, Express, in-memory storage (will add SQLite for persistence later).

### Demo Plan

1. Show the existing API (no auth -- anyone can delete tasks)
2. Show the new API with JWT auth (rejected without token, accepted with valid token)
3. Run the test suite (all passing, 80%+ coverage)
4. Show structured logs from a sample request

### Success Measurement

**Before:** API has no auth, no tests, console.log logging. Cannot deploy to production.

**After:** API has JWT auth, 80%+ test coverage, structured logging. Ready to deploy.

**Evidence:** Test coverage report, JWT token validation demo, JSON logs.

## Step 2: Decide Whether to Author a Custom Challenge

For this example, we'll **skip authoring a custom challenge** and work directly on the app. The outcome is clear, the work is straightforward, and we don't need a stage-by-stage track file.

(If we wanted a reusable track, we'd copy `byoc/templates/track-template.md` and break the work into 3 stages: Stage 1 - Auth, Stage 2 - Tests, Stage 3 - Logging. But for a one-time session, the canvas is enough.)

## Step 3: Run the Session

### Pre-Session Prep

**Environment Setup:**

We create a `devcontainer.json` for the task-api repo:

```json
{
  "name": "TaskAPI Production Readiness",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:20",
  "postCreateCommand": "npm install",
  "customizations": {
    "vscode": {
      "extensions": [
        "GitHub.copilot",
        "GitHub.copilot-chat"
      ]
    }
  }
}
```

Participants open the repo in Codespaces. The devcontainer installs dependencies automatically.

**Communication:**

We send the team:

- Link to the repo
- Filled-in Outcome Canvas
- Schedule: 6 hours, broken into 3 timeboxes

### Day-Of Structure

**Opening (30 min):**

- State the outcome: "Make this API production-ready -- auth, tests, logging."
- Show the definition of done and acceptance criteria
- Walk through the demo plan
- Copilot demo: show `/tests` command, inline suggestions for boilerplate

**Work Time (4.5 hours):**

Timeboxes:

- **0:00 - 1:30:** Implement JWT auth with role-based access
- **1:30 - 3:00:** Write integration tests for all endpoints
- **3:00 - 4:00:** Add structured logging (JSON format, request IDs)
- **4:00 - 4:30:** Dockerize and verify the whole stack works

**Checkpoints (every 1.5 hours):**

- "What did you deliver in this block?"
- "Are you on track for the definition of done?"
- "Blockers?"

**Facilitator Notes:**

- At 1:30 checkpoint: "Show me your auth implementation. Can you reject a request without a token?"
- At 3:00 checkpoint: "What's your test coverage? Can you show me the report?"
- At 4:00 checkpoint: "Can you run the whole stack in Docker and hit it with curl?"

### Demo and Outcome Review (1 hour)

**Demo (30 min):**

Each pair shows:

1. The old API (no auth -- curl works without a token)
2. The new API (auth enforced -- curl rejected without JWT, accepted with valid token)
3. Test suite output (all passing, 80%+ coverage)
4. JSON logs from a sample request (includes request ID, method, status, duration)

**Outcome Scorecard (20 min):**

We fill in the scorecard as a group:

- **Outcome Statement:** "Made the task management API production-ready with JWT auth, 80%+ test coverage, and structured logging."
- **Acceptance Criteria:** All met (JWT enforced, tests passing, logs JSON-formatted)
- **Before/After Impact:**
  - Before: 0% test coverage, no auth, console.log logging -- blocked from production deployment
  - After: 85% test coverage, JWT auth with role-based access, structured JSON logs -- ready to deploy
- **Evidence:** Test coverage report, demo video, PR with 400+ lines of new tests

**Wrap-Up (10 min):**

- Patterns discovered: `/tests` command generated ~60% of test boilerplate, custom prompt for "add JWT middleware" saved 20 minutes
- Next time: Start with auth first (it's foundational), generate tests as you go rather than at the end
- How to apply: Use the same JWT + test + logging pattern for the notification API next sprint

## Step 4: Fill in the Outcome Scorecard

Here's the filled scorecard:

### Outcome Statement

**What did you deliver?**

Made the task management API production-ready by adding JWT authentication, integration tests, and structured logging.

**Type of Outcome:** Raise Quality and Confidence

### Acceptance Criteria

| Criteria | Met? | Evidence |
|----------|------|----------|
| All endpoints require a valid JWT token | [x] Yes | Demo showed rejected requests without token, accepted with valid token |
| Test suite passes with 80%+ coverage | [x] Yes | Coverage report: 85% (170/200 lines covered) |
| Logs are JSON-formatted and include request IDs | [x] Yes | Sample log: `{"requestId":"abc123","method":"POST","path":"/tasks","status":201,"duration":45}` |

### Evidence and Demo

**Artifacts:**

- [x] PR #47 (adds JWT auth middleware)
- [x] PR #48 (adds integration tests)
- [x] PR #49 (adds structured logging)
- [x] Test coverage report (85%)
- [x] Docker container running the API

**Demo Summary:**

Showed the API rejecting requests without JWT, accepting requests with valid token, test suite passing, and JSON logs.

### Business Impact (Before/After)

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Test coverage | 0% | 85% | +85pp |
| Authentication | None | JWT + RBAC | Security risk eliminated |
| Logging | console.log | JSON + request ID | Debuggable in production |
| Deployable to production | No | Yes | Unblocked customer feature |

### How Copilot Accelerated the Work

**Patterns Used:**

- [x] `/tests` to generate integration test scaffolding (saved ~30 min)
- [x] Inline suggestions for JWT middleware boilerplate
- [x] Custom prompt: "Add structured logging middleware with request ID, method, path, status, duration"
- [x] `/explain` to understand Express middleware flow

**Estimated Time Saved:** 2 hours (work that would have taken 8 hours manually took 6 hours with Copilot)

### Lessons Learned

**What worked well:**

- Defining acceptance criteria upfront kept the work focused
- Using `/tests` early generated scaffolding we could fill in
- Timeboxes prevented over-engineering

**What would you do differently next time:**

- Start with auth first (it's foundational and affects test setup)
- Write tests as you go, not in a separate block

**Patterns to reuse:**

- JWT middleware prompt
- Structured logging prompt (reusable for other APIs)
- Test scaffolding workflow: `/tests` -> fill in assertions -> run coverage

### Next Steps

**Follow-On Work:**

- [ ] Deploy to staging environment
- [ ] Add rate limiting
- [ ] Migrate from in-memory storage to SQLite

**Planned Application:**

Use the same JWT + test + logging pattern for the notification API and the billing API next sprint.

## Key Takeaways

1. **The Outcome Canvas** forced the team to define "done" concretely before starting work. This prevented scope creep.
2. **Timeboxes** kept the work moving. We delivered 3 incremental improvements (auth, tests, logging) instead of trying to "finish" auth perfectly before moving on.
3. **The Outcome Scorecard** documented the business impact (unblocked production deployment) instead of just reporting activity metrics.
4. **Copilot accelerated the work**, but the outcome framing kept it from becoming exploration. The team asked: "How does this move us toward the definition of done?"

## Adapting This to Your Own App

To run a BYOC session on your app:

1. Fill in the **Outcome Canvas** for your context (your app, your pain, your definition of done)
2. Set up a working environment (devcontainer, local setup script, Codespaces)
3. Break the work into 2-4 timeboxes aligned to the outcome
4. Run the session with checkpoints every 1-2 hours
5. Demo the result and fill in the **Outcome Scorecard**

The pattern is the same regardless of the type of outcome (modernize legacy, ship features, automate delivery, etc.).
