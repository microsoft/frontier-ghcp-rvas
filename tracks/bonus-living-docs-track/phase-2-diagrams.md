# Phase 2: Architecture Diagrams

[Back to Living Documentation Track](../bonus-living-docs-track.md)

**Duration:** 1-1.5 hours

**Focus:** Creating Mermaid diagrams for system architecture, data model, and key workflows

## Tasks

1. **Create a system architecture diagram.** A high-level Mermaid diagram showing the components: HTTP clients, controllers, database, and any external systems. Show the data flow between them.

2. **Create an entity-relationship diagram.** Read the SQL schema (or infer it from the `JdbcTemplate` queries in the controllers) and produce a Mermaid ERD showing all tables, columns, and relationships.

3. **Create a sequence diagram for order creation.** Trace the full flow of creating an order: HTTP request, stock validation, discount calculation, tax calculation, shipping calculation, database inserts (orders + order lines), and stock deduction. Include error paths (product not found, insufficient stock).

4. **Create a state diagram for orders.** The order status transitions are defined in `OrderController.updateStatus()`. Produce a Mermaid state diagram showing all valid transitions: PENDING to CONFIRMED, CONFIRMED to SHIPPED, etc. Include the restock-on-cancellation side effect.

5. **Assemble an architecture document.** Create `docs/architecture.md` in the challenge folder with all diagrams, a component description section, and a data model narrative.

## Verification

- [ ] System architecture diagram created (Mermaid, shows all components)
- [ ] Entity-relationship diagram created (all tables and relationships)
- [ ] Order creation sequence diagram created (includes error paths)
- [ ] Order state machine diagram created (all valid transitions)
- [ ] Architecture document assembled with all diagrams

---

Previous: [Phase 1: Javadoc Generation](phase-1-javadoc.md) | Next: [Phase 3: Changelog and Release Notes](phase-3-changelog.md)
