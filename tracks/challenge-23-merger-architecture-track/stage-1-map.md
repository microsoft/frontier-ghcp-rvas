# Stage 1: Map the Merger

**Duration:** 60-75 minutes

**Focus:** Capabilities, current systems, constraints, authority, and ownership

## Objective

Build a shared picture of what the two organizations actually own. The output is not a target architecture. It is a map of capabilities, authority, conflicts, and boundaries that the target must respect.

## Tasks

1. **Create the working directory.** Copy the capability map template into `deliverables/`. Create `deliverables/adrs/` for later stages.

2. **Read the evidence as claims, not truth.** Mark each important statement as:
   - observed in a system or contract
   - stated by a stakeholder
   - required by policy or an SLO
   - assumed because evidence is missing

3. **Map capabilities to systems.** Cover customer profile, consent, identity, order management, refunds, reporting, and seller administration. For each one, record:
   - current systems and organizations
   - present data authority
   - operational owner
   - overlap or mismatch
   - merger pressure

4. **Resolve nouns that hide different meanings.** Compare retail customer, marketplace buyer, seller workforce member, retail order, marketplace order, refund, revenue, and settlement. State where a shared term is safe and where it would erase a necessary distinction.

5. **Work through every ownership conflict.** Assign a decision owner and deadline. If you defer a decision, state the transition rule that keeps work safe until it is made.

6. **Extract constraints.** Add the NFRs, compliance rules, volumes, SLOs, release windows, and staffing limits that can change an architecture choice. Do not keep a generic list. Link each constraint to a capability or flow.

7. **Draft boundary rules.** Write a small set of rules that later diagrams and contracts must obey. Include identity types, authorization, data authority, consent, reporting corrections, and source-system independence.

8. **Use the Boundary Analyst agent.** Ask it to inspect the map for collapsed responsibilities, ambiguous ownership, and unsupported assumptions. Keep findings that point to evidence. Reject generic suggestions.

9. **Refine the Customization Trio.** Update repository instructions if Copilot assumes implementation work or ignores evidence provenance. Tighten the Boundary Analyst brief if it only repeats the inventory. Record what the Transition Risk skill will need from the future roadmap.

## Required Output

Complete `deliverables/capability-boundary-map.md` with:

- all required capabilities and current systems
- proposed boundary direction without selecting Azure services
- current and transition data authority
- accountable owners and decision deadlines
- explicit boundary rules
- assumptions and open questions

## Verification

- [ ] Every system in the inventory appears in the map or is explicitly out of scope
- [ ] Customer, buyer, and seller workforce identities are not treated as one role
- [ ] All ownership conflicts have an owner and a resolution or deferral rule
- [ ] At least six constraints are linked to affected flows
- [ ] Reporting distinguishes operational revenue from settlement or correction timing
- [ ] Boundary Analyst findings were accepted or rejected with a reason
- [ ] No Azure service choice is presented as the reason for a business boundary

---

Previous: [Stages](stages.md) | Next: [Stage 2: Choose Boundaries and Patterns](stage-2-boundaries.md)
