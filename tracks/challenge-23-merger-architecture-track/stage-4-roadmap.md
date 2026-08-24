# Stage 4: Sequence the Transition

**Duration:** 60-75 minutes

**Focus:** Delivery waves, transition states, risks, rollback, and decision gates

## Objective

Turn the target into a path that the merged company can fund and operate. Show how authority, user experience, and integration paths change between now and the target.

## Tasks

1. **Copy the roadmap template.** Create `deliverables/migration-roadmap.md`.

2. **Define transition states.** Include the current state, at least two intermediate states, and the target. For each state, name:
   - customer or staff experience
   - active systems
   - data authority
   - integration path
   - reconciliation need
   - rollback position

3. **Build delivery waves.** Wave 1 must fit the 90-day sponsor expectation. Each wave needs a business outcome, scope, dependencies, entry criteria, measurable exit conditions, rollback trigger, and owner.

4. **Respect organizational constraints.** Account for the HPC holiday freeze, NMN month-end protection, six-person architecture and engineering team, separate source-system teams, and the first combined financial close.

5. **Plan dual running.** State where two paths or stores operate together, how results reconcile, who investigates differences, and when dual running ends.

6. **Plan retirement evidence.** A source or integration path can retire only after recovery drills, contract adoption, observability coverage, data reconciliation, and business acceptance meet named thresholds.

7. **Build the risk register.** Include risks from customer matching, authorization, schema drift, duplicate events, stale reads, reporting corrections, regional data handling, source-team capacity, and cutover timing.

8. **Run the Transition Risk skill.** Apply it to each wave. Reject any wave without independent rollback or measurable exit conditions. Refine the skill if it checks task completion but misses business continuity.

9. **Review stakeholder priorities.** Show which wave answers each stakeholder's main concern. Mark unresolved priority conflicts as decisions, not hidden assumptions.

10. **Run final validation.**

```bash
cd challenges/challenge-23-merger-architecture
./scripts/validate.sh
```

Fix structural findings. Then perform a human review for architectural coherence, because a script cannot determine whether a boundary or migration choice is responsible.

## Required Output

Complete `deliverables/migration-roadmap.md` and make any final consistency updates to the other artifacts.

## Verification

- [ ] Wave 1 has a useful outcome achievable within 90 days
- [ ] At least two transition states precede the target
- [ ] Every wave has entry, exit, rollback, and ownership
- [ ] Dual-running reconciliation has an owner and end condition
- [ ] Source retirement depends on measured evidence
- [ ] Stakeholder priorities are mapped to waves or open decisions
- [ ] Risks include technical, compliance, operational, and organizational concerns
- [ ] The Transition Risk skill changed or confirmed each wave
- [ ] `./scripts/validate.sh` passes
- [ ] A reviewer can trace every major Azure component to a boundary, contract, ADR, and roadmap wave

---

Previous: [Stage 3: Make the Architecture Reviewable](stage-3-architecture.md) | Next: [Track Overview](../challenge-23-merger-architecture-track.md)
