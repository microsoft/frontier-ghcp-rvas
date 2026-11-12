# Stage 2: Set the platform standard

**Difficulty:** ⭐⭐⭐ | **Time:** 75-90 min

Turn the inventory into decisions a service owner can apply and a reviewer can
test. A preference becomes a standard once its scope, exception path, and
compatibility effect are clear.

## Tasks

1. Copy the relevant templates into `deliverables/`. Write
   `api-standards.md`, `review-checklist.md`, and
   `versioning-deprecation.md`.
2. Define rules for resource and property naming, operation IDs, pagination,
   error responses, version placement, Microsoft Entra ID, authorization
   boundaries, correlation, and minimum documentation.
3. State which rules are mandatory, advisory, or eligible for an exception.
   Give every exception an owner, reason, review date, and consumer impact.
4. Define compatible, breaking, deprecated, sunset, and retired states. Set
   notification and support expectations. Don't invent dates the scenario
   doesn't support.
5. Create normalized contract proposals under `contracts/proposals/`. Each
   shows how an existing API would look at the platform boundary. Keep the
   service capabilities intact; a proposal doesn't replace service code.
6. For each proposal, add a short decision record under
   `deliverables/decisions/`. Explain contract changes, compatibility class,
   consumer migration work, and any unresolved exception.
7. Review the proposals with the API Governance Reviewer and API Lifecycle
   Reviewer. Resolve disagreements by citing the inventory and written
   standard.

## Verification

- Every rule in the checklist points to a section in the standards
- The identity section distinguishes authentication from authorization and
  uses Microsoft Entra ID
- The lifecycle policy covers announcement, deprecation, sunset, retirement,
  emergency changes, and exceptions
- All proposal files pass `npm run validate:openapi`
- Proposals preserve the source APIs' business capabilities
- Each breaking proposal includes a consumer migration obligation
- The documents make clear that product teams still own implementation

## What Copilot helps with vs. what requires your judgment

Copilot can find gaps between the documents and flag inconsistent wording. It
can't decide the support window your organization can honor or which
exceptions are worth carrying. Those calls need owners and evidence.

---

Previous: [Stage 1: Inventory Consumer Risk](stage-1-inventory-consumer-risk.md) | Next: [Stage 3: Build Enforceable Guardrails](stage-3-build-enforceable-guardrails.md)
