# Stage 1: Inventory Consumer Risk

**Difficulty:** ⭐⭐ | **Time:** 60-75 min

The three services all run, but their contracts disagree in ways that leak
into client code and operations. Build the evidence before deciding which
convention wins.

## Tasks

Use the full customization trio early in this stage. Keep repository
instructions open while you work, use the Contract Comparison skill for the
first inventory pass, and give the API Governance Reviewer both the contracts
and consumer notes. Check its findings against the files instead of accepting
the report as fact.

1. Run `npm test` from `challenges/challenge-25-api-guardrails/`. Confirm that
   OpenAPI parsing, APIM XML parsing, and all three mock smoke tests pass.
2. Start the mocks with `npm run mocks`. Exercise the documented endpoints and
   compare the response shapes, headers, identity behavior, and pagination
   with their OpenAPI contracts.
3. Run `npm run check:contracts:baseline`. Group the findings by naming,
   pagination, error shape, versioning, identity, and observability.
4. Read `evidence/platform-brief.md` and `evidence/consumer-notes.md`. Connect
   each material inconsistency to a consumer cost, operational blind spot, or
   migration risk.
5. Create `deliverables/inventory.md`. Include a contract comparison table,
   risk rating, affected consumers, evidence location, and recommended order
   of decision. Separate verified behavior from assumptions.
6. Mark issues that belong to service owners rather than the platform. Do not
   propose rebuilding any service.

## Verification

- `npm test` passes without an Azure connection
- Each source contract and mock endpoint appears in the inventory
- The six required inconsistency areas have concrete evidence
- Every high-risk item names the consumer or operator impact
- The inventory distinguishes contract problems, runtime policy gaps, and
  documentation gaps
- No recommendation depends on changing application business logic

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can compare large contracts quickly and organize repeated differences.
You decide whether a difference is harmful, which consumers pay for it, and
whether the platform can govern it without taking ownership from a service
team.

---

Previous: [Stages](stages.md) | Next: [Stage 2: Set the Platform Standard](stage-2-set-platform-standard.md)
