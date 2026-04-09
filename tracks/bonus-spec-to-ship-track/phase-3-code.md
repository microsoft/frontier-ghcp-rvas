# Phase 3: Code Generation

[Back to Spec-to-Ship Accelerator Track](../bonus-spec-to-ship-track.md)

**Duration:** 2-2.5 hours

**Focus:** Using Copilot to implement the billing module from the generated stories

## Tasks

1. **Set up the module structure.** Based on your technical analysis, create the file structure for the billing module within the existing app. Follow the existing code's conventions.

2. **Implement subscription management.** Use Copilot (Agent mode or inline) to generate:
   - Plan data model (starter, professional, enterprise with the rates from the spec)
   - GET endpoint for current subscription
   - PUT endpoint for plan changes (upgrade/downgrade logic, proration for upgrades, next-cycle for downgrades)
   - Plan change logging

3. **Implement usage tracking.** Generate:
   - Usage data model (daily aggregates per tenant per metric)
   - GET endpoint for current usage vs. quotas
   - GET endpoint for historical usage
   - Threshold notification logic (80% and 100%)

4. **Implement invoice generation.** Generate:
   - Invoice data model (with the INV-YYYY-NNNNN numbering)
   - Invoice lifecycle (DRAFT to FINALIZED to PAID/OVERDUE/VOID)
   - Monthly generation logic (base charge + overage calculation)
   - GET and PUT endpoints for invoice management

5. **Implement payment methods.** Generate:
   - Payment method model (Stripe token references, no card numbers)
   - CRUD endpoints with the constraint that at least one method must remain

6. **Write unit tests.** For each module, use Copilot to generate tests that cover:
   - Happy path for each endpoint
   - Business rule edge cases (plan downgrade timing, overage calculation, invoice immutability)
   - Error cases (invalid plan transitions, insufficient payment methods)

7. **Verify the app runs.** Start the app and test the new endpoints manually or with the generated tests.

## Verification

- [ ] Subscription management implemented (plan model, GET, PUT with proration)
- [ ] Usage tracking implemented (daily aggregates, current and historical endpoints)
- [ ] Invoice generation implemented (lifecycle, numbering, overage calculation)
- [ ] Payment methods implemented (CRUD with constraints)
- [ ] Unit tests written (at least 10 tests covering happy paths and edge cases)
- [ ] Application starts and endpoints respond correctly

---

Previous: [Phase 2: Technical Analysis](phase-2-analysis.md) | Next: [Phase 4: Test Specs and Pipeline](phase-4-tests-pipeline.md)
