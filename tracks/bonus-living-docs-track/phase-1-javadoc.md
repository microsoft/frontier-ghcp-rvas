# Phase 1: Javadoc Generation

[Back to Living Documentation Track](../bonus-living-docs-track.md)

**Duration:** 1.5-2 hours

**Focus:** Generating accurate, comprehensive javadoc for all classes and public methods

## Tasks

1. **Audit the existing documentation.** Go through each Java file and note what already has javadoc (even if it is stale or incomplete) vs. what has none. The `Product` class has a stub; everything else is bare.

2. **Generate javadoc for domain classes.** Start with `Product.java`, `Order.java`, and `OrderLine.java`. For each class, ask Copilot to explain the class based on how it is used in the controllers, then write javadoc that reflects actual behavior. Pay attention to:
   - Class-level documentation explaining the business purpose
   - Field descriptions (what each field represents, valid values, units where applicable)
   - Enum documentation (the `Order.Status` enum and its state machine)

3. **Generate javadoc for controllers.** For each controller (`OrderController`, `ProductController`, `InventoryController`), document:
   - Class-level: what domain it manages, what API group it belongs to
   - Method-level: HTTP method, path, parameters, return type, possible error responses
   - Business rules embedded in the code (discount tiers, tax rate, shipping thresholds, state transition rules)

4. **Fix the stale Product javadoc.** The existing `@author` and `@since` tags reference a version that predates half the current fields. Update it to reflect the current state.

5. **Validate accuracy.** For at least 3 methods, read the code line-by-line and verify that the generated javadoc matches the actual behavior. Copilot sometimes generates javadoc based on what a method *should* do rather than what it *actually* does.

## Verification

- [ ] All 3 domain classes have complete class-level and field-level javadoc
- [ ] All 3 controllers have class-level and method-level javadoc
- [ ] Business rules documented in javadoc (discount tiers, state machine, tax rate)
- [ ] Stale Product javadoc updated
- [ ] At least 3 methods independently verified for accuracy

---

Next: [Phase 2: Architecture Diagrams](phase-2-diagrams.md)
