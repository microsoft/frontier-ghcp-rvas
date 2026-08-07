# Stage 4: Package the Paved Road

**Difficulty:** ⭐⭐⭐ | **Time:** 60-75 min

Guardrails only work when a service team can discover them, run them locally,
and understand what happens after a check fails. Package the standard as an
onboarding route rather than a pile of platform files.

## Tasks

1. Create `deliverables/observability-requirements.md`. Define required logs,
   metrics, traces, correlation behavior, dashboards, alert ownership, and
   retention decisions. State what must never be logged.
2. Map the requirements to Azure API Management, Azure Monitor, and Application
   Insights. Keep deployment-specific values configurable.
3. Create `deliverables/developer-onboarding.md` for a team publishing a new
   API. Cover local setup, contract submission, review evidence, exception
   requests, version publication, deprecation, and support ownership.
4. Add a small example review packet under `deliverables/example-review/`.
   Use one normalized proposal to show the expected evidence without turning
   the packet into an implementation solution.
5. Add a command table with install, mock, smoke, OpenAPI validation, policy
   validation, baseline reporting, and blocking-check commands.
6. Ask a peer or Copilot to follow the onboarding package without prior
   context. Record confusing steps and revise the package.
7. Run the full local validation one final time. If you used Azure API
   Management, keep deployment evidence separate from the required local
   result.

## Verification

- Observability requirements name signals, owners, privacy boundaries, and
  response actions
- The onboarding package leads from a source contract to a publish decision
- A service team can find every required command and artifact path
- The exception and deprecation routes are usable without private context
- The example review packet is consistent with the standards and automated
  checks
- `npm test` and the blocking proposal check pass
- Azure deployment is clearly optional

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can test the package for missing links and unclear steps. You decide
which operational signals matter, who responds, and how much process a service
team can realistically follow within a delivery cycle.

---

Previous: [Stage 3: Build Enforceable Guardrails](stage-3-build-enforceable-guardrails.md)
