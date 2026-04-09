# Phase 1: Log Analysis Agent

[Back to Ops Assistant Track](../bonus-ops-assistant-track.md)

**Duration:** 2-2.5 hours

**Focus:** Building an agent that reads logs, identifies errors, and explains them in plain language

## Tasks

1. **Analyze the log files manually first.** Read through both log files (`gateway-2025-12-01.log` and `gateway-2025-12-02.log`). Identify every distinct error pattern. For each, note: the error type, how many times it occurs, whether it looks like a one-off or a recurring issue, and what the likely root cause is.

2. **Create the log analysis agent.** Create `.github/agents/log-analyst.agent.md` that:
   - Accepts a log file via `#file` reference
   - Identifies all errors and warnings
   - Groups related log entries (e.g., the 3 payment retry entries belong to the same incident)
   - For each error group: explains what happened in plain language, assesses severity, and suggests what to investigate
   - Distinguishes between root causes and symptoms (e.g., connection pool exhaustion is a symptom of slow queries)

3. **Test on Day 1 logs.** Point the agent at `gateway-2025-12-01.log`. Verify it identifies:
   - Payment gateway timeouts (with retries)
   - Warehouse API connectivity failure
   - Database deadlock
   - Authentication failures (possible security issue)
   - OutOfMemoryError (critical)

4. **Test on Day 2 logs.** Point the agent at `gateway-2025-12-02.log`. Verify it identifies:
   - Slow queries leading to connection pool exhaustion
   - SMTP connection failure
   - Invalid order state transition
   - Batch reconciliation mismatches

5. **Test the plain-language output.** Show the agent's output to someone without deep technical knowledge. Can they understand what happened and why it matters? If not, adjust the agent's instructions.

6. **Add severity classification.** Enhance the agent to classify each error as Critical, High, Medium, or Low based on impact (full outage vs. single user affected, data loss risk, security implications).

## Verification

- [ ] Both log files manually analyzed (all error patterns identified)
- [ ] Log analysis agent created (`.github/agents/log-analyst.agent.md`)
- [ ] Agent correctly identifies all error patterns in Day 1 logs
- [ ] Agent correctly identifies all error patterns in Day 2 logs
- [ ] Agent output is understandable by non-technical support staff
- [ ] Severity classification included in output

---

Next: [Phase 2: Incident Routing](phase-2-routing.md)
