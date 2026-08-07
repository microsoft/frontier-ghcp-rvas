# Challenge 16 Track: Ops Assistant

**Duration:** 6-8 hours

**Difficulty:** ⭐⭐

**Focus:** Building AI-assisted operations tooling -- log analysis agents, error-to-team routing, troubleshooting aids, and deployment automation -- using Copilot

## Who Is This For

- Support engineers and L1/L2 ops teams who triage production incidents
- Operations teams with limited deep technical knowledge of the applications they support
- SREs who want to accelerate incident response and reduce mean time to resolution
- Teams that currently diagnose issues by manually reading log files

## Prerequisites

- Basic understanding of application logs (log levels, stack traces, timestamps)
- Familiarity with incident management concepts (severity, routing, escalation)
- No deep programming experience required -- this track focuses on Copilot prompts and agents
- Some comfort with Node.js helpful but not necessary (for the demo app)

## Technology Stack

- **Log data:** Production-style log files with multiple error patterns
- **Incident data:** Historical incident reports with root cause analysis
- **Demo app:** Simple Node.js/Express API for testing ops tooling
- **Copilot features:** Custom agents, custom prompts, Copilot chat, Agent mode

## What You Are Working With

You are the operations team for the **Order Gateway** -- a critical e-commerce service that processes customer orders, payments, and notifications. The challenge provides:

- **Log files** (`logs/`): Two days of production logs containing payment timeouts, database deadlocks, connection pool exhaustion, SMTP failures, authentication issues, an OutOfMemoryError, and a mix of normal operations.
- **Incident history** (`incidents/`): Past incidents with severity, duration, root cause, resolution, and responsible team.
- **Team routing guide** (`docs/team-routing.md`): Which error patterns map to which development team.
- **Demo app** (`app/`): A simplified Order Gateway you can run locally to test your ops tooling.

## Getting Started

Follow the [common setup steps](getting-started.md) first (clean start, custom instructions, custom agents, custom skills), then continue below.

### Open and Inspect the Challenge

Navigate to `challenges/challenge-16-ops-assistant/`. Read the [system context](../challenges/challenge-16-ops-assistant/docs/system-context.md) first, then explore the `logs/` and `incidents/` directories before writing any instructions.

A dedicated devcontainer is provided at `.devcontainer/challenge-16-ops-assistant/` with Node.js LTS.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should include:

- That you are building operations tooling for a production order management system
- The team structure and routing rules (from the team routing guide)
- That Copilot should explain errors in plain language suitable for non-technical support staff
- That diagnosis should reference historical incidents when relevant patterns match
- Non-negotiable: never route an incident without citing the log evidence behind the recommendation

### Suggested Custom Agents

- **Log Analyst Agent** -- Reads log files and identifies error patterns, root causes vs. symptoms, severity, and the timeline of events, distinguishing one-off errors from recurring ones. Give it a log file; it returns grouped findings. Use it as the first pass on any incident.
- **Incident Router Agent** -- Takes an error description or log excerpt and determines which team should investigate, what priority to assign, and which historical incidents look similar. Give it the Log Analyst's output; it returns a routing recommendation. Use it once errors are identified, not on raw logs.
- **Runbook Generator Agent** -- Takes an error pattern and produces a step-by-step troubleshooting guide: what to check, what to run, when to escalate. Give it a resolved incident; it drafts the runbook. Use it after resolution, so the next person doesn't start from zero.

### Suggested Custom Skills

- **Log Triage Skill** -- A fixed sequence: pull a log window, group related errors, separate one-off noise from recurring patterns, and timestamp the sequence of events leading to the failure.
- **Historical Pattern Match Skill** -- A repeatable workflow: take a new error signature, search incident history for matching root causes, and attach the closest historical match with its resolution.

Search the shared [examples guidance](getting-started.md#4-learn-from-examples-then-write-your-own) for terms like "log analysis agent", "incident routing skill", and "ops runbook instructions" before you draft your own.

---

## Tips for Using Copilot on This Track

- When feeding log files to Copilot, use `#file` to reference the log files directly. Ask Copilot to "analyze this log file, identify all errors, group related errors together, and explain each group in plain language."
- For the routing prompt, include the team routing table in the prompt context. Ask Copilot to match error patterns against the table and justify its routing recommendation.
- Test your agent against both log files -- day 1 has different error patterns than day 2. A good agent handles both.
- For runbook generation, start from the incident history. Ask Copilot: "Based on INC-2025-0051, write a runbook that an L1 support engineer could follow next time this happens."
- Use the demo app to create live error scenarios. Run the app, hit the `/api/orders?simulate=error` endpoint, and feed the logs to your agent.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)

---

Next: [Stages](challenge-16-ops-assistant-track/stages.md)
