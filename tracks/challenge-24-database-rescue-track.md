# Challenge 24 Track: Peak-Load Database Rescue

**Duration:** 4-6 hours

**Difficulty:** ⭐⭐⭐

**Focus:** Diagnosing a SQL Server 2022 workload, reducing measured query cost,
and shipping an Azure SQL-compatible schema change without breaking active
readers or writers

## Who Is This For

- Database administrators responsible for SQL Server or Azure SQL
- Database reliability engineers who investigate load-related incidents
- Senior data platform engineers who review indexing and migration safety
- Operations engineers who need useful database evidence and recovery steps

This is a database rescue, not an application rewrite. The transaction model
and query result contracts stay in place. Your job is to make the database
behave predictably under load and leave the next on-call DBA with enough
evidence to operate it.

## Prerequisites

- Comfortable reading T-SQL, joins, aggregates, and transaction boundaries
- Working knowledge of clustered and nonclustered indexes
- Familiarity with actual execution plans, logical reads, CPU, and elapsed time
- Docker for the optional local SQL Server runtime
- An Azure SQL database only if you want to perform the optional target check

> ⚠️ SQL Server 2022 Linux containers publish an `amd64` image. The supplied
> Compose file requests that architecture explicitly. Docker Desktop can often
> emulate it on ARM hosts, but the challenge does not assume that emulation is
> available. `scripts/validate.sh` is the portable fallback: it parses every
> authoritative T-SQL artifact, validates evidence fixtures, and runs the
> verifier tests without starting a database.

## Technology Stack

- **SQL Server 2022 Developer** -- optional local runtime in Docker
- **Azure SQL Database** -- optional compatibility and deployment target
- **T-SQL** -- schema, workload, tuning, migration, and monitoring scripts
- **SQLFluff with the T-SQL dialect** -- portable parser validation
- **Python 3.12** -- artifact and evidence consistency checks
- **VS Code SQL Server extension** -- query execution and plan inspection

## Getting Started

Follow the [common setup steps](getting-started.md) first. Draft your own
repository instructions, custom agents, and custom skills before tuning the
workload.

### Open and Inspect the Challenge

Work in
[`challenges/challenge-24-database-rescue/`](../challenges/challenge-24-database-rescue/).
Start with `meta.yml`, `contracts/migration-contract.json`, the schema and seed
scripts, then the workload and supplied evidence. Do not jump to index creation
until you can explain what the baseline says.

The track has its own devcontainer at
`.devcontainer/challenge-24-database-rescue/devcontainer.json`. It installs
Python, Docker access, SQLFluff, the SQL Server extension, and the challenge
verification tools.

Run the portable checks first:

```bash
cd challenges/challenge-24-database-rescue
bash scripts/validate.sh
```

If Docker can run the SQL Server 2022 image, build and execute the authoritative
schema, seed, and slow workload locally:

```bash
bash scripts/run-local-sqlserver.sh
```

Keep the work local through the first three stages. Azure SQL validation is an
optional final check, not a prerequisite.

### Repository Instructions for This Track

Your `.github/copilot-instructions.md` should capture stable database rules:

- SQL Server 2022 syntax with Azure SQL Database as the target compatibility
  boundary
- Required result contracts for Q1 through Q4
- Evidence before tuning: compare logical reads, CPU, elapsed time, row count,
  and plan shape
- Short transactions, rerunnable deployment scripts, and no SQL Server Agent
  dependency
- The compatibility window from `migration-contract.json`
- No destructive contract step until reconciliation passes
- No generated index or hint accepted without a measured reason and a stated
  write or storage cost

Write the rules in your own words. They should guide review without prescribing
the answer.

### Suggested Custom Agents

- **Query Plan Reviewer** -- Reviews one query, its plan, and before/after
  measurements. It should identify likely causes and challenge unsupported
  tuning claims, but it should not rewrite the query. Use it after the first
  baseline and again when a plan changes.
- **Migration Safety Reviewer** -- Reviews the migration contract and one
  proposed deployment sequence. It should focus on compatibility, lock
  duration, resumability, and data loss paths. Use it before running the expand
  step and before approving the contract step.
- **Database Incident Reviewer** -- Reads the runbook and evidence as if taking
  over during peak load. It should flag missing thresholds, vague stop
  conditions, and recovery steps that depend on the original author.

### Suggested Custom Skills

- **Query Evidence Loop** -- Repeats the same controlled cycle for one query:
  establish conditions, capture reads and timing, inspect the plan, change one
  variable, rerun, and record the comparison. It should stop when the result
  contract changes or the evidence is inconclusive.
- **Online Migration Rehearsal** -- Walks through expand, bounded backfill,
  old/new writer checks, reconciliation, contract gating, and rollback. It
  should record each gate rather than assuming a successful script means a
  safe deployment.
- **Peak-Load Triage Capture** -- Collects blocking, expensive request, wait,
  index usage, and migration progress evidence in a fixed order while avoiding
  expensive monitoring queries during an incident.

## Tips for Using Copilot on This Track

- Give Copilot the query, plan, and measurements together. A query without its
  evidence invites generic indexing advice.
- Ask for two or three plausible causes, then make it rank them by the supplied
  evidence. Do not let the first plausible answer become the diagnosis.
- Keep one controlled change per measurement pass. Query rewrites, new indexes,
  statistics updates, and hints all at once make the result hard to defend.
- Make Copilot state which operator, estimate error, predicate, or lookup its
  suggestion addresses.
- Ask what an index costs on order inserts and payment writes before keeping it.
- Treat online index syntax as a service-tier assumption that needs validation,
  not a portable guarantee.
- For migration work, test old and new readers and writers separately. A clean
  backfill says nothing about write-path compatibility.
- Have someone other than the author follow the runbook. Ambiguity shows up
  quickly when the database is already under pressure.

## Resources

- [Copilot Guide](../docs/copilot-guide.md)
- [Prompt Engineering Guide](../docs/prompt-engineering.md)
- [Troubleshooting Guide](../TROUBLESHOOTING.md)
- [Facilitator Guide](../FACILITATOR_GUIDE.md)
- [SQL Server execution plans](https://learn.microsoft.com/sql/relational-databases/performance/execution-plans)
- [Azure SQL performance guidance](https://learn.microsoft.com/azure/azure-sql/database/performance-guidance)
- [Online index operations](https://learn.microsoft.com/sql/relational-databases/indexes/perform-index-operations-online)

---

Next: [Stages](challenge-24-database-rescue-track/stages.md)
