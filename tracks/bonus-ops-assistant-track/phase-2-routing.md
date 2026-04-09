# Phase 2: Incident Routing

[Back to Ops Assistant Track](../bonus-ops-assistant-track.md)

**Duration:** 1.5-2 hours

**Focus:** Building a prompt that routes issues to the correct team based on error patterns

## Tasks

1. **Study the routing guide.** Read `docs/team-routing.md`. Note the mapping between error patterns and teams, and the escalation path.

2. **Create an incident routing prompt.** Create `.github/prompts/route-incident.prompt.md` that:
   - Takes an error log excerpt or a description of a problem
   - Matches the error against known patterns from the routing guide
   - Recommends which team should investigate
   - Assigns a severity level
   - Checks the incident history for similar past incidents and references them
   - Provides a suggested initial message for the team channel

3. **Test with known error patterns.** Feed the prompt each of these scenarios and verify correct routing:
   - A payment timeout error from the logs (should route to Payments Team)
   - A connection pool exhaustion error (should route to Backend Team)
   - An SMTP failure (should route to Infrastructure Team)
   - A JWT signature failure (should route to Security Team)
   - A warehouse API connectivity issue (should route to Integrations Team)

4. **Test with ambiguous or compound errors.** Feed the prompt a log excerpt that contains multiple interrelated errors (e.g., slow queries causing pool exhaustion causing API failures). Verify it identifies the root cause team, not just the symptom team.

5. **Add incident history correlation.** Enhance the prompt to reference historical incidents. When a new error matches a past incident's pattern, the prompt should say: "This matches INC-2025-0051 (resolved by adding a database index). Check if the fix has regressed."

## Verification

- [ ] Incident routing prompt created (`.github/prompts/route-incident.prompt.md`)
- [ ] Correctly routes 5 distinct error types to the right teams
- [ ] Handles compound errors by identifying root cause teams
- [ ] References historical incidents when patterns match
- [ ] Suggested team messages are clear and actionable

---

Previous: [Phase 1: Log Analysis Agent](phase-1-log-analysis.md) | Next: [Phase 3: Troubleshooting Aids](phase-3-troubleshooting.md)
