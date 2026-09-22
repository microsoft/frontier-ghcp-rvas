# Stage 2: Technical Analysis

**Duration:** 1-1.5 hours

**Focus:** Generating a technical analysis from the spec and the existing codebase

## Tasks

1. **Study the existing app.** Read `existing-app/src/server.js`. Understand the current data model (tenants, users), the API patterns, and the code conventions.

2. **Build the technical analysis skill.** Create `.github/skills/technical-analysis/SKILL.md` for a workflow that checks the spec against the codebase and uses the Technical Analyst agent to assess design choices. The skill:
   - Takes the spec (`#file:billing-module-requirements.md`) and the existing codebase (`@workspace` or specific `#file` references)
   - Produces a technical analysis document covering:
     - Which existing modules are affected
     - New data models needed (subscriptions, usage records, invoices, payment methods)
     - API design decisions (URL structure, request/response formats consistent with existing patterns)
     - Database schema changes
     - External integration points (Stripe, event bus)
     - Risk assessment (what could go wrong, what is complex)
     - Recommended implementation order (what to build first)

3. **Use the skill.** Generate the technical analysis. Save it to `docs/technical-analysis.md` in the challenge folder.

4. **Validate against the spec.** Check that the technical analysis is consistent with the requirements:
   - Are all API endpoints from the spec accounted for?
   - Does the database schema support all the data requirements?
   - Are the authorization rules addressed in the design?
   - Is the Stripe integration approach PCI-compliant (no card numbers stored)?

5. **Review the gaps.** Check the analysis for missing error handling, monitoring needs, and performance considerations for usage metering queries. Refine the skill's review criteria where the output is incomplete.

If your Technical Analyst agent or analysis skill produces generic API decisions or a schema that misses metering requirements, refine it before Stage 3 builds against it.

## Verification

- [ ] Technical analysis generated for the billing module
- [ ] Analysis covers: affected modules, new models, API design, schema, integrations, risks, implementation order
- [ ] Analysis is consistent with the spec requirements
- [ ] Gaps identified and documented

---

Previous: [Stage 1: Spec to Backlog](stage-1-backlog.md) | Next: [Stage 3: Code Generation](stage-3-code.md)
