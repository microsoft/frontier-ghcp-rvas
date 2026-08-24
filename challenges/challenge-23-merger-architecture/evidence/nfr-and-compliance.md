# Non-Functional and Compliance Evidence

## Security and identity

- Customer-facing traffic requires TLS in transit and encryption at rest.
- Workload access must use Microsoft Entra ID and managed identities where the Azure service supports them.
- Seller workforce authorization must preserve the NMN tenant boundary. A retail support role cannot inherit seller administration access.
- Production secrets cannot be stored in source files, diagrams, or contract examples.
- Privileged changes require named approval and an auditable record.

## Privacy and records

- Customer profile and consent data includes records from the European Economic Area, United Kingdom, and United States.
- A deletion request must be traceable across linked identities and downstream analytical copies.
- Consent cannot be inferred from an account match.
- Finance records have a seven-year retention period.
- Identity security logs have a one-year retention period.
- Customer support search logs have a 90-day retention period unless attached to an investigation.
- Cross-region replication of personal data needs a documented purpose and approved region pair.

## Operational constraints

- HPC can tolerate at most 30 minutes of read-only customer support during a planned change.
- NMN seller operations cannot have a planned outage during the final five business days of a month.
- Both organizations need independent rollback until the first combined financial close succeeds.
- Integration components must expose correlation identifiers, source system, contract version, processing outcome, and retry count.
- Poison messages must be isolated without blocking unrelated customers or orders.
- Recovery drills are required before a source system is retired.

## Cost and delivery

- The first 90-day wave has a fixed platform budget. Prefer a small number of managed Azure services over a bespoke integration runtime.
- The architecture team has six engineers. Two are available for identity work, two for integration, one for data, and one for platform controls.
- Existing systems keep their current teams through the first two waves. Ownership consolidation starts only after transition support is measurable.
