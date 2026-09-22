# Stage 2: Incident Routing

**Duration:** 1.5-2 hours

**Focus:** Building a skill that routes issues to the correct team based on error patterns

## Tasks

1. **Study the routing guide.** Read `docs/team-routing.md`. Note the mapping between error patterns and teams, and the escalation path.

2. **Build the incident routing skill.** Extend the Historical Pattern Match skill from setup in `.github/skills/route-incident/SKILL.md`. Use the Incident Router agent to assess ownership while the skill follows a repeatable evidence-checking workflow that:
   - Takes an error log excerpt or a description of a problem
   - Matches the error against known patterns from the routing guide
   - Recommends which team should investigate
   - Assigns a severity level
   - Checks the incident history for similar past incidents and references them
   - Provides a suggested initial message for the team channel

3. **Test with known error patterns.** Use the skill on each of these scenarios and verify correct routing:
   - A payment timeout error from the logs (should route to Payments Team)
   - A connection pool exhaustion error (should route to Backend Team)
   - An SMTP failure (should route to Infrastructure Team)
   - A JWT signature failure (should route to Security Team)
   - A warehouse API connectivity issue (should route to Integrations Team)

4. **Test with ambiguous or compound errors.** Give the skill a log excerpt that contains multiple interrelated errors (e.g., slow queries causing pool exhaustion causing API failures). Verify it identifies the root cause team, not just the symptom team.

5. **Check incident history correlation.** When a new error matches a past incident, the routing recommendation should cite that incident and its resolution. For example, a match to INC-2025-0051 should identify the database-index fix and suggest checking for a regression. State when no historical match is supported.

If your routing agent or routing skill gives generic advice or conflicts with the team-routing guide, revise it before moving to troubleshooting aids.

## Verification

- [ ] Routing recommendations cite the log evidence and team-routing guide
- [ ] Correctly routes 5 distinct error types to the right teams
- [ ] Handles compound errors by identifying root cause teams
- [ ] References historical incidents when patterns match
- [ ] Suggested team messages are clear and actionable

---

Previous: [Stage 1: Log Analysis Agent](stage-1-log-analysis.md) | Next: [Stage 3: Troubleshooting Aids](stage-3-troubleshooting.md)
