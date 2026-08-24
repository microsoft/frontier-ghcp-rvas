# Stage 2: Set the Platform Standard

**Difficulty:** ⭐⭐⭐ | **Time:** 75-90 min

Turn the inventory into decisions that a service owner can apply and a reviewer
can test. A preference is not a standard until its scope, exception path, and
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
   notification and support expectations without inventing dates that are not
   supported by the scenario.
5. Create normalized contract proposals under `contracts/proposals/`. Keep the
   service capabilities intact. The proposals should show how each existing
   API would look at the platform boundary, not replace the service code.
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

## What Copilot Helps With vs. What Requires Your Judgment

Copilot can find gaps between the documents and flag inconsistent wording. It
cannot decide the support window your organization can honor or which
exceptions are worth carrying. Those decisions need owners and evidence.

---

Previous: [Stage 1: Inventory Consumer Risk](stage-1-inventory-consumer-risk.md) | Next: [Stage 3: Build Enforceable Guardrails](stage-3-build-enforceable-guardrails.md)
