# Stage 3: Make the Architecture Reviewable

**Duration:** 90-105 minutes

**Focus:** Azure target architecture, integration contract, and concise decisions

## Objective

Produce enough architecture detail for security, operations, delivery, and source-system teams to review the same proposal. The diagrams, contract, and ADRs should agree with one another.

## Tasks

1. **Copy the remaining templates.** Create:
   - `deliverables/architecture-containers.mmd`
   - `deliverables/integration-contract.yaml`
   - three or four ADR files under `deliverables/adrs/`

2. **Design the Azure container view.** Select managed Azure services only after matching each responsibility to a need. Compare services such as Azure API Management, Azure Service Bus, Azure Event Grid, Azure Functions, Azure Container Apps, Azure Data Factory, Azure Data Lake Storage, Microsoft Entra ID, Azure Key Vault, and Azure Monitor where they fit.

3. **Show more than the happy path.** The container diagram must include:
   - retained HPC and NMN systems
   - synchronous and asynchronous paths
   - identity and trust boundaries
   - contract or schema governance
   - dead-letter or failed-message handling
   - logs, metrics, traces, and audit evidence
   - analytical or reporting flow
   - data authority labels

4. **Write one integration contract.** Choose the linked customer query or order lifecycle flow. Complete every field in the template. Make authority, identity type, idempotency, compatibility, observability, privacy, and degraded behavior testable.

5. **Use the Contract Reviewer agent.** Give it the contract plus the relevant incidents, NFRs, and volume row. It should identify missing behavior and contradictions. Refine the brief if it focuses on naming or formatting instead of runtime and ownership risk.

6. **Write three or four ADRs.** Keep each ADR to one decision. Across the set, cover the most consequential choices in:
   - customer and identity boundary
   - API, event, or replication pattern
   - reporting and reconciliation path
   - transition or source-system retirement, if needed

7. **Make Azure choices traceable.** Each service shown must have a responsibility, owner, SLO implication, security boundary, and operational signal. Remove decorative services.

8. **Check cross-artifact consistency.** Names, authorities, contract versions, identity types, and failure behavior should match across the boundary map, diagrams, contract, and ADRs.

9. **Run the validator.** It may still fail because the roadmap is incomplete, but the Mermaid, ADR, and contract findings for this stage should be clear.

## Required Output

- `deliverables/architecture-context.mmd`
- `deliverables/architecture-containers.mmd`
- `deliverables/integration-contract.yaml`
- three or four files in `deliverables/adrs/`

## Verification

- [ ] The context and container diagrams serve different purposes
- [ ] Every Azure service has a stated responsibility
- [ ] Managed identity and secret handling are visible
- [ ] Seller workforce authorization remains isolated
- [ ] Failure handling and operational visibility are shown
- [ ] The contract names authority, compatibility, privacy, and degraded behavior
- [ ] ADR options use consistent comparison criteria
- [ ] No ADR combines unrelated decisions
- [ ] Diagram, contract, and ADR terminology agrees

---

Previous: [Stage 2: Choose Boundaries and Patterns](stage-2-boundaries.md) | Next: [Stage 4: Sequence the Transition](stage-4-roadmap.md)
