# Phase 2: Technical Analysis

[Back to Spec-to-Ship Accelerator Track](../bonus-spec-to-ship-track.md)

**Duration:** 1-1.5 hours

**Focus:** Generating a technical analysis from the spec and the existing codebase

## Tasks

1. **Study the existing app.** Read `existing-app/src/server.js`. Understand the current data model (tenants, users), the API patterns, and the code conventions.

2. **Build the technical analysis prompt.** Create `.github/prompts/technical-analysis.prompt.md` that:
   - Takes the spec (`#file:billing-module-requirements.md`) and the existing codebase (`@workspace` or specific `#file` references)
   - Produces a technical analysis document covering:
     - Which existing modules are affected
     - New data models needed (subscriptions, usage records, invoices, payment methods)
     - API design decisions (URL structure, request/response formats consistent with existing patterns)
     - Database schema changes
     - External integration points (Stripe, event bus)
     - Risk assessment (what could go wrong, what is complex)
     - Recommended implementation order (what to build first)

3. **Run the prompt.** Generate the technical analysis. Save it to `docs/technical-analysis.md` in the challenge folder.

4. **Validate against the spec.** Check that the technical analysis is consistent with the requirements:
   - Are all API endpoints from the spec accounted for?
   - Does the database schema support all the data requirements?
   - Are the authorization rules addressed in the design?
   - Is the Stripe integration approach PCI-compliant (no card numbers stored)?

5. **Identify what the prompt misses.** What would a senior developer add that the prompt did not? Common gaps: error handling strategy, monitoring/observability plan, performance considerations for the usage metering queries.

## Verification

- [ ] Technical analysis prompt created (`.github/prompts/technical-analysis.prompt.md`)
- [ ] Technical analysis generated for the billing module
- [ ] Analysis covers: affected modules, new models, API design, schema, integrations, risks, implementation order
- [ ] Analysis is consistent with the spec requirements
- [ ] Gaps identified and documented

---

Previous: [Phase 1: Spec to Backlog](phase-1-backlog.md) | Next: [Phase 3: Code Generation](phase-3-code.md)
