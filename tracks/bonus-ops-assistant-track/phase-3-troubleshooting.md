# Phase 3: Troubleshooting Aids

[Back to Ops Assistant Track](../bonus-ops-assistant-track.md)

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

3. **Create a runbook generation prompt.** Create `.github/prompts/generate-runbook.prompt.md` that takes an incident description (including root cause and resolution) and produces a formatted runbook. Test it by feeding it the incident history entries.

4. **Test on a new scenario.** Invent a new incident that does not match any historical pattern (e.g., "Users report seeing other tenants' data in their dashboard"). Run the prompt and verify it produces a reasonable diagnostic procedure even without historical precedent.

## Verification

- [ ] Troubleshooting decision tree created (covers at least 5 error categories)
- [ ] Runbooks generated for at least 3 historical incidents
- [ ] Runbook generation prompt created and tested
- [ ] Prompt tested on a novel scenario (no matching historical precedent)
- [ ] Decision tree paths lead to specific runbook references

---

Previous: [Phase 2: Incident Routing](phase-2-routing.md) | Next: [Phase 4: Deployment Automation](phase-4-deployment.md)
