# Stage 1: Log analysis agent

**Duration:** 2-2.5 hours

**Focus:** Build an agent that identifies errors in logs and explains them in plain language

## Tasks

Use your repository instructions for the Order Gateway context. Have the Log Analyst agent group and explain errors, and use the log triage skill to repeat the same checks for each log.

1. Read both log files (`gateway-2025-12-01.log` and `gateway-2025-12-02.log`) before building the agent. Identify each distinct error pattern and record its type, frequency, whether it recurs, and likely root cause.

2. Create `.github/agents/log-analyst.agent.md` with these capabilities:
   - Accepts a log file via `#file` reference
   - Identifies all errors and warnings
   - Groups related log entries (e.g., the 3 payment retry entries belong to the same incident)
   - For each error group: explains what happened in plain language, assesses severity, and suggests what to investigate
   - Distinguishes between root causes and symptoms (e.g., connection pool exhaustion is a symptom of slow queries)

3. Test the agent on `gateway-2025-12-01.log`. Verify it identifies:
   - Payment gateway timeouts (with retries)
   - Warehouse API connectivity failure
   - Database deadlock
   - Authentication failures (possible security issue)
   - OutOfMemoryError (critical)

4. Test the agent on `gateway-2025-12-02.log`. Verify it identifies:
   - Slow queries leading to connection pool exhaustion
   - SMTP connection failure
   - Invalid order state transition
   - Batch reconciliation mismatches

5. Show the output to someone without deep technical knowledge. Check whether they can explain what happened and why it matters. Adjust the agent's instructions if they cannot.

6. Have the agent classify each error as Critical, High, Medium, or Low based on impact (full outage vs. single user affected, data loss risk, security implications).

## Verification

- [ ] Both log files manually analyzed (all error patterns identified)
- [ ] Log analysis agent created (`.github/agents/log-analyst.agent.md`)
- [ ] Agent correctly identifies all error patterns in Day 1 logs
- [ ] Agent correctly identifies all error patterns in Day 2 logs
- [ ] Agent output is understandable by non-technical support staff
- [ ] Severity classification included in output

---

Previous: [Stages](stages.md) | Next: [Stage 2: Incident Routing](stage-2-routing.md)
