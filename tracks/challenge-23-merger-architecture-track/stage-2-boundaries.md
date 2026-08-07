# Stage 2: Choose Boundaries and Patterns

**Duration:** 60-75 minutes

**Focus:** Integration pattern comparison, target responsibilities, and failure boundaries

## Objective

Turn the current-state map into target boundaries. Compare realistic integration patterns against the same criteria before selecting a direction.

## Tasks

1. **Select the flows that need explicit treatment.** Include:
   - customer search and linked profile
   - identity sign-in and identity linking
   - order-history query
   - order and refund state changes
   - consent propagation
   - combined finance reporting

2. **Compare patterns for each flow.** Consider synchronous API composition, asynchronous event propagation, batch or analytical integration, and controlled replication. Compare:
   - business freshness need
   - availability coupling
   - source authority
   - volume and payload
   - replay, ordering, and correction behavior
   - privacy and retention
   - change ownership
   - transition reversibility

3. **Define target responsibilities.** Decide which boundary is responsible for linking identities, composing customer views, normalizing order history, governing contracts, reconciling reports, and exposing operational status. Do not assign responsibility to a generic "integration layer."

4. **Separate query from state change.** A combined read model may be useful without becoming the source of truth. State which commands still return to source systems and how the user sees partial or stale results.

5. **Model failure behavior.** Use the incident evidence to decide where idempotency, deduplication, dead-letter handling, schema compatibility, source fallback, and freshness indicators belong.

6. **Choose what not to unify.** Record capabilities, identities, or data that stay separate in the target. Explain the reason in terms of ownership, risk, or business meaning.

7. **Draft the context diagram.** Copy `templates/architecture-context.mmd` to `deliverables/architecture-context.mmd`. Show people, the combined-company boundary, retained systems, and external dependencies. Avoid Azure service detail here.

8. **Re-run the Boundary Analyst agent.** Check whether each proposed boundary has one clear responsibility and an accountable owner. Refine the agent if it rewards maximum consolidation instead of clear ownership.

9. **Identify ADR candidates.** Pick three or four decisions that would be expensive or confusing to reverse. Good candidates have competing options and evidence on both sides.

## Required Output

Update the capability map and context diagram. Add a short pattern comparison section to the capability map or a clearly linked companion section in the same file.

## Verification

- [ ] All six flows use an explicitly selected integration pattern
- [ ] Pattern choices refer to evidence, volumes, SLOs, and failure behavior
- [ ] Query models are not silently promoted to systems of record
- [ ] Identity linking does not merge authorization boundaries
- [ ] At least one capability is intentionally kept separate
- [ ] The context diagram names people, external systems, and the combined boundary
- [ ] Three or four ADR candidates are identified

---

Previous: [Stage 1: Map the Merger](stage-1-map.md) | Next: [Stage 3: Make the Architecture Reviewable](stage-3-architecture.md)
