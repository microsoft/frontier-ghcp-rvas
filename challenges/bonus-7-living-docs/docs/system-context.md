# Widget Corp Inventory Manager -- System Context

Widget Corp is a fictional wholesale distributor that manages a catalog of industrial widgets and parts. This application handles product catalog management, stock tracking, order processing, and inventory reporting.

The system was built incrementally over several years. The original developer wrote some javadoc in v1.0, but most code added after that has none. The changelog has not been updated since v2.0, despite significant feature additions in v2.3 (warehouse transfers, stock movements) and v2.5 (volume discounts, reorder reports). Architecture diagrams were drawn on a whiteboard during a planning session in 2020 and never digitized.

## What Needs Documenting

- **Javadoc**: Most classes and methods lack javadoc. The Product class has a stub from v1.0 that says "Represents inventory item" without explaining the fields. Order, OrderLine, and all controllers have no javadoc.
- **Architecture diagrams**: No diagrams exist. The system has 4 controllers, 3 domain classes, and uses a relational database.
- **API documentation**: No OpenAPI spec, no endpoint listing. Consumers discover endpoints by reading the source.
- **Business rules**: Volume discount tiers, order state machine, tax calculation, shipping rules, and reorder thresholds are embedded in code with no external documentation.
- **Changelog**: Stale since 2021. Missing v2.3 and v2.5 entries.
- **Data model**: No ERD or schema documentation.

## Technology Stack

- Java 17, Spring Boot 3.x
- H2 in-memory database (development)
- JdbcTemplate for data access
- No ORM, no service layer (controllers talk directly to the database)
