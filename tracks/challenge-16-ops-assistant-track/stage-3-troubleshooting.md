# Stage 3: Troubleshooting Aids

**Duration:** 1-1.5 hours

**Focus:** Creating troubleshooting decision trees and runbooks from historical data

## Tasks

1. **Build a troubleshooting decision tree.** Using the incident history and team routing guide, create a markdown document (`docs/troubleshooting-tree.md`) that L1 support can follow:
   - Start with: "What type of error is reported?"
   - Branch by category (payment, database, authentication, email, external service)
   - Each branch leads to specific diagnostic steps and references the relevant past incident
   - End nodes are either "Apply known fix" or "Escalate to [team]"

2. **Generate runbooks from past incidents.** For each incident in the history, use Copilot to produce a step-by-step runbook:
   - What symptoms to look for
   - Diagnostic commands or checks to run
   - Resolution steps (with exact commands where possible)
   - How to verify the fix worked
   - When to escalate instead of self-resolving

3. **Build the runbook generation skill.** Create or refine `.github/skills/generate-runbook/SKILL.md` for a workflow that checks incident evidence and produces a runbook with the sections above. Use the Runbook Generator agent to review the diagnostic and escalation choices. Test the skill with resolved incidents, keeping confirmed fixes separate from proposed checks.

4. **Test on a new scenario.** Invent a new incident that does not match any historical pattern (e.g., "Users report seeing other tenants' data in their dashboard"). Use the skill and verify it proposes diagnostic checks and an escalation path without inventing a confirmed cause or fix.

## Verification

- [ ] Troubleshooting decision tree created (covers at least 5 error categories)
- [ ] Runbooks generated for at least 3 historical incidents
- [ ] Historical runbooks distinguish confirmed fixes from proposed diagnostic checks
- [ ] A novel scenario produces a diagnostic procedure and escalation path without an invented historical match
- [ ] Decision tree paths lead to specific runbook references

---

Previous: [Stage 2: Incident Routing](stage-2-routing.md) | Next: [Stage 4: Deployment Automation](stage-4-deployment.md)
